//
//  MyPlaylistsViewController.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/24/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "MyPlaylistsViewController.h"

@interface MyPlaylistsViewController ()

@end

@implementation MyPlaylistsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *currentVC = self.navigationController.visibleViewController;
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Your current view controller:" message:NSStringFromClass([currentVC class]) delegate:nil
                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
