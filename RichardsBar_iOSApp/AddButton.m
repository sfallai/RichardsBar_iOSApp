//
//  AddButton.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/15/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "AddButton.h"

@implementation AddButton
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
}
*/

-(void) awakeFromNib {
    float buttonWidHgt = 24;
    
    self.layer.cornerRadius = buttonWidHgt / 2;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitle:@"+" forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25.0f]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(-3.5, .25, 0, 0)];

}

@end
