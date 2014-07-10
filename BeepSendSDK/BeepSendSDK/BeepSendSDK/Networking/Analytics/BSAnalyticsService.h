//
//  BSAnalyticsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSConnection.h"
#import "BSAccumulatedStatisticsModel.h"
#import "BSNetworkDetailsModel.h"

#import "BSMCCMNC.h"
#import "BSBatch.h"

@interface BSAnalyticsService : BSBaseService

- (void)getAnalyticsSummaryFromDate:(NSDate *)startDate toDate:(NSDate *)endDate usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *statistics, id error))block;

- (void)getNetworkDetailsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate mccmnc:(BSMCCMNC *)mccmnc usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *networkDetails, id error))block;

- (void)getDeliveryStatisticsForBach:(BSBatch *)batch withCompletionBlock:(void(^)(NSArray *statistics, id error))block;

@end
