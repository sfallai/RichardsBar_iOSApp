//
//  ViewParentSubClass.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/24/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "NavigationControllerSubClass.h"
#import "IDSongToolBar.h"
#import "IDSongButton.h"
#import "Utilities.h"
#import "MyPlaylistsViewController.h"
#import "AppDelegate.h"

@implementation NavigationControllerSubClass {
    Utilities *u;
    AppDelegate *ad;
    float smokeAlpha;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) createSmokeOverlay {
    //self.topViewController.view.backgroundColor = [UIColor blackColor];
    //initialize the instance of UIEffectDesignerView with the .ped we created earlier
    _effectView = [UIEffectDesignerView effectWithFile:@"smoke.ped" withBirthRate:ad.birthRate];
    
    //you can adjust the alpha of the effect to make it more or less pronounced
    _effectView.alpha = ad.smokeAlpha;
    
    //add the effect to the screen
    [self.view addSubview:_effectView];

}

-(void) viewWillAppear:(BOOL)animated  {
    [self createCommonToolbar];
    [self getSmokeOverlayAlpha];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SmokeEffects"]) {
        if(![self.view.subviews containsObject:_effectView]) {
            [self createSmokeOverlay];
        }
    } else {
        [_effectView removeFromSuperview];
    }
    
    
}

-(void) createCommonToolbar {
    //add a common toolbar for every view
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIImage* buttonImage = [UIImage imageNamed:@"audiowave"];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:buttonImage style:UIBarButtonItemStylePlain target:self action:@selector(btnIDSong_Click:)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    UIBarButtonItem *info = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(btnShowSettings_Click:)];
    
    //add the buttons to the toolbar
    [toolbar setItems:[[NSArray alloc] initWithObjects:settings, spacer, button, spacer, info, nil] animated:YES];
    
    //set the toolbar appearance
    toolbar.barTintColor = [UIColor blackColor];
    toolbar.translucent = YES;
    [toolbar setTintColor:[UIColor redColor]];

    [self.view addSubview:toolbar];
    
}

-(void) btnShowSettings_Click: (id) sender {
    [self performSegueWithIdentifier:@"showSettingsSegue" sender:self];
}

-(void) btnIDSong_Click: (id) sender {
    UIViewController *vc = [self.viewControllers objectAtIndex:(self.viewControllers.count - 1)];
    
    if(![NSStringFromClass([vc class]) isEqualToString:@"IDSongResult"]) {
        [self performSegueWithIdentifier:@"idSongResultSegue" sender:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    u = [[Utilities alloc] init];
    ad = [[UIApplication sharedApplication] delegate];
    
    self.navigationBar.barTintColor = [UIColor blackColor];
    
    //set a timer to check what time it is and change the smokeAlpha used to generate the smoke effects based on hour
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setSmokeOverlayAlpha) userInfo:nil repeats:YES];
}

-(float) getSmokeOverlayAlpha {
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    timeFormatter.dateFormat = @"HH";
    
    int hour = [[NSUserDefaults standardUserDefaults] boolForKey:@"ProgressiveSmoke"] ? [[timeFormatter stringFromDate: [NSDate date]] intValue] : 20;
    
    //as the night gets later the display gets smokier
    switch (hour) {
        case 21:
            ad.smokeAlpha = 0.5;
            break;
            
        case 22:
            ad.smokeAlpha = 0.6;
            break;
            
        case 23:
            ad.smokeAlpha = 0.7;
            break;
            
        case 0:
            ad.smokeAlpha = 0.8;
            break;
            
        case 1:
            ad.smokeAlpha = 0.9;
            break;
            
        case 2:
        case 3:
        case 4:
        case 5:
            ad.smokeAlpha = 1.0;
            break;
            
        default:
            ad.smokeAlpha = 0.4;
            
            break;
    }

    return ad.smokeAlpha;
    
}

-(void) setSmokeOverlayAlpha {
    float newAlpha = [self getSmokeOverlayAlpha];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SmokeEffects"] && [[NSUserDefaults standardUserDefaults] boolForKey:@"ProgressiveSmoke"]) {
        if(smokeAlpha != newAlpha) {
            smokeAlpha = newAlpha;
            [_effectView removeFromSuperview];
            [self createSmokeOverlay];
        }
    }
}


@end
