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
        _albumImg = [track objectForKey:@"albumImg"];
        _albumImgLarge = [track objectForKey:@"albumImgLarge"];
        _song = [track objectForKey:@"song"];
        _artist = [track objectForKey:@"artist"];
        _trackNumber = [track objectForKey:@"trackNumber"];
        _album = [track objectForKey:@"album"];
        _iTunesLink = [track objectForKey:@"iTunesLink"];
        _iTunesRadioLink = [track objectForKey:@"iTunesRadioLink"];
        _lyricsId = [track objectForKey:@"lyricsId"];
}
    
    return self;
}
@end
