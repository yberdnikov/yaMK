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

@implementation BarChartPlotter

-(void)plot:(NSRect)rect {
    NSLog(@"BarChartPlotter drawRect");
    NSString *maxValString = [NSString stringWithFormat:@"%lu ", [self maxRoundedVal:[self findMaxValFromDataSet:[[self dataSource] data]]]];
    
    double xSpace = [maxValString sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width + 5;
    double ySpace = [maxValString sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].height + 20;
    
    double emptySpaceMul = 0.25;
    double maxValue = [self findMaxValFromDataSet:[[self dataSource] data]];
    double maxHeight = 15.0/16.0 * (rect.size.height - ySpace * 2);
    
    NSString *maxLabelByWidth = [self findMaxLabelByWidthInDataSource];
    double minGroupWidth = [maxLabelByWidth sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width;
    double groupWidth = (4.0 * (rect.size.width - xSpace * 2)) / (5.0 * [[[self dataSource] data] count] + 1.0);
    if (groupWidth < minGroupWidth) {
        groupWidth = minGroupWidth;
    }
    double spaceWidth = groupWidth * emptySpaceMul;
    
    double minGraphWidth = ([[[self dataSource] data] count] + 1.0) * spaceWidth + groupWidth * [[[self dataSource] data] count];
//    NSRect bounds = [[self plotView] bounds];
//    NSSize graphSize = rect.size;
//    if (groupWidth < minGroupWidth) {
//        graphSize.width = 1000;
//        bounds.size.width = 1000;
//    }
//    [[self plotView] setFrameSize:graphSize];
//    [[self plotView] setBoundsSize:bounds.size];
    
    int groupNum = 0;
    
    CGContextRef context = [self initContext:rect];
    [self drawXYAxis:context rect:rect xSpace:xSpace ySpace:ySpace];
    [self drawMajorLines:context maxVal:maxValue rect:rect xSpace:xSpace ySpace:ySpace maxHeigth:maxHeight];
    
    NSArray *keys = [[[self dataSource] data] allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for (id groupKey in keys) {
        CGContextMoveToPoint(context, groupNum * spaceWidth + (groupNum + 1) * groupWidth + xSpace, ySpace);
        NSDictionary *groupData = [[[self dataSource] data] objectForKey:groupKey];
        NSInteger groupSize = [groupData count];
        int memberNum = 0;
        for (DataSourceContainer *dataCont in [groupData allValues]) {
            CGContextSetFillColorWithColor(context, [[dataCont color] CGColor]);
            double x = xSpace + groupWidth * groupNum + (1 + groupNum) * spaceWidth + (groupWidth / groupSize) * memberNum;
            CGContextAddRect(context, CGRectMake(x, ySpace, groupWidth / groupSize, [dataCont value] * maxHeight / maxValue));
            CGContextFillPath(context);
            memberNum++;
        }
        double x = xSpace + groupWidth * groupNum + (1 + groupNum) * spaceWidth;
        [self drawParenthesis:ySpace x:x context:context groupWidth:groupWidth];
        NSString *groupLabel = [groupKey description];
        if ([[self dataSource] respondsToSelector:@selector(labelText:)]) {
            groupLabel = [[self dataSource] labelText:groupKey];
        }
        NSSize labelSize = [groupLabel sizeWithAttributes:[NSDictionary dictionaryWithObject:[self font] forKey:NSFontAttributeName]];
        [self drawText:context pointX:(x + (groupWidth - labelSize.width) / 2) pointY:ySpace - labelSize.height - 10 text:groupLabel font:[self font] moveLeft:NO];
        groupNum++;
    }
    
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    CGContextEndPage(context);
    CGContextFlush(context);
}

- (void)drawParenthesis:(double)ySpace x:(double)x context:(CGContextRef)context groupWidth:(double)groupWidth {
    CGContextMoveToPoint(context, x, ySpace);
    CGContextAddCurveToPoint(context, x + 10, ySpace - 10, x + groupWidth / 2 - 10, ySpace, x + groupWidth / 2, ySpace - 10);
    CGContextStrokePath(context);
    CGContextMoveToPoint(context, x + groupWidth / 2, ySpace - 10);
    CGContextAddCurveToPoint(context, x + groupWidth / 2 + 10, ySpace, x + groupWidth - 10, ySpace - 10, x + groupWidth, ySpace);
    CGContextStrokePath(context);
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
    NSArray *monthsVals = [dataSet allValues];
    double result = 0;
    for (NSMutableDictionary *io in monthsVals) {
        NSArray *ioDS = [io allValues];
        for (DataSourceContainer *ds in ioDS) {
            if ([ds value] > result) {
                result = [ds value];
            }
        }
    }
    return result;
}

-(NSInteger)maxRoundedVal:(double)maxVal {
    NSNumber *maxNum = [NSNumber numberWithInt:(int)maxVal];
    NSString *maxStr = [maxNum description];
    NSUInteger length = [maxStr length];
    NSInteger firstDigit = [maxStr characterAtIndex:0] - 48;
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

-(NSString *)findMaxLabelByWidthInDataSource {
    NSArray *labels = [[[self dataSource] data] allKeys];
    NSString *result;
    double maxWidth = 0;
    for (id labelId in labels) {
        double lblWidth = [[labelId description] sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width;
        if (lblWidth > maxWidth) {
            result = [[self dataSource] labelText:labelId];
        }
    }
    return result;
}

@end
