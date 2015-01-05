//
//  JukeboxTrackCell.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/4/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JukeboxTrackCell : UITableViewCell

@property (strong, nonatomic) UILabel *mainLabel;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *detailText;
@property (strong, nonatomic) NSString *discNumber;
@property (strong, nonatomic) NSString *trackNumber;
@property (strong, nonatomic) NSData *albumImg;

@end
