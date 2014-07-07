//
//  BSNetworkDetailsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSMCCMNCModel.h"
#import "BSStatisticsModel.h"

@interface BSNetworkDetailsModel : BSGeneralModel

@property (nonatomic, strong, readonly) BSMCCMNCModel *mccmnc;
@property (nonatomic, strong, readonly) BSStatisticsModel *statistics;
@property (nonatomic, strong, readonly) NSNumber *total;

- (BSNetworkDetailsModel *)initWithMCCMNC:(BSMCCMNCModel *)nMccmnc statistics:(BSStatisticsModel *)nStatistics total:(NSNumber *)nTotal;

@end
