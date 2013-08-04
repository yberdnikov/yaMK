//
//  CreateStandardAccountStructure.m
//  iCash
//
//  Created by Vitaly Merenkov on 15.01.13.

//

#import "CreateStandardAccountStructure.h"
#import "Account.h"

@implementation CreateStandardAccountStructure

- (IBAction)createAccounts:(id)sender {
    
    Account *rootIncome = [self createAccount:Income name:NSLocalizedStringFromTable(@"Income",
                                                                                     @"DefaultAccounts",
                                                                                     @"Income") parent:nil];
    Account *rootExpense = [self createAccount:Expense name:NSLocalizedStringFromTable(@"Expense",
                                                                                       @"DefaultAccounts",
                                                                                       @"Expense") parent:nil];
    Account *rootBalance = [self createAccount:Balance name:NSLocalizedStringFromTable(@"Balance",
                                                                                       @"DefaultAccounts",
                                                                                       @"Balance") parent:nil];
    
    //incomes
    [self createAccount:Income name:NSLocalizedStringFromTable(@"Salary",
                                                               @"DefaultAccounts",
                                                               @"Salary") parent:rootIncome];
    [self createAccount:Income name:NSLocalizedStringFromTable(@"Supplemental Earnings",
                                                               @"DefaultAccounts",
                                                               @"Supplemental Earnings") parent:rootIncome];
    [self createAccount:Income name:NSLocalizedStringFromTable(@"Gifts",
                                                               @"DefaultAccounts",
                                                               @"Gifts") parent:rootIncome];
    //Expenses
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Car",
                                                                @"DefaultAccounts",
                                                                @"Car") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Banking Service",
                                                                @"DefaultAccounts",
                                                                @"Banking Service") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Stationary",
                                                                @"DefaultAccounts",
                                                                @"stationary") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Public Service",
                                                                @"DefaultAccounts",
                                                                @"Public Service") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Health and Beauty",
                                                                @"DefaultAccounts",
                                                                @"Health and Beauty") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Medical Expences",
                                                                @"DefaultAccounts",
                                                                @"Medical Expences") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Launch",
                                                                @"DefaultAccounts",
                                                                @"Launch") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Education",
                                                                @"DefaultAccounts",
                                                                @"Education") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Public Transport",
                                                                @"DefaultAccounts",
                                                                @"Public Transport") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Clothes",
                                                                @"DefaultAccounts",
                                                                @"Clothes") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Food",
                                                                @"DefaultAccounts",
                                                                @"Food") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Gifts",
                                                                @"DefaultAccounts",
                                                                @"Gifts") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Entertainment",
                                                                @"DefaultAccounts",
                                                                @"entertainment") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Others",
                                                                @"DefaultAccounts",
                                                                @"Others") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Insurance",
                                                                @"DefaultAccounts",
                                                                @"Insurance") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Hobby",
                                                                @"DefaultAccounts",
                                                                @"Hobby") parent:rootExpense];
    [self createAccount:Expense name:NSLocalizedStringFromTable(@"Household Goods",
                                                                @"DefaultAccounts",
                                                                @"Household Goods") parent:rootExpense];
    //balance
    [self createAccount:Balance name:NSLocalizedStringFromTable(@"Cash",
                                                                @"DefaultAccounts",
                                                                @"Cash") parent:rootBalance];
    [self createAccount:Balance name:NSLocalizedStringFromTable(@"Bank Accounts",
                                                                @"DefaultAccounts",
                                                                @"Bank Accounts") parent:rootBalance];
    [self createAccount:Balance name:NSLocalizedStringFromTable(@"Stash",
                                                                @"DefaultAccounts",
                                                                @"Stash") parent:rootBalance];
}

-(Account *) createAccount:(int)type
                      name:(NSString *)name
                    parent:(Account *)parent{
    NSManagedObjectContext *moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    NSManagedObjectModel *mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    NSEntityDescription *accountEntity = [[mom entitiesByName] objectForKey:@"Account"];
    
    Account *account = [[Account alloc] initWithEntity:accountEntity insertIntoManagedObjectContext:moc];
    [account setName:name];
    [account setParent:parent];
    [account setType:[NSNumber numberWithInt:type]];
    [account setTypeImage:[account typeImage]];
    [account setColorRed:[NSNumber numberWithDouble:((double)arc4random() / 0x100000000)]];
    [account setColorGreen:[NSNumber numberWithDouble:((double)arc4random() / 0x100000000)]];
    [account setColorBlue:[NSNumber numberWithDouble:((double)arc4random() / 0x100000000)]];
    return account;
}

@end
