//
//  JukeboxDiscPicker.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/6/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "JukeboxDiscPickerView.h"
#import "Utilities.h"

@implementation JukeboxDiscPicker {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) drawRect:(CGRect)rect  {
    [super drawRect:rect];
    
    if([_arrowDirection isEqualToString:@"up"]) {
        [self drawCustomViewUpArrow];
    } else if([_arrowDirection isEqualToString:@"right"]) {
        
    } else if([_arrowDirection isEqualToString:@"down"]) {
        [self drawCustomViewDownArrow];
    } else {
        //left arrow default
        
    }
    
}

-(id) initWithFrame:(CGRect)frame andArrowDirection:(NSString*) direction andStrokeColor:(NSString*) strokeHexColor andFillColor:(NSString*) fillHexColor andTriangleHeight:(float) triangleHgt andTriangleWidth:(float) triangleWdt andBorderWidth:(float) borderWdt andStrokeWidth: (float) strokeWdt{
    self = [super initWithFrame:frame];
    
    if(self) {
        _strokeHexCol = strokeHexColor;
        _fillHexCol = fillHexColor;
        _HEIGHTOFPOPUPTRIANGLE = triangleHgt;
        _WIDTHOFPOPUPTRIANGLE = triangleWdt;
        _borderRadius = borderWdt;
        _strokeWidth = strokeWdt;
        _arrowDirection = direction;

    }
    
    return self;
    
}

-(void) drawCustomViewRightArrow {
    Utilities *u = [[Utilities alloc] init];
    
    CGRect currentFrame = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, _strokeWidth);
    CGContextSetStrokeColorWithColor(context, [u colorWithHexString:_strokeHexCol].CGColor);
    CGContextSetFillColorWithColor(context, [u colorWithHexString:_fillHexCol].CGColor);
    
    //
    
    //
    
    // Draw a clipping path for the fill
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, _borderRadius + _strokeWidth + 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f);
    CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + _WIDTHOFPOPUPTRIANGLE / 2.0f) - _strokeWidth + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
    CGContextAddArcToPoint(context, _strokeWidth + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _strokeWidth + 0.5f, _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f, _borderRadius - _strokeWidth);
    CGContextAddArcToPoint(context, _strokeWidth + 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, currentFrame.size.width - _strokeWidth - 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, _borderRadius - _strokeWidth);
    CGContextClosePath(context);
    CGContextClip(context);
}

-(void) drawCustomViewUpArrow {
    Utilities *u = [[Utilities alloc] init];
    
    CGRect currentFrame = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, _strokeWidth);
    CGContextSetStrokeColorWithColor(context, [u colorWithHexString:_strokeHexCol].CGColor);
    CGContextSetFillColorWithColor(context, [u colorWithHexString:_fillHexCol].CGColor);
    
    // Draw and fill the bubble
     CGContextBeginPath(context);
     CGContextMoveToPoint(context, _borderRadius + _strokeWidth + 0.5f, _strokeWidth + _HEIGHTOFPOPUPTRIANGLE + 0.5f);
     CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - _WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f);
     
     CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f) + 0.5f, _strokeWidth + 0.5f);
     CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f + _WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f);
     
     CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, _strokeWidth + _HEIGHTOFPOPUPTRIANGLE + 0.5f, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
     
     CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + _WIDTHOFPOPUPTRIANGLE / 2.0f) - _strokeWidth + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
     
     CGContextAddArcToPoint(context, _strokeWidth + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _strokeWidth + 0.5f, _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f, _borderRadius - _strokeWidth);
     CGContextAddArcToPoint(context, _strokeWidth + 0.5f, _strokeWidth + _HEIGHTOFPOPUPTRIANGLE + 0.5f, currentFrame.size.width - _strokeWidth - 0.5f, _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f, _borderRadius - _strokeWidth);
     CGContextClosePath(context);
     CGContextDrawPath(context, kCGPathFillStroke);
    
    // Draw a clipping path for the fill
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, _borderRadius + _strokeWidth + 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f);
    CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + _WIDTHOFPOPUPTRIANGLE / 2.0f) - _strokeWidth + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
    CGContextAddArcToPoint(context, _strokeWidth + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _strokeWidth + 0.5f, _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f, _borderRadius - _strokeWidth);
    CGContextAddArcToPoint(context, _strokeWidth + 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, currentFrame.size.width - _strokeWidth - 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, _borderRadius - _strokeWidth);
    CGContextClosePath(context);
    CGContextClip(context);


}

-(void) drawCustomViewDownArrow {
    Utilities *u = [[Utilities alloc] init];
    
    CGRect currentFrame = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, _strokeWidth);
    CGContextSetStrokeColorWithColor(context, [u colorWithHexString:_strokeHexCol].CGColor);
    CGContextSetFillColorWithColor(context, [u colorWithHexString:_fillHexCol].CGColor);
    
    /*NEW DRAW CODE*/
    CGContextBeginPath(context);
    
    //START POSITION
    CGContextMoveToPoint(context, _borderRadius + _strokeWidth + 0.5f, 0.5f);
    
    //DRAW FIRST LINE TO START OF TRIANGLE
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - _WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, _strokeWidth + 0.5f);
    
    
    //DRAW LINE/TOP RIGHT FROM TRIANGLE ARC
    CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, _strokeWidth + 0.5f, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
    
    //DRAW RIGHT SIDE/BOTTOM RIGHT ARC
    CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _HEIGHTOFPOPUPTRIANGLE + _strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + _WIDTHOFPOPUPTRIANGLE / 2.0f) - _strokeWidth + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
    
    //DRAW BOTTOM LINE
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f + _WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, currentFrame.size.height - _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f);
    
    //DRAW BOTTOM TRIANGLE
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f) + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - _WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, currentFrame.size.height - _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f);
    
    //CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - _WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f);
    CGContextAddArcToPoint(context, _strokeWidth + 0.5f, currentFrame.size.height - _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f, _strokeWidth + 0.5f, _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f, _borderRadius - _strokeWidth);
    
    //DRAW LEFT SIDE/TOP LEFT ARC
    CGContextAddArcToPoint(context, _strokeWidth + 0.5f, 0.0f, currentFrame.size.width - _strokeWidth - 0.5f, _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f, _borderRadius - _strokeWidth);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);

    
    // Draw a clipping path for the fill
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, _borderRadius + _strokeWidth + 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f);
    CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - _strokeWidth - 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + _WIDTHOFPOPUPTRIANGLE / 2.0f) - _strokeWidth + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _borderRadius - _strokeWidth);
    CGContextAddArcToPoint(context, _strokeWidth + 0.5f, currentFrame.size.height - _strokeWidth - 0.5f, _strokeWidth + 0.5f, _HEIGHTOFPOPUPTRIANGLE + _strokeWidth + 0.5f, _borderRadius - _strokeWidth);
    CGContextAddArcToPoint(context, _strokeWidth + 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, currentFrame.size.width - _strokeWidth - 0.5f, round((currentFrame.size.height + _HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, _borderRadius - _strokeWidth);
    CGContextClosePath(context);
    CGContextClip(context);
    
}

@end
