//
//  DefaultAppearanceViewController.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/29/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "DefaultAppearanceViewController.h"
#import "AppDelegate.h"

@interface DefaultAppearanceViewController () {
    Utilities *u;
    AppDelegate *ad;
}


@end

@implementation DefaultAppearanceViewController

-(void) viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    u = [[Utilities alloc] init];
    ad = [[UIApplication sharedApplication] delegate];
    
    [self initNavigationBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initNavigationBar {
    UIBarButtonItem *camera = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    
    NSArray *items = @[camera];
    
    self.navigationItem.rightBarButtonItems = items;
    self.navigationController.navigationBar.tintColor = [u colorWithHexString:@"64fcff"];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
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
