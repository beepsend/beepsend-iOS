//
//  BSStatisticsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSStatisticsModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSNumber *deliveredMessages;
@property (nonatomic, strong, readonly) NSNumber *incomingMessagesFromOperator;
@property (nonatomic, strong, readonly) NSNumber *expiredMessages;
@property (nonatomic, strong, readonly) NSNumber *failedMessagesWithoutError;
@property (nonatomic, strong, readonly) NSNumber *rejectedMessagesByOperator;
@property (nonatomic, strong, readonly) NSNumber *failedMessagesWithError;
@property (nonatomic, strong, readonly) NSNumber *messagesInProcessOfSending;

- (BSStatisticsModel *)initWithDelivered:(NSNumber *)sDelivered
									  mo:(NSNumber *)sMo
								 expired:(NSNumber *)sExpired
								 unknown:(NSNumber *)sUnknown
								rejected:(NSNumber *)sRejected
							 undelivered:(NSNumber *)sUndelivered
								   noDlr:(NSNumber *)sNoDlr;

@end
