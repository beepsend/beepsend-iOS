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

/*!
 @class BSNetworkDetails
 @discussion Network details will give you granular delivery statistics 
 for all messages sorted by each recipient network between two specified dates. 
 */
@interface BSNetworkDetails : BSGeneralModel

/*! Mobile Country Code and Mobile Network Code
 */
@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;

/*! Statistic
 */
@property (nonatomic, strong, readonly) BSStatistics *statistics;

/*! Total amount of messages for the MCC MNC
 */
@property (nonatomic, strong, readonly) NSNumber *total;

/*! Create Network details object
 
 @param nMccmnc - Mobile Country Code and Mobile Network Code
 @param nStatistics - Statistic
 @param nTotal - Total amount of messages for the MCC MNC
 
 @return Returns Network details object
 */
- (BSNetworkDetails *)initWithMCCMNC:(BSMCCMNC *)nMccmnc
						  statistics:(BSStatistics *)nStatistics
							   total:(NSNumber *)nTotal;

@end
