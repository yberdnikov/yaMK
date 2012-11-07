//
//  Document.m
//  iCash
//
//  Created by Vitaly Merenkov on 25.10.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "Document.h"

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

- (IBAction)generateDummyData:(id)sender {
    NSLog(@"generate %@", [self managedObjectContext]);
    NSEntityDescription *categoryEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"Account"];
    for (int i = 0; i < 10; i++) {
        NSManagedObject *t = [[NSManagedObject alloc] initWithEntity:categoryEntity insertIntoManagedObjectContext:[self managedObjectContext]];
        [t setValue:@"aaa" forKey:@"name"];
        for (int j = 0; j < 5; j++) {
            NSManagedObject *bbb = [[NSManagedObject alloc] initWithEntity:categoryEntity insertIntoManagedObjectContext:[self managedObjectContext]];
            [bbb setValue:@"bbb" forKey:@"name"];
            [bbb setValue:t forKey:@"parent"];
        }
    }
}

@end
