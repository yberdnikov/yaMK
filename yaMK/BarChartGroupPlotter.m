//
//  BarChartGroupPlotter.m
//  iCash
//
//  Created by Vitaly Merenkov on 10.02.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "BarChartGroupPlotter.h"
#import "DataSourceContainer.h"
#import "math.h"

@implementation BarChartGroupPlotter

-(void)plot:(NSRect)rect {
    [self clearTrackingAreas];
    if ([self fastPlot]) {
        [super plot:rect];
        return;
    }
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:rect
                                                                options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
                                                                  owner:self userInfo:nil];
    [[self plotView] addTrackingArea:trackingArea];
    [[self trackingAreas] addObject:trackingArea];
    [self setDetails:[NSMutableArray array]];
    
    NSString *maxValString = [NSString stringWithFormat:@"%lu ", [self maxRoundedVal:[self findMaxValFromDataSet:[[self dataSource] dataUsingFilter:[self filters]]]]];
    
    double xSpace = [maxValString sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width + 5;
    double ySpace = [maxValString sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].height + 20;
    
    double emptySpaceMul = 0.25;
    double maxValue = [maxValString doubleValue];
    double maxHeight = 15.0/16.0 * (rect.size.height - ySpace * 2);
    
    NSString *maxLabelByWidth = [self findMaxLabelByWidthInDataSource];
    double minGroupWidth = [maxLabelByWidth sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width;
    double groupWidth = (4.0 * (rect.size.width - xSpace * 2)) / (5.0 * [[[self dataSource] data] count] + 1.0);
    if (groupWidth < minGroupWidth) {
        groupWidth = minGroupWidth;
    }
    double spaceWidth = groupWidth * emptySpaceMul;
    
    int groupNum = 0;
    
    CGContextRef context = [self initContext:rect];
    [self drawXYAxis:context rect:rect xSpace:xSpace ySpace:ySpace];
    [self drawMajorLines:context maxVal:maxValue rect:rect xSpace:xSpace ySpace:ySpace maxHeigth:maxHeight];
    
    for (DataSourceContainer *groupDS in [[self dataSource] dataUsingFilter:[self filters]]) {
        CGContextMoveToPoint(context, groupNum * spaceWidth + (groupNum + 1) * groupWidth + xSpace, ySpace);
        NSInteger groupSize = [[groupDS subData] count];
        int memberNum = 0;
        for (DataSourceContainer *dataCont in [groupDS subData]) {
            CGContextSetFillColorWithColor(context, [[dataCont color] CGColor]);
            double x = xSpace + groupWidth * groupNum + (1 + groupNum) * spaceWidth + (groupWidth / groupSize) * memberNum;
            CGRect rect = CGRectMake(x, ySpace, groupWidth / groupSize, [dataCont value] * maxHeight / maxValue);
            CGContextAddRect(context, rect);
            CGContextFillPath(context);
            memberNum++;
            [[self details] addObject:[[DetailsViewContainer alloc] initWithData:dataCont rect:rect label:[dataCont name]]];
        }
        double x = xSpace + groupWidth * groupNum + (1 + groupNum) * spaceWidth;
        [self drawParenthesis:ySpace x:x context:context groupWidth:groupWidth];
        NSSize labelSize = [[groupDS name] sizeWithAttributes:[NSDictionary dictionaryWithObject:[self font] forKey:NSFontAttributeName]];
        [self drawText:context pointX:(x + (groupWidth - labelSize.width) / 2) pointY:ySpace - labelSize.height - 10 text:[groupDS name] font:[self font] moveLeft:NO];
        groupNum++;
    }
    
    [self cleanUp:context];
}

- (void)drawParenthesis:(double)ySpace x:(double)x context:(CGContextRef)context groupWidth:(double)groupWidth {
    CGContextMoveToPoint(context, x, ySpace);
    CGContextAddCurveToPoint(context, x + 10, ySpace - 10, x + groupWidth / 2 - 10, ySpace, x + groupWidth / 2, ySpace - 10);
    CGContextStrokePath(context);
    CGContextMoveToPoint(context, x + groupWidth / 2, ySpace - 10);
    CGContextAddCurveToPoint(context, x + groupWidth / 2 + 10, ySpace, x + groupWidth - 10, ySpace - 10, x + groupWidth, ySpace);
    CGContextStrokePath(context);
}

-(double)findMaxValFromDataSet:(NSArray *)dataSet {
    double result = 0;
    for (DataSourceContainer *io in dataSet) {
        NSArray *ioDS = [io subData];
        for (DataSourceContainer *ds in ioDS) {
            if ([ds value] > result) {
                result = [ds value];
            }
        }
    }
    return result;
}

-(NSString *)findMaxLabelByWidthInDataSource {
    NSString *result;
    double maxWidth = 0;
    for (DataSourceContainer *dataCont in [[self dataSource] data]) {
        double lblWidth = [[dataCont name] sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width;
        if (lblWidth > maxWidth) {
            result = [[self dataSource] labelText:[dataCont name]];
        }
    }
    return result;
}

- (double)getMinBarWidth {
    return [@"9999.99" sizeWithAttributes:[[[self font] fontDescriptor] fontAttributes]].width / 1.6;
}

@end
