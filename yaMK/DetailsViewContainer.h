//
//  DetailsViewer.h
//  iCash
//
//  Created by Vitaly Merenkov on 11.02.13.

//

#import <Cocoa/Cocoa.h>

@class DataSourceContainer;

@interface DetailsViewContainer : NSObject

@property DataSourceContainer *dataCont;
@property NSString *label;
@property NSRect rect;

-(id)initWithData:(DataSourceContainer *)data
             rect:(NSRect)rect
            label:(NSString *)label;

@end
