//
//  Plotter.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Datasource.h"
#import "math.h"
#import "PlotView.h"
#import "DetailsViewContainer.h"

@interface Plotter : NSResponder

@property NSObject<DataSource> *dataSource;
@property (strong) NSFont *font;
@property (weak) PlotView *plotView;
@property (weak) NSScrollView *scrollView;
@property CGContextRef context;
@property DetailsViewContainer *selectedDV;
@property NSMutableArray *trackingAreas;
@property NSPredicate *filters;
@property BOOL fastPlot;

-(void)plot:(NSRect)rect;
- (CGRect) drawText:(CGContextRef)context
             pointX:(CGFloat)pointX
             pointY:(CGFloat)pointY
               text:(NSString *)text
           moveLeft:(BOOL)move;

- (CGRect) drawText:(CGContextRef)context
             pointX:(CGFloat)pointX
             pointY:(CGFloat)pointY
               text:(NSString *)text
           fontSize:(double)fontSize
           moveLeft:(BOOL)move;

- (CGRect) drawText:(CGContextRef)context
             pointX:(CGFloat)pointX
             pointY:(CGFloat)pointY
               text:(NSString *)text
               font:(NSFont *)font
           moveLeft:(BOOL)move;


- (CGContextRef) initContext:(NSRect)rect;
- (void) cleanUp:(CGContextRef)context;

- (void)setZoom:(CGFloat)scaleFactor;

- (NSRect)getMinSize:(NSRect)rect;

@end

static inline double radians(double degrees) { return degrees * M_PI / 180; }