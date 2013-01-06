//
//  PieChartDatasource.h
//  iCash
//
//  Created by Vitaly Merenkov on 04.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PieChartDatasource <NSObject>

-(NSDictionary *)getData;

@end
