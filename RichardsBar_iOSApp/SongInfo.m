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

static NSInteger const kTagHeaderCell = 999;
static CGFloat const kHeightHeaderCell = 140.0f;


@interface SongInfo () <UITableViewDelegate, UITableViewDataSource> {
    JukeboxContent *jc;
    track *t;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageView;

@property (nonatomic, assign) CGFloat placeholderMinimumY;
@property (nonatomic, assign) CGPoint lastContentOffset;


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
    
    [self initAlbumCover];
    self.placeholderMinimumY = CGRectGetMinY(self.placeholderImageView.frame);
    
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    self.navigationController.navigationBar.translucent = YES;

    
}

-(void) initAlbumCover {
    UIView *rect = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self getAlbumImageHeight])];
    UIImageView *img = [[UIImageView alloc] initWithFrame:rect.bounds];
    //_placeholderImageView = img;
    //[_placeholderImageView setFrame:rect.bounds];
    //[_placeholderImageView setContentMode:UIViewContentModeScaleAspectFit];
    [_placeholderImageView setImage:[UIImage imageNamed:t.albumImgLarge]];
    
    //[rect addSubview:_placeholderImageView];
    //[self.view addSubview:rect];
}

-(float) getAlbumImageHeight {
    UIImage *img = [UIImage imageNamed:t.albumImgLarge];
    
    float w = img.size.width;
    float h = img.size.height;
    
    return (h / w) * self.view.frame.size.width;
    
}

-(void) doInit {
    jc = [[JukeboxContent alloc] initWithJSONData];
    t = [self getTrackFromCode:trackCode];
    
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
    
    //[self.view addSubview:topBar];
    [self.view addSubview:title];
    
}

-(void) closeSettings_Click {
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0f;
    }
    
    return 70.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kHeightHeaderCell;
    }
    
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    return blurView;
    
}

#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        cell.tag = kTagHeaderCell;

        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor colorWithRed:229.0f/255.0f green:241.0f/255.0f blue:1.0f alpha:1.0f] : [UIColor colorWithRed:255.0f/96.0f green:255.0f/110.0f blue:255.0f/127.0f alpha:1.0f];
    }
    
    return cell;
}



#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollDiff = self.lastContentOffset.y - scrollView.contentOffset.y;
    CGFloat originY = CGRectGetMinY(self.placeholderImageView.frame) + scrollDiff;
    
    BOOL contentMovingOffScreen = scrollView.contentOffset.y > 0.0f;
    
    __block UITableViewCell *headerCell;
    
    [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
        if (cell.tag == kTagHeaderCell) {
            *stop = YES;
            headerCell = cell;
        }
    }];
    
    if (contentMovingOffScreen) {
        CGFloat alpha = MAX(1 - (scrollView.contentOffset.y / kHeightHeaderCell), 0.0f);
        headerCell.alpha = alpha;
        
        if (alpha > 0.0f) {
            scrollView.clipsToBounds = NO;
            self.title = nil;
        } else {
            scrollView.clipsToBounds = YES;
            self.title = @"Title";
        }
        
        originY = CGRectGetMinY(self.placeholderImageView.frame);
    } else if (scrollDiff < 0.0f) {
        originY = MAX(originY, self.placeholderMinimumY);
    } else {
        originY = MIN(originY, 0.0f);
        headerCell.alpha = 1.0f;
    }
    
    CGRect newRect = CGRectMake(CGRectGetMinX(self.placeholderImageView.frame),
                                originY,
                                CGRectGetWidth(self.placeholderImageView.frame),
                                CGRectGetHeight(self.placeholderImageView.frame));
    
    self.placeholderImageView.frame = newRect;
    self.lastContentOffset = scrollView.contentOffset;
}


@end
