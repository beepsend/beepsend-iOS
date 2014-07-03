//
//  BSAnalyticsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSConnectionModel.h"
#import "BSAccumulatedStatisticsModel.h"
#import "BSNetworkDetailsModel.h"
#import "BSMCCMNCModel.h"

@interface BSAnalyticsService : BSBaseService

- (void)getAnalyticsSummaryFromDate:(NSDate *)startDate toDate:(NSDate *)endDate usingConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *statistics, id error))block;

- (void)getNetworkDetailsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate mccmnc:(BSMCCMNCModel *)mccmnc usingConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *networkDetails, id error))block;

@end
