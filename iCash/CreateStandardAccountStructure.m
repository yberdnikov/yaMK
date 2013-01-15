//
//  CreateStandardAccountStructure.m
//  iCash
//
//  Created by Vitaly Merenkov on 15.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "CreateStandardAccountStructure.h"
#import "Account.h"

@implementation CreateStandardAccountStructure

- (IBAction)createAccounts:(id)sender {
    
    Account *rootIncome = [self createAccount:Income name:@"Приход" parent:nil];
    Account *rootOutcome = [self createAccount:Outcome name:@"Расход" parent:nil];
    Account *rootBalance = [self createAccount:Balance name:@"Баланс" parent:nil];
    
    //incomes
    [self createAccount:Income name:@"Зарплата" parent:rootIncome];
    [self createAccount:Income name:@"Дополнительный заработок" parent:rootIncome];
    [self createAccount:Income name:@"Подарки" parent:rootIncome];
    //outcomes
    [self createAccount:Outcome name:@"Автомобиль" parent:rootOutcome];
    [self createAccount:Outcome name:@"Банковское Обслуживание" parent:rootOutcome];
    [self createAccount:Outcome name:@"Канцтовары" parent:rootOutcome];
    [self createAccount:Outcome name:@"Коммунальные Услуги" parent:rootOutcome];
    [self createAccount:Outcome name:@"Красота и Здоровье" parent:rootOutcome];
    [self createAccount:Outcome name:@"Медицинские Расходы" parent:rootOutcome];
    [self createAccount:Outcome name:@"Обеды" parent:rootOutcome];
    [self createAccount:Outcome name:@"Образование" parent:rootOutcome];
    [self createAccount:Outcome name:@"Общественный Транспорт" parent:rootOutcome];
    [self createAccount:Outcome name:@"Одежда" parent:rootOutcome];
    [self createAccount:Outcome name:@"Питание" parent:rootOutcome];
    [self createAccount:Outcome name:@"Подарки" parent:rootOutcome];
    [self createAccount:Outcome name:@"Развлечения" parent:rootOutcome];
    [self createAccount:Outcome name:@"Разное" parent:rootOutcome];
    [self createAccount:Outcome name:@"Страхование" parent:rootOutcome];
    [self createAccount:Outcome name:@"Хобби" parent:rootOutcome];
    [self createAccount:Outcome name:@"Хозтовары" parent:rootOutcome];
    //balance
    [self createAccount:Balance name:@"Наличные" parent:rootBalance];
    [self createAccount:Balance name:@"Банковские счета" parent:rootBalance];
    [self createAccount:Balance name:@"Спрятано" parent:rootBalance];
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
