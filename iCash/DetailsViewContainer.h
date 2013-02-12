//
//  DetailsViewer.h
//  iCash
//
//  Created by Vitaly Merenkov on 11.02.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DataSourceContainer;

@interface DetailsViewContainer : NSObject

@property DataSourceContainer *dataCont;
@property NSRect rect;

-(id)initWithData:(DataSourceContainer *)data
             rect:(NSRect)rect;

@end
