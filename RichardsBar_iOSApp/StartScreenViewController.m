//
//  StartScreenViewController.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/22/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "StartScreenViewController.h"
#import "IDSongButton.h"
#import "IDSongToolBar.h"
@interface StartScreenViewController ()

@end

@implementation StartScreenViewController

-(void) viewWillAppear:(BOOL)animated {
//    UIToolbar *toolBar = [self createToolbar];
//    //[self.view addSubview:toolBar];
//    IDSongButton *button = [[IDSongButton alloc] init];
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    
//    UIImage* image3 = [UIImage imageNamed:@"audiowave"];
//    CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
//    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
//    [someButton addTarget:self action:@selector(sendmail)
//         forControlEvents:UIControlEventTouchUpInside];
//    [someButton setShowsTouchWhenHighlighted:YES];
//    
//    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
//    
//    UIToolbar *toolbar = [[UIToolbar alloc] init];
//    toolbar.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
//    NSMutableArray *items = [[NSMutableArray alloc] init];
//    [toolbar setItems:[[NSArray alloc] initWithObjects:mailbutton, nil ]];
//    //[toolbar setItems:items animated:NO];
//    [self.view addSubview:toolbar];

}

- (UIToolbar*)createToolbar
{
    IDSongToolBar* toolbar = [[IDSongToolBar alloc] init];
    toolbar.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sharePhoto:)];
    NSArray *buttonItems = [NSArray arrayWithObjects:shareButton,nil];
    [toolbar setItems:buttonItems];
    return toolbar;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
