//
//  SongInfo.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/5/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlphaGradientView.h"
#import "FXBlurView.h"

@interface SongInfo : UIViewController <UIActionSheetDelegate>

@property(weak, nonatomic)  NSString* trackCode;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) UIImageView *placeholderImageView;
@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, assign) CGFloat placeholderMinimumY;
@property (nonatomic, assign) CGPoint lastContentOffset;
@property (nonatomic, strong) UILabel *topSongLabel;
@property (nonatomic, strong) UIView *gradient;
@property (nonatomic, strong) UIView *topGradient;
@property (nonatomic, strong) UIButton *topAddToPlaylistButton;
@property (nonatomic, strong) UIView *lyricsGradient;

@property (weak, nonatomic) IBOutlet UISwitch *swSmokeEffects;

@end
