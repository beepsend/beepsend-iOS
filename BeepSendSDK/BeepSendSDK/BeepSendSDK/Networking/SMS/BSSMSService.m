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

- (void)sendMessage:(BSMessage *)messageRequest usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *response, id error))block
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
					   
					   if (!error) {
						   
						   NSMutableArray *mArr = [@[] mutableCopy];
						   for (BSAPMessage *msg in [BSAPMessage arrayOfObjectsFromArrayOfDictionaries:response]) {
							   [mArr addObject:[msg convertToModel]];
						   }
						   block([NSArray arrayWithArray:mArr], error);
					   }
					   else {
						   //TODO: Create error handling
						   block(nil, response);
					   }
				   }];
}

- (void)sendMessages:(NSArray *)messages usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *array, id error))block
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
					   
					   if (!error) {
						   
						   NSMutableArray *mArr = [@[] mutableCopy];
						   for (BSAPMessage *msg in [BSAPMessage arrayOfObjectsFromArrayOfDictionaries:response]) {
							   [mArr addObject:[msg convertToModel]];
						   }
						   block([NSArray arrayWithArray:mArr], error);
					   }
					   else {
						   //TODO: Create error handling
						   block(nil, response);
					   }
				   }];
}

- (void)lookupSMS:(BSMessage *)sms withCompletionBlock:(void(^)(BSLookup *lookupResponse, id error))block {
	
	[super executeGETForMethod:[BSAPIConfiguration smsLookupWithID:sms.messageID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSLookup *smslookup = [[BSAPSMSLookup classFromDict:response] convertToModel];
						  
						  block(smslookup, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)validateSMSForMessage:(BSMessage *)message withCompletionBlock:(void(^)(BSMessage *message, id error))block
{
	NSDictionary *parameters = [[BSAPMessageRequest convertFromMessageRequestModel:message] dictFromClass];
	BSDLog(@"%@", parameters);
	
	[super executePOSTForMethod:[BSAPIConfiguration validateSMS]
				 withParameters:parameters
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   
						   block([[BSAPMessage classFromDict:response] convertToModel], error);
					   }
					   else {
						   //TODO: Create error handling
						   block(nil, response);
					   }
				   }];
}

- (void)getPreviousBatchesWithCompletionBlock:(void(^)(NSArray *bathces, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration batches]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {

						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPBatch *batch in [BSAPBatch arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[batch convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getDetailsForBatch:(NSString *)batchID withCompletionBlock:(void(^)(BSBatch *batch, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration batchesForID:batchID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {

						  block([[BSAPBatch classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)estimateCostForMessages:(NSArray *)messageRequest usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *response, id error))block
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
						   block([NSArray arrayWithArray:mArr], error);
					   }
					   else {
						   //TODO: Create error handling
						   block(nil, response);
					   }
				   }];

}

@end
