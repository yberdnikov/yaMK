//
//  PlaceOfSpendingFieldDelegate.m
//  iCash
//
//  Created by Vitaly Merenkov on 04.12.12.

//

#import "PlaceOfSpendingFieldDelegate.h"
#import "AutoCompitionFinder.h"

@implementation PlaceOfSpendingFieldDelegate

-(NSArray *)control:(NSControl *)control
           textView:(NSTextView *)textView
        completions:(NSArray *)words
forPartialWordRange:(NSRange)charRange
indexOfSelectedItem:(NSInteger *)index {
    
    NSLog(@"text = %@", [control stringValue]);
    NSString *nameStartsWith = [control stringValue];
    
    NSManagedObjectModel *mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    NSFetchRequest *fetchRequest = [mom fetchRequestFromTemplateWithName:@"findPlaceOfSpendingStartsWithName" substitutionVariables:@{@"NAME" : nameStartsWith}];
    
    *index = [[NSNumber numberWithInt:-1] integerValue];
    return [AutoCompitionFinder findByFetchRequest:fetchRequest startWith:nameStartsWith];
}
@end
