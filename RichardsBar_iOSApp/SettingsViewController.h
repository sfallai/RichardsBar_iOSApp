//
//  SettingsViewController.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/29/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIEffectDesignerView.h"

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *swSmokeEffects;
@property(nonatomic, strong) UIEffectDesignerView* effectView;
@property (weak, nonatomic) IBOutlet UISwitch *swProgressiveSmoke;
@property (weak, nonatomic) IBOutlet UILabel *lblProgressiveSmoke;

@end
