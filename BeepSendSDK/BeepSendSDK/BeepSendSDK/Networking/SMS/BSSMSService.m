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
#import "BSAPTwoWayBatch.h"
#import "BSAPConversation.h"

#import "BSConnection.h"

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
	NSString *method;
	if (messageRequest.groups) {
		if (connection) {
			method = [BSAPIConfiguration batchesForID:connection.objectID];
		}
		else {
			method = [BSAPIConfiguration batches];
		}
	}
	else {
		if (connection) {
			method = [BSAPIConfiguration smsForID:connection.objectID];
		}
		else {
			method = [BSAPIConfiguration sms];
		}
	}
	
	NSDictionary *parameters = [[BSAPMessageRequest convertFromMessageRequestModel:messageRequest] dictFromClass];
	
	[super executePOSTForMethod:method
				 withParameters:parameters
				   onCompletion:^(id response, id error) {
					   
					   if ([response isKindOfClass:[NSArray class]]) {
						   
						   NSMutableArray *mArr = [@[] mutableCopy];
						   for (BSAPMessage *msg in [BSAPMessage arrayOfObjectsFromArrayOfDictionaries:response]) {
							   [mArr addObject:[msg convertToModel]];
						   }
						   
						   BSMessage *m = mArr[0];
						   
						   if (m.errors.count>0) {
							   block(nil, m.errors);
						   }
						   else {
							   block(m, nil);
						   }
					   }
					   else {

						   block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					   }
				   }];
}

- (void)sendMessages:(NSArray *)messages usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *array, NSArray *errors))block
{
	BOOL containGroups = NO;
	NSMutableArray *parameters = [@[] mutableCopy];
	for (BSAPMessageRequest *request in [BSAPMessageRequest arrayOfObjectsFromArrayOfModels:messages]) {
		[parameters addObject:[request dictFromClass]];
		if (request.groups) {
			containGroups = YES;
		}
	}
	
	NSString *method;
	if (containGroups) {
		if (connection) {
			method = [BSAPIConfiguration batchesForID:connection.objectID];
		}
		else {
			method = [BSAPIConfiguration batches];
		}
	}
	else {
		if (connection) {
			method = [BSAPIConfiguration smsForID:connection.objectID];
		}
		else {
			method = [BSAPIConfiguration sms];
		}
	}
	
	[super executePOSTForMethod:method
				 withParameters:parameters
				   onCompletion:^(id response, id error) {
					   
					   if ([response isKindOfClass:[NSArray class]]) {
						   
						   NSMutableArray *mArr = [@[] mutableCopy];
						   NSMutableArray *errors = [@[] mutableCopy];
						   for (BSAPMessage *msg in [BSAPMessage arrayOfObjectsFromArrayOfDictionaries:response]) {
							   BSMessage *message = [msg convertToModel];
							   [mArr addObject:message];
							   
							   if (message.errors.count>0) {
								   [errors addObjectsFromArray:message.errors];
							   }
						   }
						   
						   block([NSArray arrayWithArray:mArr], errors.count>0 ? errors : nil);
					   }
					   else {

						   block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					   }
				   }];
}

