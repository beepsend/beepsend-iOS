//
//  BSNetworkDetailsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSMCCMNC;
@class BSStatistics;

@interface BSNetworkDetails : BSGeneralModel

/** MCC MNC for network
 */
@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;

/** Statistic
 */
@property (nonatomic, strong, readonly) BSStatistics *statistics;

/** Total amount of messages for the MCC MNC
 */
@property (nonatomic, strong, readonly) NSNumber *total;

- (BSNetworkDetails *)initWithMCCMNC:(BSMCCMNC *)nMccmnc statistics:(BSStatistics *)nStatistics total:(NSNumber *)nTotal;

@end
