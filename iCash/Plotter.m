//
//  Plotter.m
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "Plotter.h"

@implementation Plotter

-(id)init {
    self = [super init];
    if (self) {
        [self setTrackingAreas:[NSMutableArray array]];
    }
    return self;
}

-(void)plot:(NSRect)rect{
    NSLog(@"Plotter plot");
}

- (CGRect) drawText:(CGContextRef)context
             pointX:(CGFloat)pointX
             pointY:(CGFloat)pointY
               text:(NSString *)text
           moveLeft:(BOOL)move
{
    return [self drawText:context pointX:pointX pointY:pointY text:text fontSize:18 moveLeft:move];
}
- (CGRect)drawText:(CGContextRef)context
            pointX:(CGFloat)pointX
            pointY:(CGFloat)pointY
              text:(NSString *)text
          fontSize:(double)fontSize
          moveLeft:(BOOL)move
    {
        // Prepare font
        CTFontRef font = CTFontCreateWithName(CFSTR("Times"), fontSize, NULL);
        
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

- (CGRect) drawText:(CGContextRef)context
             pointX:(CGFloat)pointX
             pointY:(CGFloat)pointY
               text:(NSString *)text
               font:(NSFont *)nsFont
           moveLeft:(BOOL)move {
    // Prepare font
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)([[[nsFont fontDescriptor] fontAttributes] valueForKey:NSFontNameAttribute]), [[[[nsFont fontDescriptor] fontAttributes] valueForKey:NSFontSizeAttribute] doubleValue], NULL);
    
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

- (CGContextRef) initContext:(NSRect)rect {
    CGRect pageRect;
    _context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    pageRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    CGContextBeginPage(_context, &pageRect);
    CGContextSetRGBFillColor(_context, 1, 1, 1, 1);
    CGContextFillRect(_context, NSRectToCGRect(rect));
    //  Start with black fill and stroke colors
    CGContextSetRGBStrokeColor(_context, 0, 0, 0, 1);
    //  The current path for the context starts out empty
    assert(CGContextIsPathEmpty(_context));
    return _context;
}

- (void) cleanUp:(CGContextRef) context {
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    CGContextEndPage(context);
    CGContextFlush(context);
}

@end
