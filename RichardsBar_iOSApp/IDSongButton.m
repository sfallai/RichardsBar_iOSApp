//
//  IDSongButton.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/22/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "IDSongButton.h"

@implementation IDSongButton

-(id) init {
    if(self = [super init]) {
        [self initialize];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)coder {
    if(self = [super initWithCoder:coder]) {
        [self initialize];
    }

    return  self;
}

-(void)initialize {
    
    [self addTarget:self action:@selector(btnIDSong_click:) forControlEvents:UIControlEventTouchDown];
    //self.layer.cornerRadius = 31;
}

-(IBAction)btnIDSong_click:(id)sender {
    
}

@end
