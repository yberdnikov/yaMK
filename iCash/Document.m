//
//  Document.m
//  iCash
//
//  Created by Vitaly Merenkov on 25.10.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "Document.h"
#import "CreateMoveController.h"

@implementation Document

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}



- (BOOL)configurePersistentStoreCoordinatorForURL:(NSURL*)url
                                           ofType:(NSString*)fileType
                               modelConfiguration:(NSString*)configuration
                                     storeOptions:(NSDictionary*)storeOptions
                                            error:(NSError**)error
{
    NSLog(@"url = %@", url);
    NSLog(@"fileType = %@", fileType);
    NSLog(@"configuration = %@", configuration);
    NSLog(@"storeOptions = %@", storeOptions);
    NSMutableDictionary *options = nil;
    
    if (storeOptions != nil) {
        options = [storeOptions mutableCopy];
    } else {
        options = [[NSMutableDictionary alloc] init];
    }
    
    [options setObject:[NSNumber numberWithBool:YES]
                forKey:NSMigratePersistentStoresAutomaticallyOption];
    
    BOOL result = [super configurePersistentStoreCoordinatorForURL:url
                                                            ofType:fileType
                                                modelConfiguration:configuration
                                                      storeOptions:options
                                                             error:error];
    NSLog(@"Error = %@", *error);
    return result;
}

@end
