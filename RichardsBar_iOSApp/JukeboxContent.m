//
//  JukeboxContent.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/2/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import "JukeboxContent.h"

@implementation JukeboxContent

-(disc *) getDiscFromIndex: (int) index{
    return [_discs objectAtIndex: index];
}

-(id) initWithJSONData {
    if(self = [self init]) {
        _discs = [[NSMutableArray alloc] init];
        
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