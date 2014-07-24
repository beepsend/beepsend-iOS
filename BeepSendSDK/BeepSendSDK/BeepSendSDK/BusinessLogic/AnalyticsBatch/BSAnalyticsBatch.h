//
//  BSAnalyticsBatchModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSStatistics;

@interface BSAnalyticsBatch : BSGeneralModel

/** Unique batch id
 */
@property (nonatomic, strong, readonly) NSString *batchID;

/** Batch name
  */
@property (nonatomic, strong, readonly) NSString *label;

/** Total amount of messages in the batch
 */
@property (nonatomic, strong, readonly) NSNumber *total;

/** Statistics
 */
@property (nonatomic, strong, readonly) BSStatistics *statistic;

/** Init Analytics Batch with AnalyticsBatch ID, Label, Total, Statistics
 
 @param abID - AnalyticsBatch ID
 @param abLabel - Label
 @param abTotal - Total
 @param abStats - Stats
 
 @return Returns Analytics Batch object
 */
- (BSAnalyticsBatch *)initWithID:(NSString *)abID label:(NSString *)abLabel total:(NSNumber *)abTotal statistics:(BSStatistics *)abStats;

@end
