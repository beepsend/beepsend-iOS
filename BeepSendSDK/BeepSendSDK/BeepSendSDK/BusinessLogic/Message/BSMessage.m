//
//  BSMessage.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSMessage.h"

#import "BSGroup.h"

#import "BSSMSService.h"

@interface BSMessage ()

@property (nonatomic, strong, readwrite) NSString *usedEncoding;

//Message response parameters
@property (nonatomic, strong, readwrite) NSString *messageID;
@property (nonatomic, strong, readwrite) NSArray *errors;

@end

@implementation BSMessage

#pragma mark - Properties

- (NSString *)usedEncoding
{
	BOOL isUTF8;
	
#ifdef TARGET_IPHONE_SIMULATOR
	isUTF8 = YES;
#else
	isUTF8 = is_utf8([message.message cStringUsingEncoding:NSUTF16BigEndianStringEncoding]);
#endif
	
	return _usedEncoding ? _usedEncoding : isUTF8 ? @"UTF-8" : @"Unicode";
}

- (NSString *)messageID
{
	return [BSHelper isNilOrEmpty:_messageID] ? @"0" : [_messageID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_messageID stringValue] : _messageID;
}

- (NSArray *)errors
{
	return _errors ? _errors : @[];
}

#pragma mark - Initialization

- (BSMessage *)initMessageWithID:(NSString *)mshID andErrors:(NSArray *)errors forMessage:(BSMessage *)msg
{
	if (self = [super initWithID:mshID andTitle:@"Message"]) {
		_messageID = mshID;
		_errors = errors;
		
		_recipient = msg.recipient;
		_recipients = msg.recipients;
		_message = msg.message;
		_sender = msg.sender;
		
		_batch = msg.batch;
		
		_sendTime = msg.sendTime;
		_usedEncoding = msg.usedEncoding;
		_messageType = msg.messageType;
		_validTo = msg.validTo;
		_shouldReceiveDeliveryReport = msg.shouldReceiveDeliveryReport;
		_groups = msg.groups;
		
		_userDataHeader = msg.userDataHeader;
		_dataCodingSettings = msg.dataCodingSettings;
	}
	return self;
}

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

- (BSMessage *)initMessageOfType:(NSString *)messageType withBody:(NSString *)messageBody sender:(NSString *)sender recipient:(NSString *)recipient
{
	if (self = [super initWithID:@"0" andTitle:messageType]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_recipient = recipient;
		
		_shouldReceiveDeliveryReport = 1;
		
		_messageType = messageType;
	}
	return self;
}

- (BSMessage *)initMessageOfType:(NSString *)messageType withBody:(NSString *)messageBody sender:(NSString *)sender recipients:(NSArray *)recipients
{
	if (self = [super initWithID:@"0" andTitle:messageType]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_recipients = recipients;
		
		_shouldReceiveDeliveryReport = 1;
		
		_messageType = messageType;
	}
	return self;
}

- (BSMessage *)initMessageOfType:(NSString *)messageType withBody:(NSString *)messageBody sender:(NSString *)sender groups:(NSArray *)groups
{
	if (self = [super initWithID:@"0" andTitle:messageType]) {
		_messageID = @"0";
		
		_message = messageBody;
		_sender = sender;
		_groups = groups;
		
		_shouldReceiveDeliveryReport = 1;
		
		_messageType = messageType;
	}
	return self;
}

+ (BSMessage *)messageWithBody:(NSString *)body from:(NSString *)sender to:(NSString *)recipient
{
	return [[BSMessage alloc] initMessageOfType:nil withBody:body sender:sender recipient:recipient];
}

+ (BSMessage *)messageWithBody:(NSString *)body from:(NSString *)sender toMultiple:(NSArray *)recipients
{
	return [[BSMessage alloc] initMessageOfType:nil withBody:body sender:sender recipients:recipients];
}

+ (BSMessage *)messageWithBody:(NSString *)body from:(NSString *)sender toGroups:(NSArray *)groups
{
	return [[BSMessage alloc] initMessageOfType:nil withBody:body sender:sender groups:groups];
}

+ (BSMessage *)flashMessageWithBody:(NSString *)body from:(NSString *)sender to:(NSString *)recipient
{
	return [[BSMessage alloc] initMessageOfType:@"flash" withBody:body sender:sender recipient:recipient];
}

+ (BSMessage *)flashMessageWithBody:(NSString *)body from:(NSString *)sender toMultiple:(NSArray *)recipients
{
	return [[BSMessage alloc] initMessageOfType:@"flash" withBody:body sender:sender recipients:recipients];
}

+ (BSMessage *)flashMessageWithBody:(NSString *)body from:(NSString *)sender toGroups:(NSArray *)groups
{
	return [[BSMessage alloc] initMessageOfType:@"flash" withBody:body sender:sender groups:groups];
}

+ (BSMessage *)binaryMessageWithBody:(NSString *)body from:(NSString *)sender to:(NSString *)recipient
{
	return [[BSMessage alloc] initMessageOfType:@"binary" withBody:body sender:sender recipient:recipient];
}

+ (BSMessage *)binaryMessageWithBody:(NSString *)body from:(NSString *)sender toMultiple:(NSArray *)recipients
{
	return [[BSMessage alloc] initMessageOfType:@"binary" withBody:body sender:sender recipients:recipients];
}

+ (BSMessage *)binaryMessageWithBody:(NSString *)body from:(NSString *)sender toGroups:(NSArray *)groups
{
	return [[BSMessage alloc] initMessageOfType:@"binary" withBody:body sender:sender groups:groups];
}

#pragma mark - Public methods

- (void)receiveDeliveryReportWithOption:(NSInteger)receive
{
	_shouldReceiveDeliveryReport = receive < 0 ? 0 : receive > 2 ? 2 : receive;
}

- (void)setValidityPeriod:(NSDate *)validUntil
{
	if ((validUntil != nil) && [[validUntil earlierDate:[NSDate date]] isEqualToDate:validUntil]) {
		_validTo = nil;
	}
	else {
		_validTo = validUntil;
	}
}

- (void)scheduleSendingAtTime:(NSDate *)sendingTime
{
	if ((sendingTime != nil) && [[sendingTime earlierDate:[NSDate date]] isEqualToDate:sendingTime]) {
		_sendTime = nil;
	}
	else {
		_sendTime = sendingTime;
	}
}

- (void)setEncoding:(NSString *)encoding
{
	if ([encoding isEqualToString:@"UTF-8"] ||
		[encoding isEqualToString:@"ISO-8859-15"] ||
		[encoding isEqualToString:@"Unicode"]) {
		
		_usedEncoding = encoding;
	}
}

- (void)addGroupsRecipients:(NSArray *)groups
{
	BOOL nonGroupObject = NO;
	for (id object in groups) {
		if (!([object isKindOfClass:[BSGroup class]] || [object isKindOfClass:[NSString class]])) {
			nonGroupObject = YES;
		}
	}
	if (nonGroupObject) {
		_groups = nil;
	}
	else {
		_groups = groups;
	}
}

//Validate SMS
- (void)validateMessageOnCompletion:(void(^)(BSMessage *message, NSArray *errors))block
{
	if ([BSHelper isNilOrEmpty:_message]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message body can't be empty!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	if ([BSHelper isNilOrEmpty:_recipient] && _recipients.count==0 && _groups.count==0) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message recipient must be specified!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	if ([BSHelper isNilOrEmpty:_sender]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message sender must be specified!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSSMSService sharedService] validateSMSForMessage:self withCompletionBlock:^(BSMessage *message, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(message, nil);
		}
	}];
}

@end
