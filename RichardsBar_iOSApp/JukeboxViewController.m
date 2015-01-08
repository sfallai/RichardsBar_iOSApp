//
//  JukeboxViewController.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/29/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "JukeboxViewController.h"
#import "MPFoldTransition.h"
#import "MPFlipTransition.h"
#import "AppDelegate.h"
#import "MPFoldSegue.h"
#import <QuartzCore/QuartzCore.h>
#import "JukeboxContent.h"
#import "disc.h"
#import "track.h"
#import "JukeboxTrackCell.h"
#import "SongInfo.h"
#import "JukeboxDiscPickerView.h"

#define ABOUT_IDENTIFIER		@"AboutID"
#define DETAILS_IDENTIFIER		@"DetailsID"
#define ABOUT_SEGUE_IDENTIFIER		@"segueToAbout"
#define DETAILS_SEGUE_IDENTIFIER	@"segueToDetails"
#define STYLE_TABLE_IDENTIFIER	@"StyleTableID"
#define FOLD_STYLE_TABLE_IDENTIFIER	@"FoldStyleTableID"
#define FLIP_STYLE_TABLE_IDENTIFIER	@"FlipStyleTableID"

@interface JukeboxViewController () {
    int discNumber;
    int trackNumber;
    int minDiscNumber;
    int maxDiscNumber;
    AppDelegate *ad;
    NSMutableArray *dictDisc;
    JukeboxContent *jc;
    Utilities *u;
    UIView *modalPickerView;
    JukeboxDiscPicker *v;
    NSMutableArray *pickerData;
    UITapGestureRecognizer * tap;
    UILongPressGestureRecognizer *longPressGestureRecognizer;
    UITableView *tableView;
}

@end

@implementation JukeboxViewController

@synthesize mode = _mode;
@synthesize foldStyle = _foldStyle;
@synthesize flipStyle = _flipStyle;
@synthesize contentView = _contentView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self doInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- ViewController initialization

- (void)doInit
{
    _mode = MPTransitionModeFold;
    _foldStyle = MPFoldStyleCubic;
    _flipStyle = MPFlipStyleDefault;
    
    _searchResults = [[NSMutableArray alloc] init];
    u = [[Utilities alloc] init];
    ad = [[UIApplication sharedApplication] delegate];
    
    [self initGestureRecognizer];
    [self initJukeBox];
    [self initButtons];
    [self initPickerView];
    
//    [self.navigationController.navigationBar addGestureRecognizer:tap];
        
}

-(void) initPickerView {
    int ycoord = self.view.bounds.size.height - 70;
    int xcoord = 20;
    
    int h = 176;
    int w = self.view.frame.size.width - 40;
    
    v = [[JukeboxDiscPicker alloc] initWithFrame:CGRectMake(xcoord, ycoord - h, w, h) andArrowDirection:@"down" andStrokeColor:@"64fcff" andFillColor:@"000000" andTriangleHeight:20 andTriangleWidth:40 andBorderWidth:8 andStrokeWidth:2];
    
    [v setBackgroundColor:[UIColor clearColor]];
    [v setAlpha:1.0];
    
    //UIView *topButtons = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 44)];
    //[v addSubview:topButtons];
    
//    UIBezierPath *maskPath;
//    maskPath = [UIBezierPath bezierPathWithRoundedRect:topButtons.bounds
//                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
//                                           cornerRadii:CGSizeMake(3.0, 3.0)];
//    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = topButtons.bounds;
//    maskLayer.path = maskPath.CGPath;
//    topButtons.layer.mask = maskLayer;
    
//    [topButtons setBackgroundColor:[UIColor grayColor]];
//    
//    UIButton *firstDisc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    [firstDisc setTitle:@"First" forState:UIControlStateNormal];
//    [firstDisc setTitleColor:[UIColor greenColor] forState:UIControlStateApplication];
//    [firstDisc addTarget:self action:@selector(goToFirstDisc) forControlEvents:UIControlEventTouchDown];
//    
//    UIButton *lastDisc = [[UIButton alloc] initWithFrame:CGRectMake(w - 50, 0, 50, 50)];
//    [lastDisc setTitle:@"Last" forState:UIControlStateNormal];
//    [lastDisc setTintColor:[UIColor whiteColor]];
//    [lastDisc addTarget:self action:@selector(goToLastDisc) forControlEvents:UIControlEventTouchDown];
//    
//    [topButtons addSubview:firstDisc];
//    [topButtons addSubview:lastDisc];
//    [topButtons setBackgroundColor:[UIColor clearColor]];
    
    v.tag = 999;
    
    pickerData = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= maxDiscNumber; i ++) {
        NSString *j = [@(i) stringValue];
        
        if(j.length == 1) {
            j = [@"0" stringByAppendingString:j];
        }
        
        [pickerData addObject:[NSString stringWithFormat:@"Disc %@", j]];
        
    }
    
    _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    _picker.delegate = self;
    _picker.dataSource = self;

    [_picker setTintColor:[UIColor whiteColor]];
    
    UIView *colorMask = [[UIView alloc] initWithFrame:CGRectMake(4, h / 2 - 19, w - 8, 25)];
    [colorMask setBackgroundColor:[u colorWithHexString:@"64fcff"]];
    [colorMask setAlpha:.6];
    
    [v addSubview:colorMask];
    [v addSubview:_picker];
    //[v addSubview:colorMask];
    
    [v setHidden:YES];
    
    //[self.view addSubview:v];
    
}

