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

@implementation NavigationControllerSubClass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) viewWillAppear:(BOOL)animated  {
    [self createCommonToolbar];
    
}

-(void) createCommonToolbar {
    //add a common toolbar for every view
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    
    //
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    UIImage* buttonImage = [UIImage imageNamed:@"audiowave"];
    UIBarButtonItem *b = [[UIBarButtonItem alloc] initWithImage:buttonImage style:UIBarButtonItemStylePlain target:self action:@selector(btnIDSong_Click:)];

    
    //set button appearance
    [button setImage:buttonImage];
    
    //set button action
    [button setAction:@selector(btnIDSong_Click:)];
    
    //add the buttons to the toolbar
    [toolbar setItems:[[NSArray alloc] initWithObjects:spacer, b, spacer, nil] animated:YES];
    
    //set the toolbar appearance
    toolbar.barTintColor = [UIColor blackColor];
    toolbar.translucent = YES;
    [toolbar setTintColor:[UIColor redColor]];
    
    [self.view addSubview:toolbar];
}

-(void) btnIDSong_Click: (id) sender {
    [self performSegueWithIdentifier:@"idSongResultSegue" sender:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self setToolBarAppearance];
    
    
}


@end
