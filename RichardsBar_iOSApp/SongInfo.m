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
#import "FXBlurView.h"
#import "sqlite3.h"

static NSInteger const kTagHeaderCell = 999;
static CGFloat const kHeightHeaderCell = 140.0f;


@interface SongInfo () <UITableViewDelegate, UITableViewDataSource> {
    JukeboxContent *jc;
    track *t;
    Utilities *u;
    NSString *songLyrics;
    float albumImageHeight;
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

    [self doInit];
    
    self.placeholderMinimumY = CGRectGetMinY(self.placeholderImageView.frame);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods
-(float) getAlbumImageHeight {
    UIImage *img = [UIImage imageNamed:t.albumImgLarge];
    
    float w = img.size.width;
    float h = img.size.height;
    NSLog(@"w:%f h:%f screenw: %f imgH:%f", w, h, self.view.frame.size.width, (h / w) * self.view.frame.size.width );
    
    return (h / w) * self.view.frame.size.width;
    
}

-(track *) getTrackFromCode:(NSString *) code {
    NSString *discNum = [code substringToIndex:2];
    NSString *trackNum = [code substringFromIndex:2];
    
    disc *disc = [jc getDiscFromIndex:[discNum intValue] - 1];
    track *track = [disc.tracks objectAtIndex:[trackNum intValue] - 1];
    
    return track;
}

-(void) closeSettings_Click {
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

#pragma mark - Button actions
-(void) addPlaylistButton_Click {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Add song to" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Playlist",
                            @"New Playlist",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

-(void) openiTunesLink {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:t.iTunesLink]];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0: //add to playlist
                    
                case 1: //create new playlist and add to
                    
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - Initializers
-(void) doInit {
    jc = [[JukeboxContent alloc] initWithJSONData];
    t = [self getTrackFromCode:trackCode];
    u = [[Utilities alloc] init];
    albumImageHeight = [self getAlbumImageHeight];
    
    [self initAlbumCover];
    [self initSongLyrics];
    [self initTableView];
    [self initControls];
    
}

-(void) initSongLyrics {
    NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"jukebox.sqlite" ofType:nil];
    sqlite3 *mySqliteDB;
    
    const char *dbpath = [sqLiteDb UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select `Lyrics` from `SongLyrics` where `JukeboxCode` = '%@'", trackCode];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(mySqliteDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                songLyrics = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
             
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(mySqliteDB);
    }
    
}

-(void) initControls {
    //ADD TO PLAYLIST BUTTON
    float buttonWidHgt = 24;
    
    _topAddToPlaylistButton = [self createAddButtonWithX:self.view.frame.size.width - buttonWidHgt - 10 withY:buttonWidHgt];
    [_topAddToPlaylistButton addTarget:self action:@selector(addPlaylistButton_Click) forControlEvents:UIControlEventTouchUpInside];
    _topAddToPlaylistButton.alpha = 0.0;
    [_topAddToPlaylistButton addTarget:self action:@selector(addPlaylistButton_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_topAddToPlaylistButton];
    
    AlphaGradientView *gradient = [[AlphaGradientView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    gradient.direction = GRADIENT_UP;
    gradient.color = [UIColor blackColor];

    //POSITION THE GRADIENT JUST UNDER THE SECTION HEADER
    _lyricsGradient = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.frame.origin.y + [_tableView rectForSection:0].size.height + 50, self.view.frame.size.width, 100)];
    [_lyricsGradient addSubview:gradient];
    //[self.view addSubview:_lyricsGradient];
    
    //GRADIENT AT BOTTOM, BOTH GIVE A FADE IN/OUT EFFECT ON THE TEXT
    AlphaGradientView *bottomGradient = [[AlphaGradientView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 144, self.view.frame.size.width, 100)];
    bottomGradient.direction = GRADIENT_DOWN;
    bottomGradient.color = [UIColor blackColor];
    
    [self.view addSubview:bottomGradient];
    

}

-(void) initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, albumImageHeight - 139 - 100, self.view.frame.size.width, self.view.frame.size.height - 60) style: UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
        
    _tableView.allowsSelection = NO;
    
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
    
//    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
//    [topBar setBackgroundColor:[UIColor clearColor]];
    //[topBar setAlpha:.8];
    
    _topSongLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, 44)];
    //title.text = @"Settings";
    _topSongLabel.text = t.song;
    _topSongLabel.textColor = [UIColor whiteColor];
    _topSongLabel.font = [UIFont fontWithName:@"Helvetica" size:19];
    _topSongLabel.textAlignment = NSTextAlignmentCenter;
    
    [_topSongLabel setAlpha:0.0];
    
    //[topBar addSubview:_topSongLabel];
    
    [self.view addSubview:_topSongLabel];
    //[self.view addSubview:title];
    
}

