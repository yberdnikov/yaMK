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
        _sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
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

- (IBAction)addIncomeAccount:(id)sender {
    [self addAccount:sender type:Income];
}

- (IBAction)addOutcomeAccount:(id)sender {
    [self addAccount:sender type:Outcome];
}

- (IBAction)addBalanceAccount:(id)sender {
    [self addAccount:sender type:Balance];
}

- (void)addAccount:(id)sender
              type:(AccountType)t {
    NSTreeNode *selectedNode;
    NSLog(@"selectedRow = %ld", [_outlineView selectedRow]);
    // We are inserting as a child of the last selected node. If there are none selected, insert it as a child of the treeData itself
    if ([_outlineView selectedRow] != -1) {
        selectedNode = [_outlineView itemAtRow:[_outlineView selectedRow]];
    }
       
    Account *nodeData = nil;
    if (selectedNode) {
        nodeData = [selectedNode representedObject];
    }
    NSLog(@"account.name = %@", [nodeData name]);
    NSEntityDescription *accountEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"Account"];
    Account *newAccount = [[Account alloc] initWithEntity:accountEntity insertIntoManagedObjectContext:[self managedObjectContext]];
    [newAccount setParent:nodeData];
    [newAccount setType:[NSNumber numberWithInt:t]];
    [newAccount setTypeImage:[newAccount typeImage]];
    
}

- (IBAction)removeAccount:(id)sender {
    NSTreeNode *selectedNode;
    NSLog(@"selectedRow = %ld", [_outlineView selectedRow]);
    // We are inserting as a child of the last selected node. If there are none selected, insert it as a child of the treeData itself
    if ([_outlineView selectedRow] != -1) {
        selectedNode = [_outlineView itemAtRow:[_outlineView selectedRow]];
    }
    
    Account *account = nil;
    if (selectedNode) {
        account = [selectedNode representedObject];
        [[self managedObjectContext] deleteObject:account];
    }
}

- (NSSortDescriptor *) sortDesc {
    return _sortDesc;
}

@end
