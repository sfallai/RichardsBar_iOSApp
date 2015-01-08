//
//  JukeboxViewController.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/29/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPFoldEnumerations.h"
#import "MPFlipEnumerations.h"
#import "DefaultAppearanceViewController.h"

enum {
    MPTransitionModeFold,
    MPTransitionModeFlip
} typedef MPTransitionMode;


@interface JukeboxViewController : DefaultAppearanceViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>


@property (assign, nonatomic) MPTransitionMode mode;
@property (assign, nonatomic) NSUInteger style;
@property (assign, nonatomic) MPFoldStyle foldStyle;
@property (assign, nonatomic) MPFlipStyle flipStyle;
@property (readonly, nonatomic) BOOL isFold;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableArray *allTracks;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UISearchBar *JukeboxSearchBar;
@property (weak, nonatomic) IBOutlet UIButton *btnJumpTo;
@property (weak, nonatomic) IBOutlet UIButton *btnNextDisc;
@property (weak, nonatomic) IBOutlet UIButton *btnPreviousDisc;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;

@end
