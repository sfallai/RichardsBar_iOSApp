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

//-(id) initWithFrame:(CGRect)frame {
//    if(self = [super initWithFrame:frame]) {
//        [self initialize];
//    }
//    return self;
//}

-(id) initWithCoder:(NSCoder *)coder {
    if(self = [super initWithCoder:coder]) {
        [self initialize];
    }

    return  self;
}

-(void)initialize {
    //get the button image for the frame size
    UIImage* buttonImage = [UIImage imageNamed:@"audiowave"];
    [self setImage:buttonImage];
    
    [self setAction:@selector(btnIDSong_Click:)];
    
}

-(void) btnIDSong_Click: (UIViewController *) sender {
    [sender performSegueWithIdentifier:@"idSongResultSegue" sender:sender];
    
}

@end
