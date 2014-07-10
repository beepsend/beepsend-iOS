//
//  BSMessage.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSMessage.h"

#import "BSBatch.h"

@interface BSMessage ()

//Required
//@property (nonatomic, strong, readwrite) NSString *sender;
//@property (nonatomic, strong, readwrite) NSString *message;
//@property (nonatomic, strong, readwrite) NSString *recipient;
//
//// Optional
//@property (nonatomic, strong, readwrite) NSArray *groups;
//@property (nonatomic, strong, readwrite) NSArray *recipients;
//
////Additional options
////@property (nonatomic, strong) BSBatch *batch;
//
//@property (nonatomic, strong, readwrite) NSDate *validTo;
//@property (nonatomic, strong, readwrite) NSDate *sendTime;
//
//@property (nonatomic, strong, readwrite) NSString *messageType;
//
//@property (nonatomic, strong, readwrite) NSString *usedEncoding;
//
//@property (nonatomic, assign, readwrite) BOOL shouldReceiveDeliveryReport;
//
////Available options for binary message
//@property (nonatomic, strong, readwrite) NSString *userDataHeader;
//@property (nonatomic, strong, readwrite) NSString *dataCodingSettings;
//
////Message response parameters
//@property (nonatomic, strong, readwrite) NSString *messageID;
//@property (nonatomic, strong, readwrite) NSArray *errors;

@end

@implementation BSMessage

#pragma mark - Initialization

- (BSMessage *)initWithMessage:(NSString *)rMessage
					  receiver:(id)rReceiver
						sender:(NSString *)rSender
					   batchID:(NSString *)rBatchID
					batchLabel:(NSString *)rBatchLabel
					  sendTime:(NSDate *)rSendTime
				  usedEncoding:(NSString *)rEncoding
				   messageType:(NSString *)rType
					   validTo:(NSDate *)rValidTo
					recieveDLR:(NSNumber *)rReceiveDLR
					 forGroups:(NSArray *)rGroups
				userDataHeader:(NSString *)rUDH
			dataCodingSettings:(NSString *)rDCS
{
	if (self = [super initWithID:@"0" andTitle:@"Message"]) {
		_messageID = @"0";
		
		_recipient = [rReceiver isKindOfClass:[NSString class]] ? rReceiver : nil;
		_recipients = [rReceiver isKindOfClass:[NSArray class]] ? rReceiver : nil;
		_message = rMessage;
		_sender = rSender;
		
		BSBatch *batch = [[BSBatch alloc] initWithID:rBatchID andLabel:rBatchLabel];
		_batch = batch;
		
		_sendTime = rSendTime;
		_usedEncoding = rEncoding;
		_messageType = rType;
		_validTo = rValidTo;
		_shouldReceiveDeliveryReport = [rReceiveDLR boolValue];
		_groups = rGroups;
		
		_userDataHeader = rUDH;
		_dataCodingSettings = rDCS;
	}
	return self;
}

- (BSMessage *)initMessageWithID:(NSString *)mID
						   batch:(BSBatch *)mBatch
					  recipients:(id)mRecipients
						  sender:(NSString *)mSender
						  errors:(NSArray *)mErrors
				 recipientGroups:(NSArray *)mGroups
{
	if (self = [super initWithID:mID andTitle:@"Message"]) {
		_messageID = mID;
		_batch = mBatch;
		_sender = mSender;
		_errors = mErrors;
		_groups = mGroups;
		_recipient = [mRecipients isKindOfClass:[NSString class]] ? mRecipients : nil;
		_recipients = [mRecipients isKindOfClass:[NSArray class]] ? mRecipients : nil;
	}
	return self;

}

- (BSMessage *)initMessageWithBody:(NSString *)messageBody from:(NSString *)sender to:(NSString *)recipient
{
	if (self = [super initWithID:@"0" andTitle:@"Normal message"]) {
		_messageID = @"0";
		_message = messageBody;
		_sender = sender;
		_recipient = recipient;
		
		_shouldReceiveDeliveryReport = 1;
	}
	return self;
}

- (BSMessage *)initMessageWithBody:(NSString *)messageBody from:(NSString *)sender toMultiple:(NSArray *)recipients
{
	if (self = [super initWithID:@"0" andTitle:@"Normal message"]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_recipients = recipients;
		
		_shouldReceiveDeliveryReport = 1;
	}
	return self;
}

- (BSMessage *)initMessageWithBody:(NSString *)messageBody from:(NSString *)sender toGroups:(NSArray *)groups
{
	if (self = [super initWithID:@"0" andTitle:@"Normal message"]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_groups = groups;
		
		_shouldReceiveDeliveryReport = 1;
	}
	return self;
}

