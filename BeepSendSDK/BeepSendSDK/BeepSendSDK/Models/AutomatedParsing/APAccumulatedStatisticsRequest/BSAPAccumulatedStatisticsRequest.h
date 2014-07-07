//
//  BSAPAccumulatedStatisticsRequest.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPAccumulatedStatisticsRequest : BSSerializableObject

@property (nonatomic, strong) NSString *from_date;
@property (nonatomic, strong) NSString *to_date;

@end
