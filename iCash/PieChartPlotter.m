//
//  PieChartView.m
//  iCash
//
//  Created by Vitaly Merenkov on 04.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartPlotter.h"
#import "DataSourceContainer.h"

//#### utility code


@implementation PieChartPlotter

- (double)getRadius:(NSRect)rect
{
    double radius = 0;
    if (rect.size.width < rect.size.height) {
        radius = rect.size.width/3;
    } else {
        radius = rect.size.height/3;
    }
    return radius;
}

- (void)plot:(NSRect)rect
{
    CGRect pageRect;
    CGContextRef context = [self initContext:rect];
    double centerX = rect.size.width / 2;
    double centerY = rect.size.height / 2;
    double radius = [self getRadius:rect];
    double startAngle = 0;
    double endAngle = 0;
    
    CGContextBeginPath(context);
    NSArray *data = [[self dataSource] dataUsingFilter:[self filters]];
    for (DataSourceContainer *cont in data) {
        double perc =[cont value];
        endAngle = startAngle + 360 * perc;
        CGColorRef color = [cont color].CGColor;
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
                                       title:[cont name]
                                        rect:pageRect];
        }
        startAngle = endAngle;
    }
    [self cleanUp:context];
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

- (NSMutableString *)getLabelText:(NSString *)name perc:(double)perc
{
    NSMutableString *labelText = [NSMutableString stringWithString:name];
    [labelText appendString:@" "];
    [labelText appendString:[[NSNumber numberWithInt:(perc * 100)] stringValue]];
    [labelText appendString:@"%"];
    return labelText;
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
    double centerOfAngle = startAngle + 360 * perc / 2;
    double pointCenX = centerX + (radius / 2) * cos(radians(centerOfAngle));
    double pointCenY = centerY + (radius / 2) * sin(radians(centerOfAngle));
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextAddArc(context, pointCenX, pointCenY, 2, 0, 2*M_PI, 1);
    CGContextFillPath(context);
    double lineEndX = centerX + (radius * 1.2) * cos(radians(centerOfAngle));
    double lineEndY = centerY + (radius * 1.2) * sin(radians(centerOfAngle));
    CGContextMoveToPoint(context, pointCenX, pointCenY);
    CGContextAddLineToPoint(context, lineEndX, lineEndY);
    
    NSMutableString *labelText;
    labelText = [self getLabelText:name perc:perc];
    BOOL moveLeft = NO;
    if (lineEndX < centerX) {
        moveLeft = YES;
    }
    CGRect textRect = [self drawText: context pointX:lineEndX + 1 pointY:lineEndY + 6 text:labelText moveLeft:moveLeft];
    
    if (moveLeft) {
        CGContextAddLineToPoint(context, lineEndX - textRect.size.width, lineEndY);
    } else {
        CGContextAddLineToPoint(context, lineEndX + textRect.size.width, lineEndY);
    }
    CGContextStrokePath(context);
}

- (NSRect) getMinSize:(NSRect)rect {
    [self setMinSize:NO];
    CGFloat width = 2 * [self findMaxLabelWidth] + [self getRadius:rect] * 2.0 + [self getRadius:rect] * 0.4;
    CGFloat height = [@"C" sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].height + [self getRadius:rect] * 2.0 + [self getRadius:rect] * 1.6;
    if (rect.size.width < width) {
        rect.size.width = width;
        [self setMinSize:YES];
    }
    if (rect.size.height < height) {
        rect.size.height = height;
        [self setMinSize:YES];
    }
    return rect;
}

- (double)findMaxLabelWidth {
    double result = 0;
    for (DataSourceContainer *dsc in [[self dataSource] data]) {
        double width = [[self getLabelText:[dsc name] perc:[dsc value]] sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width;
        if (width > result) {
            result = width;
        }
    }
    return result;
}

@end