- (void)lookupSMS:(BSMessage *)sms withCompletionBlock:(void(^)(BSLookup *lookupResponse, NSArray *errors))block
{
	
	[super executeGETForMethod:[BSAPIConfiguration smsLookupWithID:sms.messageID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSLookup *smslookup = [[BSAPSMSLookup classFromDict:response] convertToModel];
						  
						  block(smslookup, nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)lookupMultipleSMSSentTo:(NSString *)recipient setnFrom:(NSString *)sender usingConnection:(BSConnection *)connection batch:(BSBatch *)batch sinceID:(NSString *)sinceID maxID:(NSString *)maxID afterDate:(NSDate *)afterDate beforeDate:(NSDate *)beforeDate count:(NSNumber *)count withCompletionBlock:(void(^)(NSArray *lookupResponse, NSArray *error))block
{
	NSMutableDictionary *parameters = [@{} mutableCopy];
	if (recipient) {
		[parameters setObject:recipient forKey:@"to"];
	}
	if (sender) {
		[parameters setObject:sender forKey:@"from"];
	}
	if (connection && ![connection.objectID isEqualToString:@"0"]) {
		[parameters setObject:connection.objectID forKey:@"connection_id"];
	}
	if (batch && ![batch.objectID isEqualToString:@"0"]) {
		[parameters setObject:batch.objectID forKey:@"batch_id"];
	}
	if (sinceID) {
		[parameters setObject:sinceID forKey:@"since_id"];
	}
	if (maxID) {
		[parameters setObject:maxID forKey:@"max_id"];
	}
	if (count) {
		[parameters setObject:count forKey:@"count"];
	}
	if (afterDate) {
		[parameters setObject:[NSString stringWithFormat:@"%f", [afterDate timeIntervalSince1970]] forKey:@"after_date"];
	}
	if (beforeDate) {
		[parameters setObject:[NSString stringWithFormat:@"%f", [beforeDate timeIntervalSince1970]] forKey:@"before_date"];
	}
	
	[super executePOSTForMethod:[BSAPIConfiguration sms]
				 withParameters:parameters
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   
						   NSMutableArray *mArr = [@[] mutableCopy];
						   for (BSAPSMSLookup *msg in [BSAPSMSLookup arrayOfObjectsFromArrayOfDictionaries:response]) {
							   [mArr addObject:[msg convertToModel]];
						   }
						   block([NSArray arrayWithArray:mArr], nil);
					   }
					   else {

						   block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					   }
				   }];
}

- (void)validateSMSForMessage:(BSMessage *)message withCompletionBlock:(void(^)(BSMessage *message, NSArray *errors))block
{
	NSDictionary *parameters = [[BSAPMessageRequest convertFromMessageRequestModel:message] dictFromClass];
	BSDLog(@"%@", parameters);
	
	[super executePOSTForMethod:[BSAPIConfiguration validateSMS]
				 withParameters:parameters
				   onCompletion:^(id response, id error) {
					   
					   BSMessage *message = [[BSAPMessage classFromDict:response] convertToModel];
					   
					   if (!error) {
						   
						   block(message, nil);
					   }
					   else {
						   
						   if (message.errors.count>0) {
							   block(nil, message.errors);
						   }
						   else {
							   block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
						   }
					   }

				   }];
}

- (void)getPreviousBatchesWithCompletionBlock:(void(^)(NSArray *bathces, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration batches]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {

						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPBatch *batch in [BSAPBatch arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[batch convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getDetailsForBatch:(NSString *)batchID withCompletionBlock:(void(^)(BSBatch *batch, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration batchesForID:batchID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {

						  block([[BSAPBatch classFromDict:response] convertToModel], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getTwoWayBatchForBatchID:(NSString *)batchID onCompletion:(void(^)(NSArray *batches, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration twoWayBatchesForID:batchID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSArray *result;
						  if (![response isKindOfClass:[NSArray class]]) {
							  result = @[response];
						  }
						  else {
							  result = [NSArray arrayWithArray:response];
						  }
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPTwoWayBatch *twb in [BSAPTwoWayBatch arrayOfObjectsFromArrayOfDictionaries:result]) {
							  [mArr addObject:[twb convertToModel]];
						  }
						  
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {
						  
						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)estimateCostForMessages:(NSArray *)messageRequest usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *response, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSMessage *mrm in messageRequest) {
		[mArr addObject:[[BSAPMessageRequest convertFromMessageRequestModel:mrm] dictFromClass]];
	}
	
	[super executePOSTForMethod:connection?[BSAPIConfiguration smsCostEstimateForID:connection.objectID]:[BSAPIConfiguration smsCostEstimate]
				 withParameters:[NSArray arrayWithArray:mArr]
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   NSArray *result;
						   if (![response isKindOfClass:[NSArray class]]) {
							   result = @[response];
						   }
						   else {
							   result = [NSArray arrayWithArray:response];
						   }
						   
						   NSMutableArray *mArr = [@[] mutableCopy];
						   for (BSAPEstimatedCost *msg in [BSAPEstimatedCost arrayOfObjectsFromArrayOfDictionaries:result]) {
							   [mArr addObject:[msg convertToModel]];
						   }
						   block([NSArray arrayWithArray:mArr], nil);
					   }
					   else {

						   block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					   }
				   }];

}

- (void)getConversationsOnCompletion:(void(^)(NSArray *conversations, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration conversation]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  NSArray *result;
						  if (![response isKindOfClass:[NSArray class]]) {
							  result = @[response];
						  }
						  else {
							  result = [NSArray arrayWithArray:response];
						  }
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPConversation *conv in [BSAPConversation arrayOfObjectsFromArrayOfDictionaries:result]) {
							  [mArr addObject:[conv convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {
						  
						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
					  
				  }];
}

- (void)getFullConversation:(BSConversation *)conversation onCompletion:(void(^)(BSConversation *fConversation, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration conversationForID:conversation.conversationID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block([[BSAPConversation classFromDict:response] convertToModel], nil);
					  }
					  else {
						  
						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
					  
				  }];
}

@end
