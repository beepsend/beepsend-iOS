//
//  BSSMSService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSBatchModel.h"
#import "BSMessageModel.h"
#import "BSLookupModel.h"
#import "BSMessageRequestModel.h"

@interface BSSMSService : BSBaseService

/*
	Sends SMS
 */
- (void)sendMessage:(NSString *)message
			   from:(NSString *)sender
				 to:(id)receiver
			 groups:(NSArray *)groups
		 withBachID:(NSString *)batchID
	  andBatchLabel:(NSString *)batchLabel
	atScheduledTime:(NSString *)scheduleTime
	   usedEncoding:(NSString *)encoding
		messageType:(NSString *)type
		   validFor:(NSString *)validTime //ValidTime = TimestampFrom1970 + HowLongMessageIsValid
recieveDeliveryReport:(NSNumber *)receiveDlrOption //0: Disable, 1: Always, 2: Only on failure. Default is 1.
withCompletionBlock:(void(^)(NSArray *response, id error))block;

/*
	Parameter is array of message request models
 */
- (void)sendMessages:(NSArray *)messages withCompletionBlock:(void(^)(NSArray *array, id error))block;

/*
	Get details regarding one message.
 */
- (void)lookupSMS:(BSMessageModel *)sms withCompletionBlock:(void(^)(BSLookupModel *lookupResponse, id error))block;

/*
	Performs dry run of SMS sending
 */
- (void)validateSMSForMessage:(NSString *)message
						 from:(NSString *)sender
						   to:(NSString *)receiver
					   groups:(NSArray *)groups
				   withBachID:(NSString *)batchID
				andBatchLabel:(NSString *)batchLabel
			  atScheduledTime:(NSString *)scheduleTime
				 usedEncoding:(NSString *)encoding
				  messageType:(NSString *)type
					 validFor:(NSString *)validTime
		recieveDeliveryReport:(NSNumber *)receiveDlrOption //0: Disable, 1: Always, 2: Only on failure. Default is 1.
		  withCompletionBlock:(void(^)(BSMessageModel *message, id error))block;

/*
	Get your previous batches with messages.
 */
- (void)getPreviousBatchesWithCompletionBlock:(void(^)(NSArray *bathces, id error))block;

/*
	Get details for a specific batch.
 */
- (void)getDetailsForBatch:(NSString *)batchID withCompletionBlock:(void(^)(BSBatchModel *batch, id error))block;

@end
