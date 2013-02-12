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
             rect:(NSRect)rect {
    self = [super init];
    if (self) {
        [self setDataCont:data];
        [self setRect:rect];
    }
    return self;
}

@end
