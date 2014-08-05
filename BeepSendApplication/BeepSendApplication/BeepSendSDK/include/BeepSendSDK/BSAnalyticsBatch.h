//
//  BSAnalyticsBatchModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSStatistics.h"

/*!
 @class BSAnalyticsBatch
 @discussion Batch details will give you delivery statistics for a whole batch.
 */
@interface BSAnalyticsBatch : BSGeneralModel

/*! Unique batch id
 */
@property (nonatomic, strong, readonly) NSString *batchID;

/*! Batch name
  */
@property (nonatomic, strong, readonly) NSString *label;

/*! Total amount of messages in the batch
 */
@property (nonatomic, strong, readonly) NSNumber *total;

/*! Statistics
 */
@property (nonatomic, strong, readonly) BSStatistics *statistic;

/*! Create Analytics Batch object
 
 @param abID - Unique batch id
 @param abLabel - Batch name
 @param abTotal - Total amount of messages in the batch
 @param abStats - Statistics
 
 @return Returns Analytics Batch object
 */
- (BSAnalyticsBatch *)initWithID:(NSString *)abID
						   label:(NSString *)abLabel
						   total:(NSNumber *)abTotal
					  statistics:(BSStatistics *)abStats;

@end