-(void) initAlbumCover {
    UIImage *albumImg = [UIImage imageNamed:t.albumImgLarge];
    
    _placeholderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -50, self.view.frame.size.width, albumImageHeight)];
    [_placeholderImageView setContentMode:UIViewContentModeScaleAspectFit];
    [_placeholderImageView setImage:albumImg];
    
    _gradient = [[UIView alloc] initWithFrame:_placeholderImageView.bounds];
    _topGradient = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    _topGradient.alpha = 0.0;
    
    AlphaGradientView *grad = [[AlphaGradientView alloc] initWithFrame:
                               CGRectMake(0, albumImageHeight - 200, self.view.frame.size.width, 200)];
    [grad setDirection:GRADIENT_DOWN];
    grad.color = [UIColor blackColor];
    
    AlphaGradientView *topGrad = [[AlphaGradientView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [topGrad setDirection:GRADIENT_UP];
    topGrad.color = [UIColor blackColor];
    
    //HAVE TO ADD THE AlphaGradientView TO A REGULAR VIEW
    //IF YOU DON'T THEN WHEN YOU ADJUST THE ALPHA ON THE AlphaGradientView MEMORY USAGE BALLOONS AND CRASHES THE DEVICE
    [_gradient addSubview:grad];
    [_topGradient addSubview:topGrad];
    
    //INITIALIZED BUT CURRENTLY NOT BEING USED
//    _blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, albumImageHeight)];
//    _blurView.blurRadius = 0.0;
//    _blurView.hidden = YES;
//    
//    [_placeholderImageView addSubview:_blurView];
    
    [_placeholderImageView addSubview:_gradient];
    
    [self.view addSubview:_placeholderImageView];
    [self.view addSubview:_topGradient];
    NSLog(@"placeholderImage height: %f:", _placeholderImageView.frame.size.height);
    
}

-(UIButton *) createAddButtonWithX:(float) x withY: (float) y {
    float buttonWidHgt = 24;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, buttonWidHgt, buttonWidHgt)];
    button.layer.cornerRadius = buttonWidHgt / 2;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor whiteColor] CGColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25.0f]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(-3.5, .25, 0, 0)];
    
    return button;
    
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
    
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kHeightHeaderCell;
    }
    
    return [self heightOfLabel:songLyrics withFontSize:15.0] + 10;
}

- (NSInteger) heightOfLabel:(NSString*) string withFontSize:(float) fontSize {
    
    CGSize maximumLabelSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 10, FLT_MAX);
    
    CGSize expectedLabelSize = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    return expectedLabelSize.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.tag = 10;
    
    UIView *topBarPart = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [topBarPart addSubview:blurView];
    
    UIButton *itunesButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, 7, 100, 37)];
    [itunesButton setBackgroundImage:[UIImage imageNamed:@"itunesButton.png"] forState:UIControlStateNormal];
    [itunesButton addTarget:self action:@selector(openiTunesLink) forControlEvents:UIControlEventTouchUpInside];
    
    //ADD TO PLAYLIST BUTTON
//    float buttonWidHgt = 24;
//
//    UIButton *button = [self createAddButtonWithX:self.view.frame.size.width - buttonWidHgt - 10 withY:25 - (buttonWidHgt/2)];
//    [button addTarget:self action:@selector(addPlaylistButton_Click) forControlEvents:UIControlEventTouchUpInside];
//    
//    [blurView addSubview:button];
    
    [blurView addSubview:itunesButton];
    
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
        
        //ACCESS THE BUTTON THAT IS PROGRAMATICALLY CREATED IN THE .NIB
        UIButton *button = (UIButton *)[cell viewWithTag:100];
        [button addTarget:self action:@selector(addPlaylistButton_Click) forControlEvents:UIControlEventTouchUpInside];
        
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
        
        [cell setSongLyrics:songLyrics];
        
        
//        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor colorWithRed:229.0f/255.0f green:241.0f/255.0f blue:1.0f alpha:1.0f] : [UIColor colorWithRed:255.0f/96.0f green:255.0f/110.0f blue:255.0f/127.0f alpha:1.0f];
        
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

        [_topSongLabel setAlpha: (fabsf(scrollView.contentOffset.y) * .01)];
        [_topGradient setAlpha: (fabsf(scrollView.contentOffset.y) * .01)];
        _topAddToPlaylistButton.alpha = (fabsf(scrollView.contentOffset.y) * .01);
        
        if (alpha > 0.0f) {
            scrollView.clipsToBounds = NO;
        } else {
            scrollView.clipsToBounds = YES;
        }
        
        //NOT SURE IF I LIKE THE BLUR EFFECT OR NOT, A LITTLE JUMPY
//        if (blur < 2) {
//            _blurView.hidden = YES;
//        } else {
//            _blurView.hidden = NO;
//        }
//        
//        _blurView.blurRadius = blur;
        
        originY = CGRectGetMinY(self.placeholderImageView.frame);
    } else if (scrollDiff < 0.0f) {
        originY = MAX(originY, self.placeholderMinimumY);
        
    } else {
        originY = MIN(originY, 0.0f);

        [_topSongLabel setAlpha: 0.0];
        _topGradient.alpha = 0.0;
        _topAddToPlaylistButton.alpha = 0.0;
        
    }
    
    headerCell.alpha = 1 - (fabsf(scrollView.contentOffset.y) * .01);
    [_gradient setAlpha:fabsf(_placeholderImageView.frame.origin.y * .01) * 2];
    
    CGRect newRect = CGRectMake(CGRectGetMinX(self.placeholderImageView.frame),
                                originY,
                                CGRectGetWidth(self.placeholderImageView.frame),
                                CGRectGetHeight(self.placeholderImageView.frame));
    
    self.placeholderImageView.frame = newRect;
    
//    CGRect rect = [_tableView convertRect:[_tableView rectForHeaderInSection:1] toView:[_tableView superview]];
//    UITableViewCell *c = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
//    
//    CGRect r = [_tableView convertRect:[_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]] toView:[_tableView superview]];
//    
//    NSLog(@"cRectY: %f", c.contentScaleFactor);
//    
//    //NSLog(@"%f", rect.origin.y);
////
//    if(rect.origin.y > 50.0f) {
//        //NSLog(@"originY: %f", originY);
//        self.lyricsGradient.frame = CGRectMake(0, rect.origin.y + 50, self.view.frame.size.width, rect.size.height);
//    }
//
    self.lastContentOffset = scrollView.contentOffset;
    
}

@end

