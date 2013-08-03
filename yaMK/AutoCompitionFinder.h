//
//  AutoCompitionFinder.h
//  iCash
//
//  Created by Vitaly Merenkov on 08.12.12.

//

#import <Foundation/Foundation.h>

@interface AutoCompitionFinder : NSObject
+ (NSArray *) findByFetchRequest:(NSFetchRequest *)request
                       startWith:(NSString *)sw;
@end
