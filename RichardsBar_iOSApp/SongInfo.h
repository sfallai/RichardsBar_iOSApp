//
//  SongInfo.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/5/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongInfo : UIViewController

@property(weak, nonatomic)  NSString* trackCode;
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;

@end
