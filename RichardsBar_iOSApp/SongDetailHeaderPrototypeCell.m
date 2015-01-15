//
//  SongDetailHeaderPrototypeCell.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/13/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "SongDetailHeaderPrototypeCell.h"

@implementation SongDetailHeaderPrototypeCell

@synthesize song = _song;
@synthesize artist = _artist;

- (void)awakeFromNib {
    // Initialization code
    float buttonWidHgt = 24;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - buttonWidHgt - 10, self.frame.size.height - 40, buttonWidHgt, buttonWidHgt)];
    button.layer.cornerRadius = buttonWidHgt / 2;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor whiteColor] CGColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25.0f]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(-3.5, .25, 0, 0)];
    button.tag = 100;
    
    [self addSubview:button];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}


@end
