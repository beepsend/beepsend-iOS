//
//  BSSMSService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSMSService.h"

#import "BSAPIConfiguration.h"

#import "BSAPMessageRequest.h"
#import "BSAPMessage.h"
#import "BSAPBatch.h"
#import "BSAPSMSLookup.h"
#import "BSAPEstimatedCost.h"
#import "BSConnection.h"
#import "BSAPConversation.h"
#import "BSAPTwoWayBatch.h"

#import "BSGroup.h"

@implementation BSSMSService

#pragma mark - Initialization

+ (instancetype)sharedService
{
	static id singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[[self class] alloc] init];
	});
	return singleton;
}

#pragma mark - Public methods

- (void)sendMessage:(BSMessage *)messageRequest usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSMessage *message, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPMessage *msg in [BSAPMessage arrayOfObjectsFromArrayOfDictionaries:@[
  @{@"id":@"07595980013893439611559146736007518",
	@"batch":@{
			@"id":@3,
			@"label":@"My custom name for my batch"
			},
	@"to":messageRequest.recipient,
	@"from":messageRequest.sender,
	@"errors":[NSNull null]}]]) {
		[mArr addObject:[msg convertToModel]];
	}
	block(mArr[0], nil);
}

- (void)sendMessages:(NSArray *)messages usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *array, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPMessage *msg in [BSAPMessage arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@"07595980013893439611559146736007518",@"batch":@{@"id":@3,@"label":@"My custom name for my batch"},@"to":@"222222",@"from":@"sender",@"errors":[NSNull null]},@{@"id":@"07595980013893439611559146736007518",@"batch":@{@"id":@3,@"label":@"My custom name for my batch"},@"to":@"222222",@"from":@"Sender",@"errors":[NSNull null]}]]) {
		BSMessage *message = [msg convertToModel];
		[mArr addObject:message];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)lookupSMS:(BSMessage *)sms withCompletionBlock:(void(^)(BSLookup *lookupResponse, NSArray *errors))block
{
	BSLookup *smslookup = [[BSAPSMSLookup classFromDict:@{@"id":@"12345",@"batch":@{@"id":@52,@"label":@"Super batch!"},@"body":@"Hello World!",@"connection":@{@"id":@7,@"label":@"superman-connection"},@"to":@{@"address":@"46406007500",@"ton":@1,@"npi":@1},@"from":@{@"address":@"Beepsend",@"ton":@1,@"npi":@1},@"validity_period":@"131102072704000",@"data_coding":@3,@"timestamps":@{@"sms":@{@"in":@1383225355,@"delivered":@1383225359},@"dlr_out":@1383225359},@"dlr":@{@"status":@"DELIVRD",@"error":@0},@"price":@0.068,@"mccmnc":@{@"mcc":@"240",@"mnc":@"01"}}] convertToModel];
	block(smslookup, nil);
}