- (BSMessage *)initFlashMessageWithBody:(NSString *)messageBody from:(NSString *)sender to:(NSString *)recipient
{
	if (self = [super initWithID:@"0" andTitle:@"Flash message"]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_recipient = recipient;
		
		_shouldReceiveDeliveryReport = 1;
		_messageType = @"flash";
	}
	return self;
}

- (BSMessage *)initFlashMessageWithBody:(NSString *)messageBody from:(NSString *)sender toMultiple:(NSArray *)recipients
{
	if (self = [super initWithID:@"0" andTitle:@"Flash message"]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_recipients = recipients;
		
		_shouldReceiveDeliveryReport = 1;
		_messageType = @"flash";
	}
	return self;
}

- (BSMessage *)initFlashMessageWithBody:(NSString *)messageBody from:(NSString *)sender toGroups:(NSArray *)groups
{
	if (self = [super initWithID:@"0" andTitle:@"Flash message"]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_groups = groups;
		
		_shouldReceiveDeliveryReport = 1;
		_messageType = @"flash";
	}
	return self;
}

- (BSMessage *)initBinaryMessageWithBody:(NSString *)messageBody from:(NSString *)sender to:(NSString *)recipient
{
	if (self = [super initWithID:@"0" andTitle:@"Binary message"]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_recipient = recipient;
		
		_shouldReceiveDeliveryReport = 1;
		_messageType = @"binary";
	}
	return self;
}

- (BSMessage *)initBinaryMessageWithBody:(NSString *)messageBody from:(NSString *)sender toMultiple:(NSArray *)recipients
{
	if (self = [super initWithID:@"0" andTitle:@"Binary message"]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_recipients = recipients;
		
		_shouldReceiveDeliveryReport = 1;
		_messageType = @"binary";
	}
	return self;
}

- (BSMessage *)initBinaryMessageWithBody:(NSString *)messageBody from:(NSString *)sender toGroups:(NSArray *)groups
{
	if (self = [super initWithID:@"0" andTitle:@"Binary message"]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_groups = groups;
		
		_shouldReceiveDeliveryReport = 1;
		_messageType = @"binary";
	}
	return self;
}

+ (BSMessage *)messageWithBody:(NSString *)body from:(NSString *)sender to:(NSString *)recipient
{
	return [[BSMessage alloc] initMessageWithBody:body from:sender to:recipient];
}

+ (BSMessage *)messageWithBody:(NSString *)body from:(NSString *)sender toMultiple:(NSArray *)recipients
{
	return [[BSMessage alloc] initMessageWithBody:body from:sender toMultiple:recipients];
}

+ (BSMessage *)messageWithBody:(NSString *)body from:(NSString *)sender toGroups:(NSArray *)groups
{
	return [[BSMessage alloc] initMessageWithBody:body from:sender toGroups:groups];
}

+ (BSMessage *)flashMessageWithBody:(NSString *)body from:(NSString *)sender to:(NSString *)recipient
{
	return [[BSMessage alloc] initFlashMessageWithBody:body from:sender to:recipient];
}

+ (BSMessage *)flashMessageWithBody:(NSString *)body from:(NSString *)sender toMultiple:(NSArray *)recipients
{
	return [[BSMessage alloc] initFlashMessageWithBody:body from:sender toMultiple:recipients];
}

+ (BSMessage *)flashMessageWithBody:(NSString *)body from:(NSString *)sender toGroups:(NSArray *)groups
{
	return [[BSMessage alloc] initFlashMessageWithBody:body from:sender toGroups:groups];
}

+ (BSMessage *)binaryMessageWithBody:(NSString *)body from:(NSString *)sender to:(NSString *)recipient
{
	return [[BSMessage alloc] initBinaryMessageWithBody:body from:sender to:recipient];
}

+ (BSMessage *)binaryMessageWithBody:(NSString *)body from:(NSString *)sender toMultiple:(NSArray *)recipients
{
	return [[BSMessage alloc] initBinaryMessageWithBody:body from:sender toMultiple:recipients];
}

+ (BSMessage *)binaryMessageWithBody:(NSString *)body from:(NSString *)sender toGroups:(NSArray *)groups
{
	return [[BSMessage alloc] initBinaryMessageWithBody:body from:sender toGroups:groups];
}

#pragma mark - Public methods

- (void)receiveDeliveryReportWithOption:(NSInteger)receive
{
	if (receive < 0 || receive > 2) {
		return;
	}
	
	_shouldReceiveDeliveryReport = receive;
}

- (void)setValidityPeriod:(NSDate *)validUntil
{
	_validTo = validUntil;
}

- (void)scheduleSendingAtTime:(NSDate *)sendingTime
{
	_sendTime = sendingTime;
}

- (void)setEncoding:(NSString *)encoding
{
	_usedEncoding = encoding;
}

@end
