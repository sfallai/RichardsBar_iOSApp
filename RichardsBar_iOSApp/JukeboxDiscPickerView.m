//
//  JukeboxDiscPicker.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/6/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "JukeboxDiscPickerView.h"
#import "Utilities.h"

@implementation JukeboxDiscPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self drawCustomView];
    
}

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        
    }
    
    return self;
    
}

-(void) drawCustomView {
    Utilities *u = [[Utilities alloc] init];
    
    CGRect currentFrame = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float HEIGHTOFPOPUPTRIANGLE = 20;
    float WIDTHOFPOPUPTRIANGLE  = 40;
    float borderRadius = 8;
    float strokeWidth = 1;
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, [u colorWithHexString:@"64fcff"].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    
    // Draw and fill the bubble
    /* ORIGINAL DRAW CODE
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5f, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);
    
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f) + 0.5f, strokeWidth + 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);

    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) - strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, strokeWidth + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    */
    
    /*NEW DRAW CODE*/
    CGContextBeginPath(context);
    
    //START POSITION
    CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5f, 0.5f);
    
    //DRAW FIRST LINE TO START OF TRIANGLE
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, strokeWidth + 0.5f);
    
    //DRAW TRIANGLE
    //CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f) + 0.5f, strokeWidth + 0.5f);
    //CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);
    
    //DRAW LINE/TOP RIGHT FROM TRIANGLE ARC
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, strokeWidth + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    
    //DRAW RIGHT SIDE/BOTTOM RIGHT ARC
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - HEIGHTOFPOPUPTRIANGLE + strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) - strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    
    //DRAW BOTTOM LINE
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, currentFrame.size.height - HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);
    
    //DRAW BOTTOM TRIANGLE
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f) + 0.5f, currentFrame.size.height - strokeWidth - 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, currentFrame.size.height - HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);
    
    //CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, currentFrame.size.height - HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, strokeWidth + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, borderRadius - strokeWidth);
    
    //DRAW LEFT SIDE/TOP LEFT ARC
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, 0.0f, currentFrame.size.width - strokeWidth - 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, borderRadius - strokeWidth);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);

    
    // Draw a clipping path for the fill
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5f, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) - strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, strokeWidth + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50f) + 0.5f, borderRadius - strokeWidth);
    CGContextClosePath(context);
    CGContextClip(context);
    
}

@end
