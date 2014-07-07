//
//  BSAPNetworkDetailsResponse.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPPMCCMNC.h"
#import "BSAPStatistics.h"

@interface BSAPNetworkDetailsResponse : BSSerializableObject

@property (nonatomic, strong) BSAPPMCCMNC *mccmnc;
@property (nonatomic, strong) BSAPStatistics *statistics;
@property (nonatomic, strong) NSNumber *total;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
