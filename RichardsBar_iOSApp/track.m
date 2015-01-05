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
        
        _albumImg = [track objectForKey:@"albumImg"];
        _song = [track objectForKey:@"song"];
        _artist = [track objectForKey:@"artist"];
        _trackNumber = [track objectForKey:@"trackNumber"];
        _album = [track objectForKey:@"album"];
        _iTunesLink = [track objectForKey:@"iTunesLink"];
        _lyricsId = [track objectForKey:@"lyricsId"];
        
        //        _albumImg = track.albumImg;
        //        _artist = track.artist;
        //        _song = track.song;
        //        _trackNumber = track.trackNumber;
    }
    
    return self;
}
@end
