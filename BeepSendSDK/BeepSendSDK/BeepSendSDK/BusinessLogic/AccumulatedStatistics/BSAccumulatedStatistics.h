//
//  BSAccumulatedStatisticsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSAccumulatedStatistics
 @discussion Accumulated statistics will give you accumulated statistics for 
 all messages sent between two specified dates and the accumulated cost 
 for these in Euro (€). 
 */
@interface BSAccumulatedStatistics : BSGeneralModel

/*! The connection label
 */
@property (nonatomic, strong, readonly) NSString *account;

/*! Number of messages during the time interval.
 */
@property (nonatomic, strong, readonly) NSNumber *count;

/*! Total cost for traffic between given interval in Euro (€).
 */
@property (nonatomic, strong, readonly) NSNumber *price;

/*! Create Acumulated statistics object
 
 @param account - The connection label
 @param count - Number of messages during the time interval.
 @param price - Total cost for traffic between given interval in Euro (€).
 
 @return Returns Acumulated statistics object
 */
- (BSAccumulatedStatistics *)initWithAccount:(NSString *)account
									   count:(NSNumber *)count
									   price:(NSNumber *)price;

@end
