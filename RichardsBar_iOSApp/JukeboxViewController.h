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

enum {
    MPTransitionModeFold,
    MPTransitionModeFlip
} typedef MPTransitionMode;


@interface JukeboxViewController : UIViewController

@property (assign, nonatomic) MPTransitionMode mode;
@property (assign, nonatomic) NSUInteger style;
@property (assign, nonatomic) MPFoldStyle foldStyle;
@property (assign, nonatomic) MPFlipStyle flipStyle;
@property (readonly, nonatomic) BOOL isFold;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *parentView;

@end
