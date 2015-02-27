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
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *song;
@property (weak, nonatomic) IBOutlet UILabel *artist;
@property (weak, nonatomic) IBOutlet UILabel *loadingPercentage;
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;

@end
