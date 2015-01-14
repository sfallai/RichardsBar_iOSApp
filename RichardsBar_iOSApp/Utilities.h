//
//  Utilities.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/29/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface Utilities : NSObject

-(UIColor*)colorWithHexString:(NSString*)hex;
- (UIImage *)applyBlurOnImage: (UIImage *)imageToBlur withRadius:(CGFloat)blurRadius;

@end
