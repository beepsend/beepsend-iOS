//
//  BSSMSService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSLookup.h"
#import "BSEstimateCost.h"

#import "BSMessage.h"
#import "BSBatch.h"
#import "BSError.h"

@interface BSSMSService : NSObject

/*
	Sends SMS
 */
// validTime //ValidTime = TimestampFrom1970 + HowLongMessageIsValid
// receiveDlrOption //0: Disable, 1: Always, 2: Only on failure. Default is 1.

/*
	Sends SMS.
 */
- (void)sendMessage:(BSMessage *)messageRequest usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSMessage *message, NSArray *errors))block;

/*
	Parameter is array of message request models.
 */
- (void)sendMessages:(NSArray *)messages usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *array, NSArray *errors))block;

/*
	Get details regarding one message.
 */
- (void)lookupSMS:(BSMessage *)sms withCompletionBlock:(void(^)(BSLookup *lookupResponse, NSArray *errors))block;

/*
 Get details regarding multiple messages.
 */
- (void)lookupMultipleSMSSentTo:(NSString *)recipient setnFrom:(NSString *)sender usingConnection:(BSConnection *)connection batch:(BSBatch *)batch sinceID:(NSString *)sinceID maxID:(NSString *)maxID afterDate:(NSDate *)afterDate beforeDate:(NSDate *)beforeDate count:(NSNumber *)count withCompletionBlock:(void(^)(NSArray *lookupResponse, NSArray *errors))block;

/*
	Performs dry run of SMS sending.
 */
- (void)validateSMSForMessage:(BSMessage *)message withCompletionBlock:(void(^)(BSMessage *message, NSArray *errors))block;

/*
	Get your previous batches with messages.
 */
- (void)getPreviousBatchesWithCompletionBlock:(void(^)(NSArray *bathces, NSArray *errors))block;

/*
	Get details for a specific batch.
 */
- (void)getDetailsForBatch:(NSString *)batchID withCompletionBlock:(void(^)(BSBatch *batch, NSArray *errors))block;

/*
	Estimate message/s price.
 */
- (void)estimateCostForMessages:(NSArray *)messageRequest usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *response, NSArray *errors))block;

@end
