//
//  PieChartView.m
//  iCash
//
//  Created by Vitaly Merenkov on 04.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartView.h"
#import "AllAccountsDatasource.h"
#import "AccountFinder.h"

@implementation PieChartView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    NSLog(@"initWithFrame");
    if (self) {
        NSLog(@"initWithFrame");
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    
    // compute size and radius
    double size_x = [self frame].size.width;
    double size_y = [self frame].size.height;
    double radius = 0;
    if (size_x < size_y) {
        radius = size_x/3;
    } else {
        radius = size_y/3;
    }
        
    NSDictionary *data = [_dataSource getData];
    double startAngle = 0;
    double endAngle = 0;
    NSArray *keys = [data allKeys];
    for (NSString *name in keys) {
        NSBezierPath *greenPath = [NSBezierPath bezierPath] ;
        [[NSColor blackColor] set] ;
        // set some line width
        [greenPath setLineWidth: 2 ];
        double perc = [[[data valueForKey:name] valueForKey:@"value"] doubleValue];
        endAngle = startAngle + 360 * perc;
        // move to the center so that we have a closed slice
        // size_x and size_y are the height and width of the view
        
        [greenPath moveToPoint: NSMakePoint( size_x/2, size_y/2 ) ] ;
        
        // draw an arc (perc is a certain percentage ; something between 0 and 1
        [greenPath appendBezierPathWithArcWithCenter:NSMakePoint( size_x/2, size_y/2) radius:radius startAngle:startAngle endAngle: endAngle];
        
        // close the slice , by drawing a line to the center
        [greenPath lineToPoint: NSMakePoint(size_x/2, size_y/2) ] ;
        [greenPath stroke] ;
        Account *a = [[data valueForKey:name] valueForKey:@"account"];
        [[NSColor colorWithDeviceRed:[[a colorRed] doubleValue] green:[[a colorGreen] doubleValue] blue:[[a colorBlue] doubleValue] alpha:1] set];
        // and fill it
        [greenPath fill] ;
        startAngle = endAngle;
        greenPath = [NSBezierPath bezierPath] ;
        [[NSColor blackColor] set] ;
        [greenPath setLineWidth: 2 ];
    }
}

@end
