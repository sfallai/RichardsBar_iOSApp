//
//  disc.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/3/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "track.h"

@interface disc : NSObject

-(id) initWithDisc: (NSDictionary*) disc;


@property (strong, nonatomic) NSString *discNumber;
@property (strong, nonatomic) NSMutableArray *tracks;

@end
