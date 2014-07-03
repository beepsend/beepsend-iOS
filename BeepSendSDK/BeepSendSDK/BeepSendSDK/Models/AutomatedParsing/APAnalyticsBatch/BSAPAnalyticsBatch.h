//
//  BSAPAnalyticsBatch.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPStatistics.h"

@interface BSAPAnalyticsBatch : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) BSAPStatistics *statistics;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
