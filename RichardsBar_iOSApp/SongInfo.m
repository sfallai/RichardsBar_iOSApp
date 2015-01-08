//
//  SongInfo.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/5/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "SongInfo.h"
#import "JukeboxContent.h"
#import "disc.h"
#import "track.h"

@interface SongInfo () {
    JukeboxContent *jc;
}

@end

@implementation SongInfo

@synthesize trackCode;

-(void) viewWillAppear:(BOOL)animated {
    [self initSettingsView];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(trackCode);
    [self doInit];
    
    UIView *rect = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    UIImageView *img = [[UIImageView alloc] initWithFrame:rect.bounds];
    [img setImage:[UIImage imageNamed:@"0301lrg.jpg"]];
    
    [rect addSubview:img];
    [self.view addSubview:rect];
}

-(void) doInit {
    jc = [[JukeboxContent alloc] initWithJSONData];
    track *t = [self getTrackFromCode:trackCode];
    
    
    
}

-(track *) getTrackFromCode:(NSString *) code {
    NSString *discNum = [code substringToIndex:2];
    NSString *trackNum = [code substringFromIndex:2];
    
    disc *disc = [jc getDiscFromIndex:[discNum intValue] - 1];
    track *track = [disc.tracks objectAtIndex:[trackNum intValue] - 1];
    
    return track;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [topBar setBackgroundColor:[UIColor blackColor]];
    [topBar setAlpha:.8];
    
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
