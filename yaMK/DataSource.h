//
//  PieChartDatasource.h
//  iCash
//
//  Created by Vitaly Merenkov on 04.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataSource <NSObject>

@required
-(NSArray *)data;
-(NSArray *)dataUsingFilter:(NSPredicate *)predicate;
-(BOOL)recalculate;
-(void)setRecalculate:(BOOL)recalc;

@optional
-(NSString *)labelText:(id)label;

@end
