//
//  BSSMSService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSMSService.h"

#import "BSAPIConfiguration.h"

#import "BSAPBatch.h"

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
			 sender:(NSString *)sender
		   receiver:(NSString *)receiver
	 withCompletion:(void (^)(id response, id error))block {
	
	[super executePOSTForMethod:[BSAPIConfiguration sms]
				 withParameters:@{ @"message" : message , @"from" : sender , @"to" : receiver }
				   onCompletion:^(id response, id error) {
					  
					  block(response, error);
				   }];
}

- (void)validateSMSForMessage:(NSString *)message
					   sender:(NSString *)sender
					 receiver:(NSString *)receiver
		  withCompletionBlock:(void(^)(id response, id error))block
{
	[super executePOSTForMethod:[BSAPIConfiguration validateSMS]
				 withParameters:@{ @"message" : message , @"from" : sender , @"to" : receiver }
				   onCompletion:^(id response, id error) {
					   
					   block(response, error);
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
