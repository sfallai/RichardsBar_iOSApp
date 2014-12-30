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
    _effectView = [UIEffectDesignerView effectWithFile:@"smoke.ped" withBirthRate:5];
    
    //you can adjust the alpha of the effect to make it more or less pronounced
    _effectView.alpha = .5;
    
    //add the effect to the screen
    [self.view addSubview:_effectView];

}

-(void) viewWillAppear:(BOOL)animated  {
    [self createCommonToolbar];

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
    
    //set a timer to check what time it is and change the smoke.ped file used to generate the smoke effects based on hour
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(setSmokeSettingFile) userInfo:nil repeats:YES];
}

-(void) setSmokeSettingFile {
    
    
}


@end
