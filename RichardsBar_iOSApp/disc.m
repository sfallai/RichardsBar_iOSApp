//
//  disc.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/3/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "disc.h"

@implementation disc

-(track *) getTrackWithIndex: (int) index {
    return [_tracks objectAtIndex:index];
}

-(id) init {
    _tracks = [[NSMutableArray alloc] init];
    
    return self;
    
}

-(id) initWithDisc: (NSDictionary *) disc {
    if (self = [self init]) {
        _tracks = [[NSMutableArray alloc] init];
        
        NSArray *ary = [disc allValues];
        _discNumber = [ary objectAtIndex:0];
        
        for (NSDictionary *dict in [ary objectAtIndex:1]) {
            [_tracks addObject:[[track alloc] initWithTrack:dict]];
            
        }
    }
    
    return self;
}

@end
