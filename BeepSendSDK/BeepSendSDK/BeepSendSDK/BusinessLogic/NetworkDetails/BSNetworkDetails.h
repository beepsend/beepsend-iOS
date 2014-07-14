//
//  BSNetworkDetailsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSMCCMNC.h"
#import "BSStatistics.h"

@interface BSNetworkDetails : BSGeneralModel

@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;
@property (nonatomic, strong, readonly) BSStatistics *statistics;
@property (nonatomic, strong, readonly) NSNumber *total;

- (BSNetworkDetails *)initWithMCCMNC:(BSMCCMNC *)nMccmnc statistics:(BSStatistics *)nStatistics total:(NSNumber *)nTotal;

@end
