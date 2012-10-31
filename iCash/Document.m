//
//  Document.m
//  iCash
//
//  Created by Vitaly Merenkov on 25.10.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "Document.h"
#import "Transaction.h"

@implementation Document

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
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
    NSLog(@"generate");
    NSEntityDescription *transactionEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"Transaction"];
    for (int i = 0; i < 100; i++) {
        Transaction *t = [[Transaction alloc] initWithEntity:transactionEntity insertIntoManagedObjectContext:[self managedObjectContext]];
        [t setName:@"test"];
        [t setValue:[NSNumber numberWithInt:i]];
    }
}
@end
