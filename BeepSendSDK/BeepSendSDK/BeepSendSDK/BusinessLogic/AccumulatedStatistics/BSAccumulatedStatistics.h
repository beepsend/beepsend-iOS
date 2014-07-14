//
//  BSAccumulatedStatisticsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSAccumulatedStatistics : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *account;
@property (nonatomic, strong, readonly) NSNumber *count;
@property (nonatomic, strong, readonly) NSNumber *price;

- (BSAccumulatedStatistics *)initWithAccount:(NSString *)account count:(NSNumber *)count price:(NSNumber *)price;

@end
