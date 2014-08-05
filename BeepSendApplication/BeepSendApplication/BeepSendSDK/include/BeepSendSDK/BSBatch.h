//
//  BSBatch.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSError.h"

/*!
 @class BSBatch
 @discussion When sending multiple messages to one or more receivers add batch label 
 and later on you can use same batch for sending messages.
 */
@interface BSBatch : BSGeneralModel

/*! Batch id.
 */
@property (nonatomic, strong, readonly) NSString *batchID;

/*! Batch name.
 */
@property (nonatomic, strong, readonly) NSString *label;

/*! Creation time of batch.
 */
@property (nonatomic, strong) NSDate *createdAt;

/*! Last time the batch was used to send a message.
 */
@property (nonatomic, strong) NSDate *lastUsed;

/*! Create Batch object
 
 @param bID - Batch id
 @param bLabel - Creation time of batch
 
 @return Returns Batch object
 */
- (BSBatch *)initWithID:(NSString *)bID
			   andLabel:(NSString *)bLabel;

/*! This call will give you delivery statistics for a whole batch.
 
 @param block - Returns statistics list or error
 */
- (void)getDeliveryStatisticsWithCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block;

@end
