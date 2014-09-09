//
//  BSAnalyticsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSConnection.h"
#import "BSAccumulatedStatistics.h"
#import "BSNetworkDetails.h"

#import "BSMCCMNC.h"
#import "BSBatch.h"
#import "BSError.h"

@interface BSAnalyticsService : NSObject

- (void)getAnalyticsSummaryFromDate:(NSDate *)startDate toDate:(NSDate *)endDate usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block;

- (void)getNetworkDetailsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate mccmnc:(BSMCCMNC *)mccmnc usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *networkDetails, NSArray *errors))block;

- (void)getDeliveryStatisticsForBach:(BSBatch *)batch withCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block;

@end
