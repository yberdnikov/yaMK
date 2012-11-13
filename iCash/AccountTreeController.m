//
//  AccountTreeController.m
//  iCash
//
//  Created by Vitaly Merenkov on 07.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "AccountTreeController.h"
#import "CreateIncomeController.h"

@implementation AccountTreeController
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coreDataEntityDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:[self managedObjectContext]];
}

- (void)coreDataEntityDidChange:(NSNotification *)notification {
    if ([self sortDescriptors] && [[self sortDescriptors] count] != 0) {
        NSArray *insertedEntities = [[[notification userInfo] valueForKey:NSInsertedObjectsKey] valueForKeyPath:@"entity.name"];
        NSArray *updatedEntities  = [[[notification userInfo] valueForKey:NSUpdatedObjectsKey] valueForKeyPath:@"entity.name"];
        NSArray *deletedEntities  = [[[notification userInfo] valueForKey:NSDeletedObjectsKey] valueForKeyPath:@"entity.name"];
        
        NSString *entityName = [self entityName];
        if ([insertedEntities containsObject:entityName] || [updatedEntities containsObject:entityName] || [deletedEntities containsObject:entityName]) {
            [super rearrangeObjects];
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
    NSEntityDescription *accountEntity = [[[[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel] entitiesByName] objectForKey:@"Account"];
    Account *newAccount = [[Account alloc] initWithEntity:accountEntity insertIntoManagedObjectContext:[self managedObjectContext]];
    [newAccount setParent:[self selectedAccount]];
    [newAccount setType:[NSNumber numberWithInt:t]];
    [newAccount setTypeImage:[newAccount typeImage]];
    
}

- (IBAction)removeAccount:(id)sender {
    Account *account = [self selectedAccount];
    if (account) {
        [[self managedObjectContext] deleteObject:account];
    }
}

- (NSArray *)sortDescriptors {
    NSLog(@"get sort descriptor");
    return [NSArray arrayWithObjects:
            [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES],
            nil];
}


- (IBAction)showAddIncomeWindow:(id)sender {
    [_createIncomeCO setRecipientAccount: [self selectedAccount]];
    NSLog(@"selected account = %@",[[self selectedAccount] name]);
    [[self incomePopover] showRelativeToRect:[_outlineView rectOfRow:[_outlineView selectedRow]] ofView:_outlineView preferredEdge:NSMaxXEdge];
}

- (Account *) selectedAccount {
    NSTreeNode *selectedNode;
    NSLog(@"selectedRow = %ld", [_outlineView selectedRow]);
    // We are inserting as a child of the last selected node. If there are none selected, insert it as a child of the treeData itself
    if ([_outlineView selectedRow] != -1) {
        selectedNode = [_outlineView itemAtRow:[_outlineView selectedRow]];
        NSLog(@"selected item = %@",[_outlineView itemAtRow:[_outlineView selectedRow]]);
    }
    Account *nodeData = nil;
    if (selectedNode) {
        nodeData = [selectedNode representedObject];
    }
    return nodeData;
}

@end
