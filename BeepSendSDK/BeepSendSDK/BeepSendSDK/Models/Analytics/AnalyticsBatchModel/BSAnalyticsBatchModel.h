//
//  BSAnalyticsBatchModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSStatisticsModel.h"

@interface BSAnalyticsBatchModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *label;
@property (nonatomic, strong, readonly) NSNumber *total;
@property (nonatomic, strong, readonly) BSStatisticsModel *statistic;

- (BSAnalyticsBatchModel *)initWithID:(NSString *)abID label:(NSString *)abLabel total:(NSNumber *)abTotal statistics:(BSStatisticsModel *)abStats;

@end
