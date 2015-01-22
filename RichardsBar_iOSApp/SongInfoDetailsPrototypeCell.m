//
//  SongInfoDetailsPrototypeCell.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/13/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "SongInfoDetailsPrototypeCell.h"
#import "Utilities.h"
#import "AlphaGradientView.h"

@implementation SongInfoDetailsPrototypeCell

- (void)awakeFromNib {
    // Initialization code
    //Utilities *u = [[Utilities alloc] init];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setSongLyrics:(NSString*) lyrics {
    float maxFontSize = 15.0;
    
    NSInteger viewHeight = [self heightOfLabel:lyrics withFontSize:maxFontSize];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, viewHeight)];
    self.frame = CGRectMake(0, 0, self.frame.size.width, viewHeight + 10);
    
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = lyrics;
    label.textColor = [UIColor whiteColor];
    [label setFont:[UIFont systemFontOfSize:maxFontSize]];
    
    [self addSubview:label];
    
}

- (NSInteger) heightOfLabel:(NSString*) string withFontSize:(float) fontSize {
    
    CGSize maximumLabelSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 10, FLT_MAX);
    
    CGSize expectedLabelSize = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    return expectedLabelSize.height;
}

@end