- (void) initGestureRecognizer {
    [self.contentView setUserInteractionEnabled:YES];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [self.parentView addGestureRecognizer:swipeLeft];
    [self.parentView addGestureRecognizer:swipeRight];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleCellLongPress:)];
    longPressGestureRecognizer.minimumPressDuration = 1.0;
    //[longPress setDelegate:self];
    

}

-(void) initJukeBox {
    jc = [[JukeboxContent alloc] initWithJSONData];
    
    discNumber = 1;
    trackNumber = 1;
    minDiscNumber = 1;
    maxDiscNumber = jc.discs.count;
    
    [self.contentView addSubview:[self getLabelForIndex:0]];
    
    UIView *previousView = [[self.contentView subviews] objectAtIndex:0];
    [previousView addSubview:[self getTrackListingForIndex:0]];
    
}

-(void) initButtons {
    [_btnJumpTo setTitle:[NSString stringWithFormat:@"1 / %@", [@(maxDiscNumber) stringValue]] forState:UIControlStateNormal];
    [_btnJumpTo setTintColor:[u colorWithHexString:@"64fcff"]];
    [_btnNextDisc setTintColor:[u colorWithHexString:@"64fcff"]];
    [_btnPreviousDisc setTintColor:[u colorWithHexString:@"64fcff"]];
    
}

#pragma mark - UISearchDisplayController Delegate Methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self searchTracks:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self searchTracks:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self hidePicker];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self hidePicker];

}

-(void) searchTracks: (NSString*) searchText scope:(NSString*) scope{
    [_searchResults removeAllObjects];
    
    for(int i = 0; i < maxDiscNumber; i++) {
        disc *d = [jc getDiscFromIndex:i];
        
        for(track *t in d.tracks) {
            if([t.song rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound
               || [t.artist rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound
               ) {
                disc *_disc = [[disc alloc] init];
                NSString *dn = d.discNumber;
                
                _disc.discNumber = d.discNumber;
                [_disc.tracks addObject:t];
                
                [_searchResults addObject:_disc];
            }
        }
    }
}

- (BOOL)isFold
{
    return [self mode] == MPTransitionModeFold;
}

-(void) goToLastDisc {
    if(discNumber != maxDiscNumber) {
        discNumber = maxDiscNumber;
        [self flipPage:YES];
        [_picker selectRow:discNumber - 1 inComponent:0 animated:YES];
    }
}

-(void) goToFirstDisc {
    if(discNumber != minDiscNumber) {
        discNumber = minDiscNumber;
        [self flipPage:NO];
        [_picker selectRow:discNumber - 1 inComponent:0 animated:YES];
    }
}

#pragma mark - PickerView methods and delegates

-(void) showPicker {
    [_picker selectRow:discNumber - 1 inComponent:0 animated:YES];
    v.alpha = 0;
    v.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        v.alpha = 1.0;
    }];
}

