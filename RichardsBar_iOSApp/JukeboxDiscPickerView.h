//
//  JukeboxDiscPicker.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/6/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JukeboxDiscPicker : UIView

@property (strong, nonatomic) NSString *strokeHexCol;
@property (strong, nonatomic) NSString *fillHexCol;
@property float HEIGHTOFPOPUPTRIANGLE;
@property float WIDTHOFPOPUPTRIANGLE;
@property float borderRadius;
@property float strokeWidth;
@property (strong, nonatomic) NSString *arrowDirection;


-(id) initWithFrame:(CGRect)frame andArrowDirection:(NSString*) direction andStrokeColor:(NSString*) strokeHexColor andFillColor:(NSString*) fillHexColor andTriangleHeight:(float) triangleHgt andTriangleWidth:(float) triangleWdt andBorderWidth:(float) borderWdt andStrokeWidth: (float) strokeWdt;

@end
