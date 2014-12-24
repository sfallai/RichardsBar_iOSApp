//
//  IDSongToolBar.m
//  RichardsBar_iOSApp
//
//  Created by Simon Fallai on 12/23/14.
//  Copyright (c) 2014 RagingAlcoholics. All rights reserved.
//

#import "IDSongToolBar.h"
#import "IDSongButton.h"

@implementation IDSongToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initialize {
//    IDSongButton *button = [[IDSongButton alloc] init];
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    
//    [self setItems:[[NSArray alloc] initWithObjects:spacer, barButton, spacer, nil] animated:YES];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Something" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self setItems:[[NSArray alloc] initWithObjects:button, nil]];
    
}

#pragma mark - toolbar initializers

- (id)initWithCoder:(NSCoder*)aDecoder {
    self = [super initWithCoder:aDecoder];
    if( self ) {
        [self initialize];
    }
    return self;
}

-(id) init {
    if (self = [super init]) {
        [self initialize];
    }
    
    return self;
    
}

-(id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    
    return self;
}

@end
