//
//  SelectedAccountArrayController.m
//  iCash
//
//  Created by Vitaly Merenkov on 15.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "SelectedAccountArrayController.h"
#import "Account.h"

@implementation SelectedAccountArrayController

- (void)awakeFromNib {
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectionDidChange:) name:NSOutlineViewSelectionDidChangeNotification object:[self accountOutlineView]];
}

- (void)selectionDidChange:(NSNotification *)notification {
    NSLog(@"selection did change account = %@", [[self selectedAccount] name]);
    [self rearrangeObjects];
}

- (Account *) selectedAccount {
    NSTreeNode *selectedNode;
    // We are inserting as a child of the last selected node. If there are none selected, insert it as a child of the treeData itself
    if ([_accountOutlineView selectedRow] != -1) {
        selectedNode = [_accountOutlineView itemAtRow:[_accountOutlineView selectedRow]];
    }
    Account *account = nil;
    if (selectedNode) {
        account = [selectedNode representedObject];
    }
    return account;
}

- (id)arrangedObjects {
    return [[self selectedAccount] viewedTransactions];
}

@end
