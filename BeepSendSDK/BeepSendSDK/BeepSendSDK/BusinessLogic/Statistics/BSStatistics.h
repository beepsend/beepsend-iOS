//
//  BSStatisticsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSStatistics : BSGeneralModel

/** Amount of messages with status delivered to handset
 */
@property (nonatomic, strong, readonly) NSNumber *deliveredMessages;

/** Incoming messages from Operator
 */
@property (nonatomic, strong, readonly) NSNumber *incomingMessagesFromOperator;

/** Amount of messages that suffered time out
 */
@property (nonatomic, strong, readonly) NSNumber *expiredMessages;

/** Failed messages without a clear error
 */
@property (nonatomic, strong, readonly) NSNumber *failedMessagesWithoutError;

/** Messages not accepted by Operator
 */
@property (nonatomic, strong, readonly) NSNumber *rejectedMessagesByOperator;

/** Failed messages. Unlike unknown, an error code was returned
 */
@property (nonatomic, strong, readonly) NSNumber *failedMessagesWithError;

/** Messages still in the process of sending
 */
@property (nonatomic, strong, readonly) NSNumber *messagesInProcessOfSending;

/** Init Statistic with delivered, mo, expired, unknown, rejected, undelivered, nodlr
 
 @param sDelivered - Delivered
 @param sMo - MO
 @param sExpired - Expired
 @param sUnknown - Unknown
 @param sRejected - Rejected
 @param sUndelivered - Undelivered
 @param sNoDlr - NO DLR
 
 @return Returns Statistic object
 */
- (BSStatistics *)initWithDelivered:(NSNumber *)sDelivered
								 mo:(NSNumber *)sMo
							expired:(NSNumber *)sExpired
							unknown:(NSNumber *)sUnknown
						   rejected:(NSNumber *)sRejected
						undelivered:(NSNumber *)sUndelivered
							  noDlr:(NSNumber *)sNoDlr;

@end
