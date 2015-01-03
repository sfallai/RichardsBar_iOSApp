//
//  track.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/3/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "track.h"

@implementation track

-(id) initWithTrack:(NSDictionary *) track {
    if (self = [self init]) {
        NSArray *ary = [track allValues];
        
        _albumImg = [ary objectAtIndex:1];
        _song = [ary objectAtIndex:2];
        _artist = [ary objectAtIndex:3];
        _trackNumber = [ary objectAtIndex:0];
        
        //        _albumImg = track.albumImg;
        //        _artist = track.artist;
        //        _song = track.song;
        //        _trackNumber = track.trackNumber;
    }
    
    return self;
}
@end
