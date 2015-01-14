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
