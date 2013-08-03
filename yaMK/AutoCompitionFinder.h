//
//  AutoCompitionFinder.h
//  iCash
//
//  Created by Vitaly Merenkov on 08.12.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoCompitionFinder : NSObject
+ (NSArray *) findByFetchRequest:(NSFetchRequest *)request
                       startWith:(NSString *)sw;
@end