- (void)lookupMultipleSMSSentTo:(NSString *)recipient setnFrom:(NSString *)sender usingConnection:(BSConnection *)connection batch:(BSBatch *)batch sinceID:(NSString *)sinceID maxID:(NSString *)maxID afterDate:(NSDate *)afterDate beforeDate:(NSDate *)beforeDate count:(NSNumber *)count withCompletionBlock:(void(^)(NSArray *lookupResponse, NSArray *error))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPSMSLookup *msg in [BSAPSMSLookup arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@"12345",@"batch":@{@"id":@52,@"label":@"Super batch!"},@"body":@"Hello World!",@"connection":@{@"id":@7,@"label":@"superman-connection"},@"to":@{@"address":@"46406007500",@"ton":@1,@"npi":@1},@"from":@{@"address":@"Beepsend",@"ton":@1,@"npi":@1},@"validity_period":@"131102072704000",@"data_coding":@3,@"timestamps":@{@"sms":@{@"in":@1383225355,@"delivered":@1383225359},@"dlr_out":@1383225359},@"dlr":@{@"status":@"DELIVRD",@"error":@0},@"price":@0.068,@"mccmnc":@{@"mcc":@"240",@"mnc":@"01"}},@{@"id":@"12346",@"batch":@{@"id":@52,@"label":@"Super batch!"},@"body":@"Hello World!",@"connection":@{@"id":@7,@"label":@"superman-connection"},@"to":@{@"address":@"46406007500",@"ton":@1,@"npi":@1},@"from":@{@"address":@"Beepsend",@"ton":@1,@"npi":@1},@"validity_period":@"131102072704000",@"data_coding":@3,@"timestamps":@{@"sms":@{@"in":@1383225355,@"delivered":@1383225359},@"dlr_out":@1383225359},@"dlr":@{@"status":@"DELIVRD",@"error":@0},@"price":@0.068,@"mccmnc":@{@"mcc":@"240",@"mnc":@"01"}}]]) {
		[mArr addObject:[msg convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)validateSMSForMessage:(BSMessage *)message withCompletionBlock:(void(^)(BSMessage *message, NSArray *errors))block
{
	BSMessage *msg = [[BSAPMessage classFromDict:@{@"id":[NSNull null],@"batch_label":@"My custom name for my batch",@"to":message.recipient,@"from":message.sender,@"errors":[NSNull null]}] convertToModel];
	block(msg, nil);
}

- (void)getPreviousBatchesWithCompletionBlock:(void(^)(NSArray *bathces, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPBatch *batch in [BSAPBatch arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@4,@"label":@"batch testing",@"date_created":@1387457467,@"last_used":@1387457467},@{@"id":@5,@"label":@"batch testing2",@"date_created":@1387457467,@"last_used":@1387457467},@{@"id":@6,@"label":@"batch testing3",@"date_created":@1387457467,@"last_used":@1387457467}]]) {
		[mArr addObject:[batch convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getDetailsForBatch:(NSString *)batchID withCompletionBlock:(void(^)(BSBatch *batch, NSArray *errors))block
{
	block([[BSAPBatch classFromDict:@{@"id":@4,@"label":@"batch testing",@"date_created":@1387457467,@"last_used":@1387457467}] convertToModel], nil);
}

- (void)estimateCostForMessages:(NSArray *)messageRequest usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *response, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPEstimatedCost *msg in [BSAPEstimatedCost arrayOfObjectsFromArrayOfDictionaries:@[@{@"total_cost":@0.0032,@"to":@{@"46736007518":@0.0032}},@{@"total_cost":@358.57,@"groups":@{@"11":@13.45,@"34":@345.12}}]]) {
		[mArr addObject:[msg convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getTwoWayBatchForBatchID:(NSString *)batchID onCompletion:(void(^)(NSArray *batches, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPTwoWayBatch *twb in [BSAPTwoWayBatch arrayOfObjectsFromArrayOfDictionaries:@[@{@"mt_sms_id":@"889000680270500421",@"mt_body":@"What is your name?",@"mo_sms_id":@"889000680270500422",@"mo_body":@"Sir Lancelot",@"dlr_stat":@"DELIVRD"},@{@"mt_sms_id":@"889000680141388005",@"mt_body":@"What is your quest?",@"mo_sms_id":@"889000680141388006",@"mo_body":@"To seek the holy grail",@"dlr_stat":@"DELIVRD"},@{@"mt_sms_id":@"889000680141388005",@"mt_body":@"What is your favorite color?",@"mo_sms_id":@"889000680141388006",@"mo_body":@"BLUE!",@"dlr_stat":@"DELIVRD"}]]) {
		[mArr addObject:[twb convertToModel]];
	}

	block([NSArray arrayWithArray:mArr], nil);

}

- (void)getConversationsOnCompletion:(void(^)(NSArray *conversations, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPConversation *conv in [BSAPConversation arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@"46736007500-46736000005",@"to":@"46736007500",@"from":@{@"number":@"46736000005",@"contact":@{@"id":@10,@"firstname":@"Foo",@"lastname":@"Bar"}},@"body":@"Hi. This is a test message.",@"timestamp":@1383225355}]]) {
		[mArr addObject:[conv convertToModel]];
	}
	
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getFullConversation:(BSConversation *)conversation onCompletion:(void(^)(BSConversation *fConversation, NSArray *errors))block
{
	block([[BSAPConversation classFromDict:@{@"id":@"46736007500-46736000005",@"to":@"46736007500",@"from":@{@"number":@"46736000005",@"contact":@{@"id":@10,@"firstname":@"Foo",@"lastname":@"Bar"}},@"body":@"Hi. This is a test message.",@"timestamp":@1383225355,@"items":@[@{@"id":@"12345",@"batch":[NSNull null],@"body":@"Hello World!",@"connection":@{@"id":@7,@"label":@"superman-connection"},@"to":@{@"address":@"46406007500",@"ton":@1,@"npi":@1},@"from":@{@"address":@"Beepsend",@"ton":@1,@"npi":@1},@"validity_period":@"131102072704000-",@"data_coding":@3,@"timestamps":@{@"sms":@{@"in":@1383225355,@"delivered":[NSNull null]},@"dlr_out":[NSNull null]},@"dlr":@{@"status":[NSNull null],@"error":[NSNull null]},@"price":@0.068,@"mccmnc":@{@"mcc":@"240",@"mnc":@"01"}}]}] convertToModel], nil);
}

@end
