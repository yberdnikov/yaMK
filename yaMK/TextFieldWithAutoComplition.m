//
//  TextFieldWithAutoComplition.m
//  iCash
//
//  Created by Vitaly Merenkov on 08.12.12.

//

#import "TextFieldWithAutoComplition.h"

@implementation TextFieldWithAutoComplition

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

- (void) keyUp:(NSEvent *)theEvent {
    int keyCode = [theEvent.characters characterAtIndex:0];
//    The if block checks to make sure that the key pressed is not
//        backspace, delete, an arrow key, or any of that stuff that you really
//        don't want completion to happen after, then calls complete: on its
//        field editor (this is, as far as I know, equivalent to pressing ESC).
    if (
        NSUpArrowFunctionKey != keyCode &&
        NSDownArrowFunctionKey != keyCode &&
        NSLeftArrowFunctionKey != keyCode &&
        NSRightArrowFunctionKey != keyCode &&
        NSInsertFunctionKey != keyCode &&
        NSDeleteFunctionKey != keyCode &&
        NSHomeFunctionKey != keyCode &&
        NSBeginFunctionKey != keyCode &&
        NSEndFunctionKey != keyCode &&
        NSPageUpFunctionKey != keyCode &&
        NSPageDownFunctionKey != keyCode &&
        NSPrintScreenFunctionKey != keyCode &&
        NSScrollLockFunctionKey != keyCode &&
        NSPauseFunctionKey != keyCode &&
        NSSysReqFunctionKey != keyCode &&
        NSBreakFunctionKey != keyCode &&
        NSResetFunctionKey != keyCode &&
        NSStopFunctionKey != keyCode &&
        NSMenuFunctionKey != keyCode &&
        NSUserFunctionKey != keyCode &&
        NSSystemFunctionKey != keyCode &&
        NSPrintFunctionKey != keyCode &&
        NSClearLineFunctionKey != keyCode &&
        NSClearDisplayFunctionKey != keyCode &&
        NSInsertLineFunctionKey != keyCode &&
        NSDeleteLineFunctionKey != keyCode &&
        NSInsertCharFunctionKey != keyCode &&
        NSDeleteCharFunctionKey != keyCode &&
        NSPrevFunctionKey != keyCode &&
        NSNextFunctionKey != keyCode &&
        NSSelectFunctionKey != keyCode &&
        NSExecuteFunctionKey != keyCode &&
        NSUndoFunctionKey != keyCode &&
        NSRedoFunctionKey != keyCode &&
        NSFindFunctionKey != keyCode &&
        NSHelpFunctionKey != keyCode &&
        NSModeSwitchFunctionKey != keyCode
        && keyCode != 127
        && keyCode != 32
        && keyCode != 27
        && keyCode != 9
        ) {
        [self.currentEditor complete:self];
    }
    [super keyUp:theEvent];
}

-(void) complete:(id)sender {
    [super complete:sender];
}

@end
