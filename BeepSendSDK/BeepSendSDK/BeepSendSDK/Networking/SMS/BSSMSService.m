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

#import "BSGroupModel.h"

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

- (void)sendMessage:(NSString *)message
			   from:(NSString *)sender
				 to:(id)receiver
			 groups:(NSArray *)groups
		 withBachID:(NSString *)batchID
	  andBatchLabel:(NSString *)batchLabel
	atScheduledTime:(NSString *)scheduleTime
	   usedEncoding:(NSString *)encoding
		messageType:(NSString *)type
		   validFor:(NSString *)validTime
recieveDeliveryReport:(NSNumber *)receiveDlrOption
withCompletionBlock:(void(^)(NSArray *response, id error))block
{
	BSAPMessageRequest *messageRequest = [[BSAPMessageRequest alloc] init];
	messageRequest.message = message;
	messageRequest.from = sender;
	messageRequest.to = receiver;
	messageRequest.batch_id = batchID;
	messageRequest.batch_label = batchLabel;
	messageRequest.send_time = scheduleTime;
	messageRequest.encoding = encoding;
	messageRequest.message_type = type;
	messageRequest.validity_period = validTime;
	messageRequest.receive_dlr = receiveDlrOption;
	
	NSMutableArray *groupsID = [@[] mutableCopy];
	if (groups && groups.count>0) {
		if ([groups[0] isKindOfClass:[BSGroupModel class]]) {
			for (BSGroupModel *group in groups) {
				[groupsID addObject:group.objectID];
			}
		}
		else {
			groupsID = [groups mutableCopy];
		}
	}
	messageRequest.groups = groupsID;
	
	NSDictionary *parameters = [messageRequest dictFromClass];
	BSLog(@"%@", parameters);
	
	[super executePOSTForMethod:groups?[BSAPIConfiguration batches]:[BSAPIConfiguration sms]
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

- (void)sendMessage:(BSMessageRequestModel *)messageRequest usingConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *response, id error))block
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

- (void)sendMessages:(NSArray *)messages usingConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *array, id error))block
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

- (void)lookupSMS:(BSMessageModel *)sms withCompletionBlock:(void(^)(BSLookupModel *lookupResponse, id error))block {
	
	[super executeGETForMethod:[BSAPIConfiguration smsLookupWithID:sms.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSLookupModel *smslookup = [[BSAPSMSLookup classFromDict:response] convertToModel];
						  
						  block(smslookup, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

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
		recieveDeliveryReport:(NSNumber *)receiveDlrOption
		  withCompletionBlock:(void(^)(BSMessageModel *message, id error))block
{
	BSAPMessageRequest *messageRequest = [[BSAPMessageRequest alloc] init];
	messageRequest.message = message;
	messageRequest.from = sender;
	messageRequest.to = receiver;
	messageRequest.batch_id = batchID;
	messageRequest.batch_label = batchLabel;
	messageRequest.send_time = scheduleTime;
	messageRequest.encoding = encoding;
	messageRequest.message_type = type;
	messageRequest.validity_period = validTime;
	messageRequest.receive_dlr = receiveDlrOption;
	messageRequest.groups = groups;
	
	NSDictionary *parameters = [messageRequest dictFromClass];
	BSLog(@"%@", parameters);
	
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

- (void)getDetailsForBatch:(NSString *)batchID withCompletionBlock:(void(^)(BSBatchModel *batch, id error))block
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

@end
