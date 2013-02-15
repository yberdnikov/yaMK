//
//  DetailsViewer.m
//  iCash
//
//  Created by Vitaly Merenkov on 11.02.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "DetailsViewContainer.h"
#import "DataSourceContainer.h"

@implementation DetailsViewContainer

-(id)initWithData:(DataSourceContainer *)data
             rect:(NSRect)rect
            label:(NSString *)label{
    self = [super init];
    if (self) {
        [self setDataCont:data];
        [self setRect:rect];
        [self setLabel:label];
    }
    return self;
}

@end
