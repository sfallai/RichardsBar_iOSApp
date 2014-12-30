//
//  SettingsViewController.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/29/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "SettingsViewController.h"
#import "Utilities.h"

@interface SettingsViewController () {
    Utilities *u;
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swSmokeEffects_Change:(id)sender {
    if([self.swSmokeEffects isOn]) {
        [self createSmokeOverlay];
    } else {
        [self removeSmokeOverlay];
    }
}

-(void) createSmokeOverlay {
    //self.topViewController.view.backgroundColor = [UIColor blackColor];
    //initialize the instance of UIEffectDesignerView with the .ped we created earlier
    _effectView = [UIEffectDesignerView effectWithFile:@"smoke.ped"];
    
    //you can adjust the alpha of the effect to make it more or less pronounced
    _effectView.alpha = .7;
    
    //add the effect to the screen
    [self.view addSubview:_effectView];
    
}

-(void) removeSmokeOverlay {
    [_effectView removeFromSuperview];
    
}

-(void) initSettingsView {
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
