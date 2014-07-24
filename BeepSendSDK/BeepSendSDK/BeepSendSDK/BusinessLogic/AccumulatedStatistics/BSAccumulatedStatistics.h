//
//  BSAccumulatedStatisticsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSAccumulatedStatistics : BSGeneralModel

/** The connection label
 */
@property (nonatomic, strong, readonly) NSString *account;

/** Number of messages during the time interval.
 */
@property (nonatomic, strong, readonly) NSNumber *count;

/** Total cost for traffic between given interval in Euro (€).
 */
@property (nonatomic, strong, readonly) NSNumber *price;

/** Init Acumulated statistics with account, count, price
 
 @param account - Account
 @param count - Count
 @param price - Price
 
 @return Returns Acumulated statistics object
 */
- (BSAccumulatedStatistics *)initWithAccount:(NSString *)account count:(NSNumber *)count price:(NSNumber *)price;

@end
