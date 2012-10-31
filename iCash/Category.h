//
//  Category.h
//  iCash
//
//  Created by Vitaly Merenkov on 31.10.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account, Category;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Category *parent;
@property (nonatomic, retain) NSSet *account;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addAccountObject:(Account *)value;
- (void)removeAccountObject:(Account *)value;
- (void)addAccount:(NSSet *)values;
- (void)removeAccount:(NSSet *)values;

@end
