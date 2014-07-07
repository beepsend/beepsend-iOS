//
//  BSAPStatistics.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPStatistics : BSSerializableObject

@property (nonatomic, strong) NSNumber *delivered;
@property (nonatomic, strong) NSNumber *mo;
@property (nonatomic, strong) NSNumber *expired;
@property (nonatomic, strong) NSNumber *unknown;
@property (nonatomic, strong) NSNumber *rejected;
@property (nonatomic, strong) NSNumber *undelivered;
@property (nonatomic, strong) NSNumber *no_dlr;

@end
