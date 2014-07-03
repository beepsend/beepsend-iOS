//
//  BSAPAccumulatedStatisticsResponse.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPAccumulatedStatisticsResponse : BSSerializableObject

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *price;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
