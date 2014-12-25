//
//  ViewParentSubClass.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/24/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "NavigationControllerSubClass.h"
#import "IDSongToolBar.h"

@implementation NavigationControllerSubClass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) viewWillAppear:(BOOL)animated  {
    //add a common toolbar for every view
    IDSongToolBar *toolbar = [[IDSongToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    [self.view addSubview:toolbar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self setToolBarAppearance];
    
    
}

-(void) setToolBarAppearance {
    //UIButton *button = [[UIButton alloc] init];
    
    //[button setBackgroundColor:[UIColor whiteColor]];
    //button.layer.cornerRadius = 15;
    //[button setTitle:@"Something" forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:@"audiowave"] forState:UIControlStateNormal];
    
    //set click handler
    //[button addTarget:self action:@selector(btnIDSong_click:) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *barItemButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"audiowave"] landscapeImagePhone:[UIImage imageNamed:@"audiowave"] style:UIBarButtonItemStylePlain target:self action:nil];
    //UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [self setToolbarItems:[[NSArray alloc] initWithObjects:spacer, barItemButton, spacer, nil]];
    
}
-(IBAction)btnIDSong_click:(id)sender {
    
}

@end
