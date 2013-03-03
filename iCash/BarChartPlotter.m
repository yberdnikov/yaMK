//
//  BarChartPlotter.m
//  iCash
//
//  Created by Vitaly Merenkov on 28.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "BarChartPlotter.h"
#import "DataSourceContainer.h"
#import "math.h"
#import "DetailsViewContainer.h"

@implementation BarChartPlotter

-(void)plot:(NSRect)rect {
    [self clearTrackingAreas];
    NSString *maxValString = [NSString stringWithFormat:@"%lu ", [self maxRoundedVal:[self findMaxValFromDataSet:[[self dataSource] data]]]];
    
    double xSpace = [maxValString sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width + 5;
    double ySpace = [maxValString sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].height + 20;
    
    double emptySpaceMul = 0.25;
    double maxValue = [maxValString doubleValue];
    double maxHeight = 15.0/16.0 * (rect.size.height - ySpace * 2);
    
    double barWidth = (rect.size.width - 2.0 * xSpace - 13) / (double)([[[self dataSource] data] count])/(1.0 + emptySpaceMul);
    double spaceWidth = barWidth * emptySpaceMul;

    CGContextRef context = [self initContext:[[self plotView] bounds]];
    [self drawXYAxis:context rect:[[self plotView] bounds] xSpace:xSpace ySpace:ySpace];
    [self drawMajorLines:context maxVal:maxValue rect:[[self plotView] bounds] xSpace:xSpace ySpace:ySpace maxHeigth:maxHeight];
    
    NSArray *keys = [[[self dataSource] data] allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    int memberNum = 0;
    [self setDetails:[NSMutableArray array]];
    for (id groupKey in keys) {
        CGContextMoveToPoint(context, spaceWidth + barWidth * memberNum + xSpace, ySpace);
        DataSourceContainer *dataCont = [[[self dataSource] data] objectForKey:groupKey];
        
        CGContextSetFillColorWithColor(context, [[dataCont color] CGColor]);
        double x = xSpace + spaceWidth + (barWidth + spaceWidth) * memberNum;
        CGRect barRect = CGRectMake(x, ySpace, barWidth, [dataCont value] * maxHeight / maxValue);
        CGContextAddRect(context, barRect);
        NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:barRect
                                                                    options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
                                                                      owner:self userInfo:nil];
        [[self plotView] addTrackingArea:trackingArea];
        [[self trackingAreas] addObject:trackingArea];
        [_details addObject:[[DetailsViewContainer alloc] initWithData:dataCont rect:barRect label:groupKey]];
        CGContextFillPath(context);
        memberNum++;
    }
    
    [self cleanUp:context];
}

-(void)clearTrackingAreas {
    for (NSTrackingArea *ta in [self trackingAreas]) {
        [[self plotView] removeTrackingArea:ta];
    }
    [[self trackingAreas] removeAllObjects];
}

-(void)drawXYAxis:(CGContextRef)context
             rect:(NSRect)rect
           xSpace:(double)xSpace
           ySpace:(double)ySpace {
    CGContextBeginPath(context);
    CGContextSetFillColorWithColor(context, CGColorCreateGenericRGB(0, 1, 1, 0.5));
    CGContextMoveToPoint(context, xSpace, ySpace);
    CGContextAddLineToPoint(context, rect.size.width - xSpace, ySpace);
    double arrowLength = 10;
    double arrowAngle = 30;
    CGContextAddLineToPoint(context, (rect.size.width - xSpace) + arrowLength * cos(radians(180 - arrowAngle / 2)), ySpace + arrowLength * sin(radians(180 - arrowAngle / 2)));
    CGContextMoveToPoint(context, rect.size.width - xSpace, ySpace);
    CGContextAddLineToPoint(context, (rect.size.width - xSpace) + arrowLength * cos(radians(180 + arrowAngle / 2)), ySpace + arrowLength * sin(radians(180 + arrowAngle / 2)));
    CGContextMoveToPoint(context, xSpace, ySpace);
    CGContextAddLineToPoint(context, xSpace, rect.size.height - ySpace);
    CGContextAddLineToPoint(context, xSpace + arrowLength * cos(radians(270 - arrowAngle / 2)), (rect.size.height - ySpace) + arrowLength * sin(radians(270 - arrowAngle / 2)));
    CGContextMoveToPoint(context, xSpace, rect.size.height - ySpace);
    CGContextAddLineToPoint(context, xSpace + arrowLength * cos(radians(270 + arrowAngle / 2)), (rect.size.height - ySpace) + arrowLength * sin(radians(270 + arrowAngle / 2)));
    CGContextStrokePath(context);
}

-(double)findMaxValFromDataSet:(NSDictionary *)dataSet {
    NSArray *ioDS = [dataSet allValues];
    double result = 0;
    for (DataSourceContainer *ds in ioDS) {
        if ([ds value] > result) {
            result = [ds value];
        }
    }
    return result;
}

-(NSInteger)maxRoundedVal:(double)maxVal {
    NSNumber *maxNum = [NSNumber numberWithInt:(int)maxVal];
    NSString *maxStr = [maxNum description];
    NSUInteger length = [maxStr length];
    NSInteger firstDigit = ([maxStr characterAtIndex:1] - 48 < 5 ) ? [maxStr characterAtIndex:0] - 48 : [maxStr characterAtIndex:0] - 48 + 1;
    NSInteger maxInt = firstDigit * powf(10, length - 1);
    return maxInt;
}

-(void)drawMajorLines:(CGContextRef)context
               maxVal:(double)maxVal
                 rect:(NSRect)rect
               xSpace:(double)xSpace
               ySpace:(double)ySpace
            maxHeigth:(double)maxHeight{
    NSInteger maxRoundedVal = [self maxRoundedVal:maxVal];
    char sub = 5;
    NSInteger lineVal = maxRoundedVal / sub ;
    CGFloat pattern[2] = {10, 10};
    CGContextSetLineDash(context, 0, pattern, 2);
    while (sub > 0) {
        sub--;
        CGContextMoveToPoint(context, xSpace, (maxRoundedVal - lineVal * sub) * maxHeight / maxVal + ySpace);
        CGContextAddLineToPoint(context, rect.size.width - xSpace, (maxRoundedVal - lineVal * sub) * maxHeight / maxVal + ySpace);
        CGContextStrokePath(context);
        NSString *lbl = [[NSNumber numberWithInteger:maxRoundedVal - lineVal * sub] description];
        [self drawText:context pointX:5 pointY:(maxRoundedVal - lineVal * sub) * maxHeight / maxVal + ySpace text:lbl font:[self font] moveLeft:NO];
    }
    CGFloat defPattern[1] = {0};
    CGContextSetLineDash(context, 0, defPattern, 0);
}

- (void)mouseEntered:(NSEvent *)theEvent {
    NSPoint globalLocation = [theEvent locationInWindow];
    NSPoint viewLocation = [[self plotView] convertPoint: globalLocation fromView: nil ];
    for (DetailsViewContainer *dvc in _details) {
        if (NSPointInRect(viewLocation, [dvc rect])) {
            NSLog(@"val = %f", [[dvc dataCont] value]);
            [self showPopover:dvc];
            break;
        }
    }
}

- (void)mouseExited:(NSEvent *)theEvent {
    [[[self plotView] details] close];
}

- (void)showPopover:(DetailsViewContainer *)dvc {
    if (![[[self plotView] details] isShown]) {
        [[[self plotView] details] showRelativeToRect:[dvc rect] ofView:[self plotView] preferredEdge:NSMaxYEdge];
        [[self plotView] setDetailsVC:dvc];
    }
}

- (NSRect)getMinSize:(NSRect)rect {
    NSString *maxValString = [NSString stringWithFormat:@"%lu ", [self maxRoundedVal:[self findMaxValFromDataSet:[[self dataSource] data]]]];
    
    double xSpace = [maxValString sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width + 5;
    double ySpace = [maxValString sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].height + 20;
    
    double emptySpaceMul = 0.25;
    
    double letterHeight = [@"C" sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].height;
    double spaceWidth = letterHeight * emptySpaceMul;
    
    double minGraphWidth = ([[[self dataSource] data] count] + 1.0) * spaceWidth + letterHeight * [[[self dataSource] data] count] + 2 * xSpace;
    
    NSRect result = rect;
    CGFloat width = minGraphWidth + 2 * xSpace;
    CGFloat height = letterHeight * 5 + 2 * ySpace;
    
    if (width > rect.size.width) {
        result.size.width = width;
    }
    if (height > rect.size.height) {
        result.size.height = height;
    }
    return result;
}

- (void)mouseMoved:(NSEvent *)theEvent {
    NSPoint globalLocation = [theEvent locationInWindow];
    NSPoint viewLocation = [[self plotView] convertPoint: globalLocation fromView: nil ];
    BOOL isShow = NO;
    for (DetailsViewContainer *dvc in _details) {
        if (NSPointInRect(viewLocation, [dvc rect])) {
            NSLog(@"val = %f", [[dvc dataCont] value]);
            [self showPopover:dvc];
            isShow = YES;
        }
    }
}

@end
