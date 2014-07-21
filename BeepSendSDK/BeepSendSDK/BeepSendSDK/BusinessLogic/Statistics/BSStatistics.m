//
//  BSStatisticsModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSStatistics.h"

@interface BSStatistics ()

@property (nonatomic, strong, readwrite) NSNumber *deliveredMessages;
@property (nonatomic, strong, readwrite) NSNumber *incomingMessagesFromOperator;
@property (nonatomic, strong, readwrite) NSNumber *expiredMessages;
@property (nonatomic, strong, readwrite) NSNumber *failedMessagesWithoutError;
@property (nonatomic, strong, readwrite) NSNumber *rejectedMessagesByOperator;
@property (nonatomic, strong, readwrite) NSNumber *failedMessagesWithError;
@property (nonatomic, strong, readwrite) NSNumber *messagesInProcessOfSending;

@end

@implementation BSStatistics

#pragma mark - Properties

- (NSNumber *)deliveredMessages
{
	return _deliveredMessages ? _deliveredMessages : @0;
}

- (NSNumber *)incomingMessagesFromOperator
{
	return _incomingMessagesFromOperator ? _incomingMessagesFromOperator : @0;
}

- (NSNumber *)expiredMessages
{
	return _expiredMessages ? _expiredMessages : @0;
}

- (NSNumber *)failedMessagesWithoutError
{
	return _failedMessagesWithoutError ? _failedMessagesWithoutError : @0;
}

- (NSNumber *)rejectedMessagesByOperator
{
	return _rejectedMessagesByOperator ? _rejectedMessagesByOperator : @0;
}

- (NSNumber *)failedMessagesWithError
{
	return _failedMessagesWithError ? _failedMessagesWithError : @0;
}

- (NSNumber *)messagesInProcessOfSending
{
	return _messagesInProcessOfSending ? _messagesInProcessOfSending : @0;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular statistics"]) {
		
	}
	return self;
}

- (BSStatistics *)initWithDelivered:(NSNumber *)sDelivered
									  mo:(NSNumber *)sMo
								 expired:(NSNumber *)sExpired
								 unknown:(NSNumber *)sUnknown
								rejected:(NSNumber *)sRejected
							 undelivered:(NSNumber *)sUndelivered
								   noDlr:(NSNumber *)sNoDlr
{
	if (self = [super initWithID:@"0" andTitle:@"Statistics"]) {
		_deliveredMessages = sDelivered;
		_incomingMessagesFromOperator = sMo;
		_expiredMessages = sExpired;
		_failedMessagesWithoutError = sUnknown;
		_rejectedMessagesByOperator = sRejected;
		_failedMessagesWithError = sUndelivered;
		_messagesInProcessOfSending = sNoDlr;
	}
	return self;
}

@end
