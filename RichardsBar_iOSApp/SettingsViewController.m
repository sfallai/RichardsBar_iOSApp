//
//  SettingsViewController.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/29/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "SettingsViewController.h"
#import "Utilities.h"
#import "AppDelegate.h"

@interface SettingsViewController () {
    Utilities *u;
    AppDelegate *ad;
    BOOL smokeEffectState;
}

@end

@implementation SettingsViewController

-(void) viewWillAppear:(BOOL)animated {
    [self initSettingsView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    u = [[Utilities alloc] init];
    ad = [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swSmokeEffects_Change:(id)sender {
    if([self.swSmokeEffects isOn]) {
        smokeEffectState = YES;
        [self createSmokeOverlay];
    } else {
        smokeEffectState = NO;
        [self removeSmokeOverlay];
    }
    
    [self setProgressiveSmokeSwitchState];
    [self saveUserSettings];
}

-(void) getUserSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    smokeEffectState = [userDefaults boolForKey:@"SmokeEffects"];
    
}

-(void) saveUserSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:[self.swSmokeEffects isOn] forKey:@"SmokeEffects"];
    [userDefaults setBool:[self.swProgressiveSmoke isOn] forKey:@"ProgressiveSmoke"];
    [userDefaults synchronize];
    
}

-(void) setSettingsValues {
    if(smokeEffectState) {
        [self createSmokeOverlay];
    }
    
    [self setProgressiveSmokeSwitchState];
    
}

-(void) setProgressiveSmokeSwitchState {
    [self.swSmokeEffects setOn:smokeEffectState animated:YES];
    [self.swProgressiveSmoke setEnabled:[self.swSmokeEffects isOn]];
    [self.lblProgressiveSmoke setEnabled:[self.swSmokeEffects isOn]];

}

-(void) createSmokeOverlay {
    //self.topViewController.view.backgroundColor = [UIColor blackColor];
    //initialize the instance of UIEffectDesignerView with the .ped we created earlier
    _effectView = [UIEffectDesignerView effectWithFile:@"smoke.ped" withBirthRate:2];
    
    //you can adjust the alpha of the effect to make it more or less pronounced
    _effectView.alpha = .7;
    
    //add the effect to the screen
    [self.view addSubview:_effectView];
    
}

-(void) removeSmokeOverlay {
    [_effectView removeFromSuperview];
    
}

-(void) initSettingsView {
    [self getUserSettings];
    [self setSettingsValues];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeSettings_Click)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //add the buttons to the toolbar
    [toolbar setItems:[[NSArray alloc] initWithObjects:spacer, btn, nil] animated:YES];
    
    //set the toolbar appearance
    toolbar.barTintColor = [UIColor blackColor];
    toolbar.translucent = YES;
    [toolbar setTintColor:[UIColor redColor]];
    
    [self.view addSubview:toolbar];
    
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [topBar setBackgroundColor:[UIColor blackColor]];
    [topBar setAlpha:.7];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40, 10, 80, 44)];
    title.text = @"Settings";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    
    //[topBar addSubview:title];

    [self.view addSubview:topBar];
    [self.view addSubview:title];
    
}

-(void) closeSettings_Click {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
