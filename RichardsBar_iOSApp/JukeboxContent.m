//
//  JukeboxContent.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/2/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "JukeboxContent.h"

@implementation JukeboxContent

-(id) initWithJSONData {
    if(self = [self init]) {
        NSString* filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"JukeboxListing.json"];
        NSData* fileData = [NSData dataWithContentsOfFile:filePath];
        NSMutableDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:nil];
        NSArray *aryDiscs = [jsonDictionary objectForKey:@"discs"];
        
        for(NSDictionary *dict in aryDiscs) {
            [_discs addObject:[[disc alloc] initWithDisc:dict]];
        }

    }
    
    return self;
}

@end

@implementation disc

-(id) initWithDisc: (NSDictionary *) disc {
    if (self = [self init]) {
        NSArray *ary = [disc allValues];
        _discNumber = [ary objectAtIndex:0];
        
        for (NSDictionary *dict in [ary objectAtIndex:1]) {
            [_tracks addObject:[[track alloc] initWithTrack:dict]];
            
        }
    }
    
    return self;
}

@end

@implementation track

-(id) initWithTrack:(NSDictionary *) track {
    if (self = [self init]) {
        NSArray *ary = [track allValues];
        NSArray *a0 = [ary objectAtIndex:0];
        NSArray *a1 = [ary objectAtIndex:0];
        
        _albumImg = [a0 objectAtIndex:1];
        
//        _albumImg = track.albumImg;
//        _artist = track.artist;
//        _song = track.song;
//        _trackNumber = track.trackNumber;
    }
    
    return self;
}
@end