//
//  BSNetworkDetailsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSMCCMNC.h"
#import "BSStatisticsModel.h"

@interface BSNetworkDetailsModel : BSGeneralModel

@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;
@property (nonatomic, strong, readonly) BSStatisticsModel *statistics;
@property (nonatomic, strong, readonly) NSNumber *total;

- (BSNetworkDetailsModel *)initWithMCCMNC:(BSMCCMNC *)nMccmnc statistics:(BSStatisticsModel *)nStatistics total:(NSNumber *)nTotal;

@end
