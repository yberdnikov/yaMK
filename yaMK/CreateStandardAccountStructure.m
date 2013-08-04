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
    Account *rootOutcome = [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Outcome",
                                                                                       @"DefaultAccounts",
                                                                                       @"Outcome") parent:nil];
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
    //outcomes
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Car",
                                                                @"DefaultAccounts",
                                                                @"Car") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Banking Service",
                                                                @"DefaultAccounts",
                                                                @"Banking Service") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Stationary",
                                                                @"DefaultAccounts",
                                                                @"stationary") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Public Service",
                                                                @"DefaultAccounts",
                                                                @"Public Service") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Health and Beauty",
                                                                @"DefaultAccounts",
                                                                @"Health and Beauty") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Medical Expences",
                                                                @"DefaultAccounts",
                                                                @"Medical Expences") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Launch",
                                                                @"DefaultAccounts",
                                                                @"Launch") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Education",
                                                                @"DefaultAccounts",
                                                                @"Education") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Public Transport",
                                                                @"DefaultAccounts",
                                                                @"Public Transport") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Clothes",
                                                                @"DefaultAccounts",
                                                                @"Clothes") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Food",
                                                                @"DefaultAccounts",
                                                                @"Food") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Gifts",
                                                                @"DefaultAccounts",
                                                                @"Gifts") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Entertainment",
                                                                @"DefaultAccounts",
                                                                @"entertainment") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Others",
                                                                @"DefaultAccounts",
                                                                @"Others") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Insurance",
                                                                @"DefaultAccounts",
                                                                @"Insurance") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Hobby",
                                                                @"DefaultAccounts",
                                                                @"Hobby") parent:rootOutcome];
    [self createAccount:Outcome name:NSLocalizedStringFromTable(@"Household Goods",
                                                                @"DefaultAccounts",
                                                                @"Household Goods") parent:rootOutcome];
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
