//
//  AccountTreeController.m
//  iCash
//
//  Created by Vitaly Merenkov on 07.11.12.

//

#import "AccountTreeController.h"
#import "CreateIncomeController.h"
#import "CreateExpenseController.h"
#import "MainWindowToolbarController.h"

@implementation AccountTreeController


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coreDataEntityDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:[self managedObjectContext]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectionDidChange:) name:NSOutlineViewSelectionDidChangeNotification object:[self outlineView]];
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

- (IBAction)addExpenseAccount:(id)sender {
    [self addAccount:sender type:Expense];
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
    [newAccount setColorRed:[NSNumber numberWithDouble:((double)arc4random() / 0x100000000)]];
    [newAccount setColorGreen:[NSNumber numberWithDouble:((double)arc4random() / 0x100000000)]];
    [newAccount setColorBlue:[NSNumber numberWithDouble:((double)arc4random() / 0x100000000)]];
}

- (IBAction)removeAccount:(id)sender {
    Account *account = [self selectedAccount];
    if (account) {
        [[self managedObjectContext] deleteObject:account];
    }
}

- (NSArray *)sortDescriptors {
    NSLog(@"get sort descriptor");
    return [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
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

- (void)setTransactionsSortDescriptors:(NSArray *)transactionsSortDescriptors {
    
}

- (NSArray *)transactionsSortDescriptors {
    return [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO], [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES], nil];
    return nil;
}

- (void)selectionDidChange:(NSNotification *)notification {
    Account *account = [self selectedAccount];
    NSLog(@"selection did change account = %@", [account name]);
    if (account) {
        [_selectedAccountArrC setFilterPredicate:[NSCompoundPredicate orPredicateWithSubpredicates:[self buildPredicate:account]]];
    } else {
        [_selectedAccountArrC setFilterPredicate:nil];
    }
    if (account) {
        [_toolbarActionCO setSelectedAccount:account];
    } else {
        [_toolbarActionCO setSelectedAccount:nil];
    }
}

- (NSMutableArray *)buildPredicate:(Account *) account {
    NSMutableArray *predicates = [NSMutableArray array];
    
    if ([[account type] intValue] == Balance) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"recipient.name == %@" argumentArray:[NSArray arrayWithObject:[account name]]]];
        [predicates addObject:[NSPredicate predicateWithFormat:@"source.name == %@" argumentArray:[NSArray arrayWithObject:[account name]]]];
    } else if ([[account type] intValue] == Expense) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"recipient.name == %@" argumentArray:[NSArray arrayWithObject:[account name]]]];
    } else if ([[account type] intValue] == Income) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"source.name == %@" argumentArray:[NSArray arrayWithObject:[account name]]]];
    }
    for (Account *child in [account subAccounts]) {
        [predicates addObjectsFromArray:[self buildPredicate:child]];
    }
    return predicates;
}

- (NSArray *)transactionPredicate {
    Account *account = [self selectedAccount];
    NSMutableArray *predicates = [NSMutableArray array];
    if (account) {
        if ([[account type] intValue] == Balance) {
            [predicates addObject:[NSPredicate predicateWithFormat:@"recipient.name == %@" argumentArray:[NSArray arrayWithObject:[account name]]]];
            [predicates addObject:[NSPredicate predicateWithFormat:@"source.name == %@" argumentArray:[NSArray arrayWithObject:[account name]]]];
        } else if ([[account type] intValue] == Expense) {
            [predicates addObject:[NSPredicate predicateWithFormat:@"recipient.name == %@" argumentArray:[NSArray arrayWithObject:[account name]]]];
        } else if ([[account type] intValue] == Income) {
            [predicates addObject:[NSPredicate predicateWithFormat:@"source.name == %@" argumentArray:[NSArray arrayWithObject:[account name]]]];
        }
        for (Account *child in [account subAccounts]) {
            [predicates addObjectsFromArray:[self buildPredicate:child]];
        }
    } else {
        return nil;
    }
    return predicates;
}

- (void)setTransactionPredicate:(NSArray *)arr {
    
}

- (IBAction)searchFilter:(id)sender {
    NSLog(@"searchFilter '%ld'", [[_searchField stringValue] compare:@""]);
    [self setTransactionNameForSearch:[_searchField stringValue]];
    NSMutableArray *predicates = [NSMutableArray array];
    if ([_searchField stringValue] && [[_searchField stringValue] compare:@""] != 0) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"name BEGINSWITH %@" argumentArray:[NSArray arrayWithObject:[_searchField stringValue]]]];
    }
    if ([self selectedAccount]) {
        [predicates addObject:[NSCompoundPredicate orPredicateWithSubpredicates:[self buildPredicate:[self selectedAccount]]]];
    }
    if ([self selectedAccount] || ([_searchField stringValue]  && [[_searchField stringValue] compare:@""] != 0))
        [_selectedAccountArrC setFilterPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
    else
        [_selectedAccountArrC setFilterPredicate:nil];
}
@end
