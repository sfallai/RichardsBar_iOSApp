//
//  track.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/3/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "disc.h"

@interface track : NSObject

-(id) initWithTrack: (NSDictionary*) track;

@property (strong, nonatomic) NSString *albumImg;
@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) NSString *song;
@property (strong, nonatomic) NSString *trackNumber;
@property (strong, nonatomic) NSString *album;
@property (strong, nonatomic) NSString *iTunesLink;
@property (strong, nonatomic) NSString *lyricsId;
@property (strong, nonatomic) NSString *albumImgLarge;
@property (strong, nonatomic) NSString *iTunesRadioLink;


@end
