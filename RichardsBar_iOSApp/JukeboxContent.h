//
//  JukeboxContent.h
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 1/2/15.
//  Copyright (c) 2015 RagingAlcoholics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "disc.h"

@interface JukeboxContent : NSObject

-(id) initWithJSONData;
-(disc *) getDiscFromIndex: (int) index;

@property (strong, nonatomic) NSMutableArray *discs;

@end



