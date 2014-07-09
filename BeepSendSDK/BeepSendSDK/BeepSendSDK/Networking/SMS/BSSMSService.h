//
//  BSSMSService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSLookupModel.h"
#import "BSEstimateCostModel.h"

#import "BSMessage.h"
#import "BSBatch.h"

@interface BSSMSService : BSBaseService

/*
	Sends SMS
 */
// validTime //ValidTime = TimestampFrom1970 + HowLongMessageIsValid
// receiveDlrOption //0: Disable, 1: Always, 2: Only on failure. Default is 1.

/*
	Sends SMS.
 */
- (void)sendMessage:(BSMessage *)messageRequest usingConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *response, id error))block;

/*
	Parameter is array of message request models.
 */
- (void)sendMessages:(NSArray *)messages usingConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *array, id error))block;

/*
	Get details regarding one message.
 */
- (void)lookupSMS:(BSMessage *)sms withCompletionBlock:(void(^)(BSLookupModel *lookupResponse, id error))block;

/*
	Performs dry run of SMS sending.
 */
- (void)validateSMSForMessage:(BSMessage *)message withCompletionBlock:(void(^)(BSMessage *message, id error))block;

/*
	Get your previous batches with messages.
 */
- (void)getPreviousBatchesWithCompletionBlock:(void(^)(NSArray *bathces, id error))block;

/*
	Get details for a specific batch.
 */
- (void)getDetailsForBatch:(NSString *)batchID withCompletionBlock:(void(^)(BSBatch *batch, id error))block;

/*
	Estimate message/s price.
 */
- (void)estimateCostForMessages:(NSArray *)messageRequest usingConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *response, id error))block;

@end
