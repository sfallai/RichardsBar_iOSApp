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
#import "Utilities.h"
#import "SongDetailHeaderPrototypeCell.h"
#import "SongInfoDetailsPrototypeCell.h"
#import "AlphaGradientView.h"

static NSInteger const kTagHeaderCell = 999;
static CGFloat const kHeightHeaderCell = 140.0f;


@interface SongInfo () <UITableViewDelegate, UITableViewDataSource> {
    JukeboxContent *jc;
    track *t;
    Utilities *u;
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
    
    self.placeholderMinimumY = CGRectGetMinY(self.placeholderImageView.frame);
    
}

-(void) initAlbumImgGradient {
    AlphaGradientView* gradient = [[AlphaGradientView alloc] initWithFrame:
                                   CGRectMake(0, 0, self.view.frame.size.width, 150)];
    
    gradient.color = [UIColor purpleColor];
    [self.view addSubview:gradient];
}

-(void) initAlbumCover {
    _albumImg = [UIImage imageNamed:t.albumImgLarge];
    
    _placeholderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -75, self.view.frame.size.width, [self getAlbumImageHeight])];
    [_placeholderImageView setContentMode:UIViewContentModeScaleAspectFit];
    [_placeholderImageView setImage:_albumImg];
    
    [self.view addSubview:_placeholderImageView];
    [self.view addSubview:_gradient];
    
}

-(float) getAlbumImageHeight {
    UIImage *img = [UIImage imageNamed:t.albumImgLarge];
    
    float w = img.size.width;
    float h = img.size.height;
    NSLog(@"w:%f h:%f screenw: %f imgH:%f", w, h, self.view.frame.size.width, (h / w) * self.view.frame.size.width );
    
    return (h / w) * self.view.frame.size.width;
    
}

-(void) doInit {
    jc = [[JukeboxContent alloc] initWithJSONData];
    t = [self getTrackFromCode:trackCode];
    u = [[Utilities alloc] init];
    
    [self initAlbumImgGradient];
    [self initAlbumCover];
    [self initTableView];
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

-(void) initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 60) style: UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView reloadData];
    
    [self.view addSubview:_tableView];
    
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
    [topBar setBackgroundColor:[UIColor clearColor]];
    //[topBar setAlpha:.8];
    
    _topSongLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40, 10, 80, 44)];
    //title.text = @"Settings";
    _topSongLabel.text = t.song;
    _topSongLabel.textColor = [UIColor whiteColor];
    _topSongLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [_topSongLabel setAlpha:0.0];
    
    [topBar addSubview:_topSongLabel];
    
    [self.view addSubview:topBar];
    //[self.view addSubview:title];
    
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
    
    return 700.0f;
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
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"HeaderCell";
        
        SongDetailHeaderPrototypeCell *cell = (SongDetailHeaderPrototypeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SongInfoHeaderPrototypeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    
        cell.song.text = t.song;
        cell.artist.text = t.artist;
        
        cell.tag = kTagHeaderCell;
        
        return cell;
        
    } else {
        SongInfoDetailsPrototypeCell *cell = (SongInfoDetailsPrototypeCell *)[tableView dequeueReusableCellWithIdentifier:@"TableCell"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SongInfoDetailsPrototypeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor colorWithRed:229.0f/255.0f green:241.0f/255.0f blue:1.0f alpha:1.0f] : [UIColor colorWithRed:255.0f/96.0f green:255.0f/110.0f blue:255.0f/127.0f alpha:1.0f];
        
        return cell;
        
    }
}



#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollDiff = self.lastContentOffset.y - scrollView.contentOffset.y;
    CGFloat originY = CGRectGetMinY(self.placeholderImageView.frame) + scrollDiff;
    
    BOOL contentMovingOffScreen = scrollView.contentOffset.y > 0.0f;
    
    __block UITableViewCell *headerCell;
    
    [[_tableView visibleCells] enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
        if (cell.tag == kTagHeaderCell) {
            *stop = YES;
            headerCell = cell;
        }
    }];
    
    if (contentMovingOffScreen) {
        CGFloat alpha = MAX(1 - (scrollView.contentOffset.y / kHeightHeaderCell), 0.0f);
        CGFloat blur = 1.0f - alpha - .1;
        
        headerCell.alpha = alpha;
        
        if (alpha > 0.0f) {
            scrollView.clipsToBounds = NO;
            self.title = nil;
        } else {
            scrollView.clipsToBounds = YES;
            self.title = @"Title";
        }
        
        if (blur < 0.02)
            blur = 0.02;
        
        if(blur < .9) {
            [_placeholderImageView setImage:[u applyBlurOnImage:_albumImg withRadius:blur]];
            [_topSongLabel setAlpha:blur];
        }
        NSLog(@"%f alpha: %f", blur, alpha);
        
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

