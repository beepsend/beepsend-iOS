//
//  BSAPEstimatedCost.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPEstimatedCost : BSSerializableObject

@property (nonatomic, strong) id to;
@property (nonatomic, strong) id groups;
@property (nonatomic, strong) NSNumber *total_cost;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
