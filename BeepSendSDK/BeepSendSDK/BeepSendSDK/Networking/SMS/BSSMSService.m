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
				 to:(NSString *)receiver
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
	messageRequest.groups = groups;
	
	NSDictionary *parameters = [messageRequest dictFromClass];
	BSLog(@"%@", parameters);
	
	[super executePOSTForMethod:[BSAPIConfiguration sms]
				 withParameters:parameters
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   
						   NSMutableArray *mArr = [@[] mutableCopy];
						   for (BSAPMessage *msg in [BSAPMessage arrayOfObjectsFromArrayOfDictionaries:response]) {
							   [mArr addObject:[msg convertToMessageModel]];
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
						  
						  BSLookupModel *smslookup = [[BSAPSMSLookup classFromDict:response] convertToLookupModel];
						  
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
						   
						   block([[BSAPMessage classFromDict:response] convertToMessageModel], error);
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
							  [mArr addObject:[batch convertToBatchModel]];
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

						  block([[BSAPBatch classFromDict:response] convertToBatchModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

@end