-(void) hidePicker {
    [UIView animateWithDuration:0.5 animations:^{
        v.alpha = 0;
    } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
        [v setHidden:YES];//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
    }];
    
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [pickerData objectAtIndex:row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    int *discNum = row + 1;
    
    if (discNum != discNumber){
        if(discNum < discNumber) {
            discNumber = discNum;
            [self flipPage: YES];
        } else {
            discNumber = discNum;
            [self flipPage: NO];
        }
    }
    
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel *label = (UILabel*) view;
//    if (label == nil)
//    {
//        label = [[UILabel alloc] init];
//    }
//    
//    [label setText:@"Whatever"];
//    
//    // This part just colorizes everything, since you asked about that.
//    
//    [label setTextColor:[UIColor blackColor]];
//    [label setBackgroundColor:[u colorWithHexString:@"64fcff"]];
//    CGSize rowSize = [pickerView rowSizeForComponent:component];
//    CGRect labelRect = CGRectMake (4, 0, rowSize.width-8, rowSize.height);
//    [label setFrame:labelRect];
//    label.textAlignment = NSTextAlignmentCenter;
//    
//    return label;
//}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}

#pragma mark - touch handlers
- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    [self hidePicker];
}

-(void) handleCellLongPress:(UILongPressGestureRecognizer *) longPress{
    if(longPress.state == UIGestureRecognizerStateBegan) {
        CGPoint p = [longPress locationInView:tableView];
        
        NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:p];
        
        if(!(indexPath == nil)) {

            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell.isHighlighted) {
                UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Add song to" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                        @"Playlist",
                                        @"New Playlist",
                                        nil];
                popup.tag = 1;
                [popup showInView:[UIApplication sharedApplication].keyWindow];
            }
        }
    }
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

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesBegan: touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
   
    if([event touchesForView:v] == nil && [event touchesForView:[v.subviews objectAtIndex:1]] == nil) {
        [self hidePicker];
    }
}

- (void) handleSwipe: (UISwipeGestureRecognizer *) swipe {
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft && discNumber < maxDiscNumber) {
        discNumber += 1;
        [self flipPage: YES];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight && discNumber > minDiscNumber) {
        discNumber -= 1;
        [self flipPage: NO];
    }
    
    [_picker selectRow:discNumber - 1 inComponent:0 animated:YES];
    
}

#pragma mark - control methods
- (IBAction)btnJumpTo_click:(id)sender {
    if(![self.view.subviews containsObject:v]) {
        [self.view addSubview:v];
        [self showPicker];
    } else {
        if ([v isHidden]) {
            [self showPicker];
        } else {
            [self hidePicker];
        }
    }
}

- (IBAction)btnNextDisc_click:(id)sender {
    [self discChangeByButton:YES];
    [_picker selectRow:discNumber - 1 inComponent:0 animated:YES];
}
- (IBAction)btnPreviousDisc_click:(id)sender {
    [self discChangeByButton:NO];
    [_picker selectRow:discNumber - 1 inComponent:0 animated:YES];
}

- (void) discChangeByButton: (BOOL) forward {
    if(forward) {
        if(discNumber < maxDiscNumber) {
            discNumber += 1;
            [self flipPage: YES];
        }
    } else {
        if (discNumber > minDiscNumber) {
            discNumber -= 1;
            [self flipPage: NO];
        }
    }
    
    [_btnJumpTo setTitle:[NSString stringWithFormat:@"%@ / %@", [@(discNumber) stringValue], [@(maxDiscNumber) stringValue]] forState:UIControlStateNormal];
}

#pragma mark - page turn methods
- (void)updateClipsToBounds
{
    // We want clipsToBounds == YES on the central contentView when fold style mode bit is not cubic
    // Otherwise you see the top & bottom panels sliding out and looks weird
    [self.contentView setClipsToBounds:[self isFold] && (([self foldStyle] & MPFoldStyleCubic) != MPFoldStyleCubic)];

}



-(void) flipPage:(BOOL) forwards {
    UIView *previousView = [[self.contentView subviews] objectAtIndex:0];
    UIView *nextView = [self getTrackListingForIndex:discNumber - 1];
    
    // execute the transition
    [MPFlipTransition transitionFromView:previousView
                                  toView:nextView
                                duration:[MPTransition defaultDuration]
                                   style:forwards? [self flipStyle]	: MPFlipStyleFlipDirectionBit([self flipStyle])
                        transitionAction:MPTransitionActionAddRemove
                              completion:^(BOOL finished) {
                                  
                              }
     ];
    
    [_btnJumpTo setTitle:[NSString stringWithFormat:@"%@ / %@", [@(discNumber) stringValue], [@(maxDiscNumber) stringValue]] forState:UIControlStateNormal];
}

