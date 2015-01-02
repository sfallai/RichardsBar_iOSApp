//
//  JukeboxContent.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/2/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JukeboxContent : NSObject

-(id) initWithJSONData;

@property (strong, nonatomic) NSMutableArray *discs;

@end

//////////////////////////////////////////////////////////////////////////

@interface disc : JukeboxContent

-(id) initWithDisc: (NSDictionary*) disc;

@property (strong, nonatomic) NSString *discNumber;
@property (strong, nonatomic) NSMutableArray *tracks;

@end

//////////////////////////////////////////////////////////////////////////

@interface track : disc

-(id) initWithTrack: (NSDictionary*) track;

@property (strong, nonatomic) NSString *albumImg;
@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) NSString *song;
@property (strong, nonatomic) NSString *trackNumber;

@end


