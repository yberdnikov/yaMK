//
//  AccountFinder.m
//  iCash
//
//  Created by Vitaly Merenkov on 18.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "AccountFinder.h"

@implementation AccountFinder

- (Account *) findAccount:(NSString *)name
                     type:(AccountType)type{
    NSManagedObjectModel *_mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    NSManagedObjectContext *_moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    NSFetchRequest *findAccountByNameType = [_mom fetchRequestFromTemplateWithName:@"findAccountByNameType" substitutionVariables:@{@"NAME" : name, @"TYPE" : [NSNumber numberWithInt:type]}];
    NSError *error;
    NSArray *foundAccounts = [_moc executeFetchRequest:findAccountByNameType error:&error];
    Account *foundAccount;
    if ([foundAccounts count] > 0) {
        foundAccount = foundAccounts[0];
    }
    return foundAccount;
}

- (NSArray *) findAccounts:(AccountType)type {
    NSManagedObjectModel *_mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    NSManagedObjectContext *_moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    NSFetchRequest *findAccountByNameType = [_mom fetchRequestFromTemplateWithName:@"findAccountsByType" substitutionVariables:@{@"TYPE" : [NSNumber numberWithInt:type]}];
    NSError *error;
    NSArray *foundAccounts = [_moc executeFetchRequest:findAccountByNameType error:&error];
    return foundAccounts;
}

- (Account *) findAccount:(NSString *)name {
    NSManagedObjectModel *_mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    NSManagedObjectContext *_moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    NSFetchRequest *findAccountByNameType = [_mom fetchRequestFromTemplateWithName:@"findAccountByName" substitutionVariables:@{@"NAME" : name}];
    NSError *error;
    NSArray *foundAccounts = [_moc executeFetchRequest:findAccountByNameType error:&error];
    Account *foundAccount;
    if ([foundAccounts count] > 0) {
        foundAccount = foundAccounts[0];
    }
    return foundAccount;
}

@end
