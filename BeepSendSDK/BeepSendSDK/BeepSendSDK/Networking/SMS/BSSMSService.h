//
//  BSSMSService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSBatchModel.h"

@interface BSSMSService : BSBaseService

- (void)sendMessage:(NSString *)message
			 sender:(NSString *)sender
		   receiver:(NSString *)receiver
	 withCompletion:(void (^)(id response, id error))block;

- (void)validateSMSForMessage:(NSString *)message
					   sender:(NSString *)sender
					 receiver:(NSString *)receiver
		  withCompletionBlock:(void(^)(id response, id error))block;

- (void)getPreviousBatchesWithCompletionBlock:(void(^)(NSArray *bathces, id error))block;

- (void)getDetailsForBatch:(NSString *)batchID withCompletionBlock:(void(^)(BSBatchModel *batch, id error))block;

@end
