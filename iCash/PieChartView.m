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
#import "math.h"


//#### utility code
//#define PI 3.14159265358979323846

static inline double radians(double degrees) { return degrees * M_PI / 180; }

static void
drawAnX(CGContextRef gc)
{
    CGPoint p;
    
    p = CGContextGetPathCurrentPoint(gc);
    CGContextMoveToPoint(gc, p.x + 3, p.y + 3);
    CGContextAddLineToPoint(gc, p.x - 3, p.y - 3);
    CGContextMoveToPoint(gc, p.x + 3, p.y - 3);
    CGContextAddLineToPoint(gc, p.x - 3, p.y + 3);
    CGContextStrokePath(gc);
}

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

- (void)drawRect:(NSRect)rect
{
    CGRect pageRect;
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    double centerX = rect.size.width / 2;
    double centerY = rect.size.height / 2;
    
    double radius = 0;
    if (rect.size.width < rect.size.height) {
        radius = rect.size.width/3;
    } else {
        radius = rect.size.height/3;
    }
    
    //#################################################################
    //##    Insert sample drawing code here
    //##
    //##    Note that at this point, the current context CTM is set up such that
    //##        that the context size corresponds to the size of the view
    //##        i.e. one unit in the context == one pixel
    //##    Also, the origin is in the bottom left of the view with +y pointing up
    //##
    //#################################################################
    
    pageRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    CGContextBeginPage(context, &pageRect);
    
    //  Start with black fill and stroke colors
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    
    //  The current path for the context starts out empty
    assert(CGContextIsPathEmpty(context));
    
    NSDictionary *data = [_dataSource getData];
    double startAngle = 0;
    double endAngle = 0;
    
    CGContextBeginPath(context);
    
    NSArray *keys = [data allKeys];
    for (NSString *name in keys) {
        double perc = [[[data valueForKey:name] valueForKey:@"value"] doubleValue];
        endAngle = startAngle + 360 * perc;
        Account *a = [[data valueForKey:name] valueForKey:@"account"];
        CGContextSetRGBFillColor(context, [[a colorRed] doubleValue], [[a colorGreen] doubleValue], [[a colorBlue] doubleValue], 1);
        CGContextAddArc(context, centerX, centerY, radius, radians(startAngle), radians(endAngle), 0);
        CGContextAddLineToPoint(context, centerX, centerY);
        CGContextFillPath(context);
        startAngle = endAngle;
    }
        
    CGContextSaveGState(context);
    
    CGContextRestoreGState(context);
    
    CGContextEndPage(context);
    
    CGContextFlush(context);
}

@end
