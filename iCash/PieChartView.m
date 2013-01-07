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

static inline double radians(double degrees) { return degrees * M_PI / 180; }

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
        CGColorRef color = [a color].CGColor;
        //draw sector
        [self drawSectorWithContext:context centerX:centerX centerY:centerY radius:radius startAngle:startAngle endAngle:endAngle color:color];
        if (perc > 0.05) {
            //draw comment
            [self drawSectorTitleWithContext:context
                                     centerX:centerX
                                     centerY:centerY
                                      radius:radius
                                  startAngle:startAngle
                                    endAngle:endAngle
                                     percent:perc
                                       title:name
                                        rect:pageRect];
        }
        startAngle = endAngle;
    }
    
    CGContextSaveGState(context);
    
    CGContextRestoreGState(context);
    
    CGContextEndPage(context);
    
    CGContextFlush(context);
}

- (void) drawSectorWithContext:(CGContextRef)context
                       centerX:(double)centerX
                       centerY:(double)centerY
                        radius:(double)radius
                    startAngle:(double)startAngle
                      endAngle:(double)endAngle
                         color:(CGColorRef)color
                      {
    CGContextSetFillColorWithColor(context, color);
    CGContextAddArc(context, centerX, centerY, radius, radians(startAngle), radians(endAngle), 0);
    CGContextAddLineToPoint(context, centerX, centerY);
    CGContextFillPath(context);
}

- (void) drawSectorTitleWithContext:(CGContextRef)context
                            centerX:(double)centerX
                            centerY:(double)centerY
                             radius:(double)radius
                         startAngle:(double)startAngle
                           endAngle:(double)endAngle
                            percent:(double)perc
                              title:(NSString *)name
                               rect:(CGRect)rect
{
    double pointCenX = centerX + (radius / 2) * cos(radians(startAngle + 360 * perc / 2));
    double pointCenY = centerY + (radius / 2) * sin(radians(startAngle + 360 * perc / 2));
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextAddArc(context, pointCenX, pointCenY, 2, 0, 2*M_PI, 1);
    CGContextFillPath(context);
    double lineEndX = centerX + (radius * 1.2) * cos(radians(startAngle + 360 * perc / 2));
    double lineEndY = centerY + (radius * 1.2) * sin(radians(startAngle + 360 * perc / 2));
    CGContextMoveToPoint(context, pointCenX, pointCenY);
    CGContextAddLineToPoint(context, lineEndX, lineEndY);
    
    NSMutableString *labelText = [NSMutableString stringWithString:name];
    [labelText appendString:@" "];
    [labelText appendString:[[NSNumber numberWithInt:(perc * 100)] stringValue]];
    [labelText appendString:@"%"];
    BOOL moveLeft = NO;
    if (lineEndX < centerX) {
        moveLeft = YES;
    }
    CGRect textRect = [self drawText: context rect:rect pointX:lineEndX + 1 pointY:lineEndY + 6 text:labelText moveLeft:moveLeft];
    
    if (moveLeft) {
        CGContextAddLineToPoint(context, lineEndX - textRect.size.width, lineEndY);
    } else {
        CGContextAddLineToPoint(context, lineEndX + textRect.size.width, lineEndY);
    }
    CGContextStrokePath(context);
}

- (CGRect) drawText:(CGContextRef)context
             rect:(CGRect)contextRect
           pointX:(CGFloat)pointX
           pointY:(CGFloat)pointY
             text:(NSString *)text
         moveLeft:(BOOL)move
{
    // Prepare font
    CTFontRef font = CTFontCreateWithName(CFSTR("Times"), 18, NULL);
    
    // Create an attributed string
    CFStringRef keys[] = { kCTFontAttributeName };
    CFTypeRef values[] = { font };
    CFDictionaryRef attr = CFDictionaryCreate(NULL, (const void **)&keys, (const void **)&values,
                                              sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFStringRef str = (__bridge CFStringRef)text;
    CFAttributedStringRef attrString = CFAttributedStringCreate(NULL, str, attr);
    CFRelease(attr);
    
    // Draw the string
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);  //Use this one when using standard view coordinates
    //CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0)); //Use this one if the view's coordinates are flipped
    CGRect lineBounds = CTLineGetImageBounds(line, context);
    if (move) {
        CGContextSetTextPosition(context, pointX - lineBounds.size.width, pointY);
    } else {
        CGContextSetTextPosition(context, pointX, pointY);
    }
    CTLineDraw(line, context);
        
    // Clean up
    CFRelease(line);
    CFRelease(attrString);
    CFRelease(font);
    return lineBounds;
}


@end
