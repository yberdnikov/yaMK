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
    
    double xSpace = 1.0/16.0 * rect.size.width;
    double ySpace = 1.0/8.0 * rect.size.height;
    
    double maxValue = [self findMaxVal:[[self dataSource] data]];
    double maxHeight = 15.0/16.0 * (rect.size.height - ySpace * 2);
    double groupWidth = (4.0 * (rect.size.width - xSpace * 2)) / (5.0 * [[[self dataSource] data] count] + 1.0);
    double spaceWidth = groupWidth / 4.0;
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
        double fontSize = [self defineMaxFontSizeForString:groupLabel width:groupWidth height:(ySpace - 15)];
        NSSize labelSize = [groupLabel sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Times" size:fontSize] forKey:NSFontAttributeName]];
        [self drawText:context pointX:(x + (groupWidth - labelSize.width) / 2) pointY:ySpace - labelSize.height - 10 text:groupLabel fontSize:fontSize moveLeft:NO];
        groupNum++;
    }
    
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    CGContextEndPage(context);
    CGContextFlush(context);
}

-(double)defineMaxFontSizeForString:(NSString *)string
                              width:(double)stringWidth
                             height:(double)stringHeight;
{
//    double goldNum = 2.0 / (1.0 + sqrt(5));
//    double minFont = 1;
//    double maxFont = 256;
//    double delta = 0.1;
//    double minWidth = 0;
//    double maxWidth = 100000;
//    minWidth = [string sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Times" size:minFont] forKey:NSFontAttributeName]].width;
//    maxWidth = [string sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Times" size:maxFont] forKey:NSFontAttributeName]].width;
//    NSSize fontSize;
//    double result = 0;
//    while ((fabs(maxWidth - stringWidth) > delta && fabs(minWidth - stringWidth) > delta) && (maxFont > 2)) {
//        if (fabs(maxWidth - stringWidth) < fabs(minWidth - stringWidth)) {
//            minFont = maxFont - (maxFont - minFont) * goldNum;
//            fontSize = [string sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Times" size:minFont] forKey:NSFontAttributeName]];
//            minWidth = fontSize.width;
//            result = minFont;
//        } else {
//            maxFont = minFont + (maxFont - minFont) * goldNum;
//            fontSize = [string sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Times" size:maxFont] forKey:NSFontAttributeName]];
//            maxWidth = fontSize.width;
//            result = maxFont;
//        }
//    }
//    if (fontSize.height > stringHeight) {
//        minFont = 1;
//        maxFont = result;
//    }
//    while (fontSize.height > stringHeight && result > 0) {
//        result -= 0.5;
//        fontSize = [string sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Times" size:result] forKey:NSFontAttributeName]];
//    }
    return 14;
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

-(double)findMaxVal:(NSDictionary *)dataSet {
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
        [self drawText:context pointX:5 pointY:(maxRoundedVal - lineVal * sub) * maxHeight / maxVal + ySpace text:lbl fontSize:[self defineMaxFontSizeForString:lbl width:xSpace - 10 height:ySpace] moveLeft:NO];
    }
    CGFloat defPattern[1] = {0};
    CGContextSetLineDash(context, 0, defPattern, 0);
}

@end
