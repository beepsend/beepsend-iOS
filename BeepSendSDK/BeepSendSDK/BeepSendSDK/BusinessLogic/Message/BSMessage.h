//
//  BSMessage.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSBatch;

@interface BSMessage : BSGeneralModel

//Required
@property (nonatomic, strong, readonly) NSString *sender;
@property (nonatomic, strong, readonly) NSString *message;
@property (nonatomic, strong, readonly) NSString *recipient;

// Optional
@property (nonatomic, strong, readonly) NSArray *groups;
@property (nonatomic, strong, readonly) NSArray *recipients;

//Additional options
@property (nonatomic, strong) BSBatch *batch;

@property (nonatomic, strong, readonly) NSDate *validTo;
@property (nonatomic, strong, readonly) NSDate *sendTime;

@property (nonatomic, strong, readonly) NSString *messageType;

@property (nonatomic, strong, readonly) NSString *usedEncoding;

@property (nonatomic, assign, readonly) NSInteger shouldReceiveDeliveryReport;

//Available options for binary message
@property (nonatomic, strong, readonly) NSString *userDataHeader;
@property (nonatomic, strong, readonly) NSString *dataCodingSettings;

//Message response parameters
@property (nonatomic, strong, readonly) NSString *messageID;
@property (nonatomic, strong, readonly) NSArray *errors;

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
			dataCodingSettings:(NSString *)rDCS;

- (BSMessage *)initMessageWithID:(NSString *)mID
						   batch:(BSBatch *)mBatch
					  recipients:(id)mRecipients
						  sender:(NSString *)mSender
						  errors:(NSArray *)mErrors
				 recipientGroups:(NSArray *)mGroups;

- (BSMessage *)initMessageWithBody:(NSString *)messageBody from:(NSString *)sender to:(NSString *)recipient;
- (BSMessage *)initMessageWithBody:(NSString *)messageBody from:(NSString *)sender toMultiple:(NSArray *)recipients;
- (BSMessage *)initMessageWithBody:(NSString *)messageBody from:(NSString *)sender toGroups:(NSArray *)groups;

- (BSMessage *)initFlashMessageWithBody:(NSString *)messageBody from:(NSString *)sender to:(NSString *)recipient;
- (BSMessage *)initFlashMessageWithBody:(NSString *)messageBody from:(NSString *)sender toMultiple:(NSArray *)recipients;
- (BSMessage *)initFlashMessageWithBody:(NSString *)messageBody from:(NSString *)sender toGroups:(NSArray *)groups;

- (BSMessage *)initBinaryMessageWithBody:(NSString *)messageBody from:(NSString *)sender to:(NSString *)recipient;
- (BSMessage *)initBinaryMessageWithBody:(NSString *)messageBody from:(NSString *)sender toMultiple:(NSArray *)recipients;
- (BSMessage *)initBinaryMessageWithBody:(NSString *)messageBody from:(NSString *)sender toGroups:(NSArray *)groups;

+ (BSMessage *)messageWithBody:(NSString *)body from:(NSString *)sender to:(NSString *)recipient;
+ (BSMessage *)messageWithBody:(NSString *)body from:(NSString *)sender toMultiple:(NSArray *)recipients;
+ (BSMessage *)messageWithBody:(NSString *)body from:(NSString *)sender toGroups:(NSArray *)groups;

+ (BSMessage *)flashMessageWithBody:(NSString *)body from:(NSString *)sender to:(NSString *)recipient;
+ (BSMessage *)flashMessageWithBody:(NSString *)body from:(NSString *)sender toMultiple:(NSArray *)recipients;
+ (BSMessage *)flashMessageWithBody:(NSString *)body from:(NSString *)sender toGroups:(NSArray *)groups;

+ (BSMessage *)binaryMessageWithBody:(NSString *)body from:(NSString *)sender to:(NSString *)recipient;
+ (BSMessage *)binaryMessageWithBody:(NSString *)body from:(NSString *)sender toMultiple:(NSArray *)recipients;
+ (BSMessage *)binaryMessageWithBody:(NSString *)body from:(NSString *)sender toGroups:(NSArray *)groups;

- (void)receiveDeliveryReportWithOption:(NSInteger)receive;//0: Disable, 1: Always, 2: Only on failure. Default is 1.
- (void)setValidityPeriod:(NSDate *)validUntil;
- (void)scheduleSendingAtTime:(NSDate *)sendingTime;

//Explicitly set encoding
- (void)setEncoding:(NSString *)encoding;

@end
