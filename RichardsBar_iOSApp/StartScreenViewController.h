//
//  StartScreenViewController.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/22/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DefaultAppearanceViewController.h"

@interface StartScreenViewController : DefaultAppearanceViewController

@property (nonatomic, strong) UIViewController *jukeboxViewController;

@property (weak, nonatomic) IBOutlet UIButton *btnJukeboxBrowser;
@end