-(UIView *) getTrackListingForIndex: (NSUInteger) index {
    disc *disc = [jc getDiscFromIndex:index];
    [dictDisc removeAllObjects];
    
    for(track *t in disc.tracks) {
        [dictDisc addObject:t];
    }

    UIView *container = [[UIView alloc] initWithFrame:self.contentView.bounds];
    container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, container.frame.size.width, container.frame.size.height) style: UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setBackgroundColor:[UIColor blackColor]];
    [tableView addGestureRecognizer:longPressGestureRecognizer];
    
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    
    [tableView reloadData];
    
    [container addSubview:tableView];
    
    return container;
}

- (UIView *)getLabelForIndex:(NSUInteger)index
{
    UIView *container = [[UIView alloc] initWithFrame:self.contentView.bounds];
    container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    return container;
}

-(NSString *) getAlbumCodeWithDiscNumber: (NSString *) discNum andTrackNum: (NSString*) trackNum {
    NSString *discCode = discNum;
    
    if(discNum.length == 1) {
        discCode = [@"0" stringByAppendingString:discCode];
    }
    
    if(trackNum.length == 1) {
        trackNum = [@"0" stringByAppendingString:trackNum];
    }
    
    return [discCode stringByAppendingString:trackNum];
}

#pragma mark - tableView delegates and methods

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueSongDetail"]) {
        JukeboxTrackCell *cell = sender;
        SongInfo *vc = [segue destinationViewController];
        vc.trackCode = cell.code.text;
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return _searchResults.count;
    } else {
        disc *disc = [jc getDiscFromIndex:discNumber - 1];
        
        return disc.tracks.count;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    //Region *region = [regions objectAtIndex:section];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return @"Search Results";
    } else {
        return [@"Disc " stringByAppendingString:[@(discNumber) stringValue]];
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JukeboxTrackCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self hidePicker];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSString *discNum = [cell.code.text substringToIndex:2];
        
        [self.searchDisplayController setActive:NO];
        
        if(discNumber < maxDiscNumber && discNumber != [discNum intValue]) {
            discNumber = [discNum intValue];
            [self flipPage: YES];
            
            
        } else if (discNumber > minDiscNumber && discNumber != [discNum intValue]) {
            discNumber = [discNum intValue];
            [self flipPage: NO];

        }
        
        //[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[[cell.code.text substringFromIndex:2] integerValue] - 1 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        
    } else {
        
        [self performSegueWithIdentifier:@"segueSongDetail" sender:cell];
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *header = @"customHeader";
    
    UITableViewHeaderFooterView *vHeader;
    
    vHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
    
    if (!vHeader) {
        vHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
        [vHeader.textLabel setTextColor:[UIColor whiteColor]];

    }
    
    vHeader.textLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    [vHeader addGestureRecognizer:tap];
    
    return vHeader;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor grayColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    JukeboxTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JukeboxPrototypeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:MyIdentifier];
    }
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        disc *d = [_searchResults objectAtIndex:indexPath.row];
        track *track = [d.tracks objectAtIndex:0];
        
        cell.artist.text = track.artist;
        cell.song.text = track.song;
        cell.code.text = [self getAlbumCodeWithDiscNumber:d.discNumber andTrackNum:track.trackNumber];
        cell.albumImg.image = [UIImage imageNamed:track.albumImg];
        
    } else {
        disc *disc = [jc getDiscFromIndex:discNumber - 1];
        track *track = [disc.tracks objectAtIndex:indexPath.row];
        
        cell.artist.text = track.artist;
        cell.song.text = track.song;
        cell.code.text = [self getAlbumCodeWithDiscNumber:disc.discNumber andTrackNum:track.trackNumber];
        cell.albumImg.image = [UIImage imageNamed:track.albumImg];
    }
    
    //cell.textLabel.text = [[@(discNumber) stringValue] stringByAppendingString:track.song];
    //UIImage *img = [[UIImage alloc] initWithContentsOfFile:@"audiowave"];
    //cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", track.trackNumber, track.song];
    //cell.detailTextLabel.text = track.artist;
    //[cell.textLabel addSubview:img];
    
    //cell.detailTextLabel.textColor = [UIColor whiteColor];
    //cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

@end
