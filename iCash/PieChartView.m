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
    if (self) {
        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    _dataSource = [[AllAccountsDatasource alloc] init];
    NSBezierPath *greenPath = [NSBezierPath bezierPath] ;
    [[NSColor blackColor] set] ;
    // set some line width
    [greenPath setLineWidth: 2 ];
    // compute size and radius
    double size_x = [self frame].size.width;
    double size_y = [self frame].size.height;
    double radius = 0;
    if (size_x < size_y) {
        radius = size_x/3;
    } else {
        radius = size_y/3;
    }
        
    NSLog(@"dataSource = %@", _dataSource);
    NSDictionary *data = [_dataSource getData];
    NSLog(@"data = %@", data);
    double startAngle = 0;
    NSArray *keys = [data allKeys];
    NSUInteger keysSize = [keys count];
    char rgb = 1;
    char rgbMul = keysSize/3;
    AccountFinder *af = [[AccountFinder alloc] init];
    for (NSString *name in keys) {
        double perc = [[data valueForKey:name] doubleValue];
        // move to the center so that we have a closed slice
        // size_x and size_y are the height and width of the view
        
        [greenPath moveToPoint: NSMakePoint( size_x/2, size_y/2 ) ] ;
        
        // draw an arc (perc is a certain percentage ; something between 0 and 1
        [greenPath appendBezierPathWithArcWithCenter:NSMakePoint( size_x/2, size_y/2) radius:radius startAngle:startAngle endAngle: startAngle + 360 * perc];
        
        // close the slice , by drawing a line to the center
        [greenPath lineToPoint: NSMakePoint(size_x/2, size_y/2) ] ;
        [greenPath stroke] ;
        Account *a = [af findAccount:name];
        [[NSColor colorWithDeviceRed:[[a colorRed] doubleValue] green:[[a colorGreen] doubleValue] blue:[[a colorBlue] doubleValue] alpha:1] set];
        // and fill it
        [greenPath fill] ;
        startAngle = startAngle + 360 * perc;
        greenPath = [NSBezierPath bezierPath] ;
        [[NSColor blackColor] set] ;
        [greenPath setLineWidth: 2 ];
        
        if (rgb < 6) {
            rgb++;
        } else {
            rgb = 1;
            rgbMul++;
        }
    }
//    greenPath = [NSBezierPath bezierPath] ;
//    [[NSColor blackColor] set] ;
//    [greenPath setLineWidth: 2 ] ;
//    
//    // draw the second slice, now exploded from the original center
//
//    // so to get it exploded I move (10,7) points from the original center
//    // but on the imaginary circle (thats why the cos and the sin)
//    // note mide_angle is the angle halve way from the arc, you can experiment with multiple
//    // angles, note also that the angle is in degrees
//    [greenPath moveToPoint: NSMakePoint(size_x/2, size_y/2)] ;
//    
//    // and now draw the other slice
//    [greenPath appendBezierPathWithArcWithCenter:NSMakePoint( size_x/2 , size_y/2) radius:radius startAngle:360 * perc endAngle:360 ] ;
//    
//    // close the slice
//    [greenPath lineToPoint: NSMakePoint( size_x/2, size_y/2) ] ;
//    [greenPath stroke] ;
//    [[NSColor greenColor] set] ;
//    
//    [greenPath fill] ;
}

-(double)getRandom {
#define ARC4RANDOM_MAX      0x100000000

    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    return val;
}

@end
