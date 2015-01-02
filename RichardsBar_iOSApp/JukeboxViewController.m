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
    NSDictionary *disc;
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
    
    JukeboxContent *jc = [[JukeboxContent alloc] initWithJSONData];
    
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

- (BOOL)isFold
{
    return [self mode] == MPTransitionModeFold;
}

- (void)doInit
{
    [self.contentView addSubview:[self getLabelForIndex:0]];
    
    discNumber = 1;
    trackNumber = 1;
    minDiscNumber = 1;
    maxDiscNumber = 10;
    
    _mode = MPTransitionModeFold;
    _foldStyle = MPFoldStyleCubic;
    _flipStyle = MPFlipStyleDefault;
    
    ad = [[UIApplication sharedApplication] delegate];
    [self initGestureRecognizer];
    
    UIView *previousView = [[self.contentView subviews] objectAtIndex:0];
    [previousView addSubview:[self getTrackListingForIndex:0]];
    
    
}

- (void)updateClipsToBounds
{
    // We want clipsToBounds == YES on the central contentView when fold style mode bit is not cubic
    // Otherwise you see the top & bottom panels sliding out and looks weird
    [self.contentView setClipsToBounds:[self isFold] && (([self foldStyle] & MPFoldStyleCubic) != MPFoldStyleCubic)];

}

- (void) handleSwipe: (UISwipeGestureRecognizer *) swipe {
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft && discNumber < maxDiscNumber) {
        discNumber += 1;
        [self flipPage: YES];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight && discNumber > minDiscNumber) {
        discNumber -= 1;
        [self flipPage: NO];
    }
}

-(void) flipPage:(BOOL) forwards {
    UIView *previousView = [[self.contentView subviews] objectAtIndex:0];
    UIView *nextView = [self getTrackListingForIndex:discNumber];
    
    // execute the transition
    [MPFlipTransition transitionFromView:previousView
                                  toView:nextView
                                duration:[MPTransition defaultDuration]
                                   style:forwards? [self flipStyle]	: MPFlipStyleFlipDirectionBit([self flipStyle])
                        transitionAction:MPTransitionActionAddRemove
                              completion:^(BOOL finished) {
                                  
                              }
     ];
}

-(UIView *) getTrackListingForIndex: (NSUInteger) index {
    UIView *container = [[UIView alloc] initWithFrame:self.contentView.bounds];
    container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, container.frame.size.width, container.frame.size.height) style: UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setBackgroundColor:[UIColor blackColor]];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    
    [tableView reloadData];
    
    [container addSubview:tableView];
    
    return container;
}

- (UIView *)getLabelForIndex:(NSUInteger)index
{
    UIView *container = [[UIView alloc] initWithFrame:self.contentView.bounds];
    container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [container setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectInset(container.bounds, 10, 10)];
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [label setFont:[UIFont boldSystemFontOfSize:84]];
    [label setTextColor:[UIColor lightTextColor]];
    label.text = [NSString stringWithFormat:@"%d", index + 1];
    
    switch (index % 6) {
        case 0:
            [label setBackgroundColor:[UIColor redColor]];
            break;
            
        case 1:
            [label setBackgroundColor:[UIColor orangeColor]];
            break;
            
        case 2:
            [label setBackgroundColor:[UIColor yellowColor]];
            [label setTextColor:[UIColor darkTextColor]];
            break;
            
        case 3:
            [label setBackgroundColor:[UIColor greenColor]];
            [label setTextColor:[UIColor darkTextColor]];
            break;
            
        case 4:
            [label setBackgroundColor:[UIColor blueColor]];
            break;
            
        case 5:
            [label setBackgroundColor:[UIColor purpleColor]];
            break;
            
        default:
            break;
    }
    
    [container addSubview:label];
    container.tag = index;
    [container.layer setBorderColor:[[UIColor colorWithWhite:0.85 alpha:1] CGColor]];
    [container.layer setBorderWidth:2];
    
    return container;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return 5;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    //Region *region = [regions objectAtIndex:section];
    return [@"Disc " stringByAppendingString:[@(discNumber) stringValue]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [[@(discNumber) stringValue] stringByAppendingString:@": Night Moves"];
    cell.detailTextLabel.text = @"Bob Seger & The Silver Bullet Band";

    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

@end
