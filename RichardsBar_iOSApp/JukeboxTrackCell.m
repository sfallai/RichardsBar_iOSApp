//
//  JukeboxTrackCell.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/4/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "JukeboxTrackCell.h"

@implementation JukeboxTrackCell

@synthesize code = _code;
@synthesize song = _song;
@synthesize artist = _artist;
@synthesize albumImg = _albumImg;

- (void)awakeFromNib {
    // Initialization code
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Helpers
        CGSize size = self.contentView.frame.size;
        
        // Initialize Main Label
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 8.0, size.width - 16.0, size.height - 16.0)];
        
        // Configure Main Label
        [self.mainLabel setFont:[UIFont boldSystemFontOfSize:24.0]];
        [self.mainLabel setTextAlignment:NSTextAlignmentCenter];
        [self.mainLabel setTextColor:[UIColor orangeColor]];
        [self.mainLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Add Main Label to Content View
        [self.contentView addSubview:self.mainLabel];
    }
    
    return self;
}
@end
