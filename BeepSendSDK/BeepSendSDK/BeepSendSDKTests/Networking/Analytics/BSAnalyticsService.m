//
//  BSAnalyticsService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAnalyticsService.h"

#import "BSAPIConfiguration.h"

#import "BSAPAccumulatedStatisticsRequest.h"
#import "BSAPAccumulatedStatisticsResponse.h"

#import "BSAPNetworkDetailsRequest.h"
#import "BSAPNetworkDetailsResponse.h"

#import "BSAPAnalyticsBatch.h"

@implementation BSAnalyticsService

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

- (void)getAnalyticsSummaryFromDate:(NSDate *)startDate toDate:(NSDate *)endDate usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPAccumulatedStatisticsResponse *con in [BSAPAccumulatedStatisticsResponse arrayOfObjectsFromArrayOfDictionaries:@[@{@"connection":@"customer-1",@"count":@100,@"price":@4.38},@{@"connection":@"customer-2",@"count":@100,@"price":@4.38},@{@"connection":@"customer-3",@"count":@100,@"price":@4.38}]]) {
		[mArr addObject:[con convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getNetworkDetailsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate mccmnc:(BSMCCMNC *)mccmnc usingConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *networkDetails, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPNetworkDetailsResponse *con in [BSAPNetworkDetailsResponse arrayOfObjectsFromArrayOfDictionaries:@[@{@"mccmnc":@{@"mcc":@"648",@"mnc":@"03"},@"statistics":@{@"delivered":@100,@"mo":@0,@"expired":@12,@"unknown":@20,@"rejected":@0,@"undelivered":@10,@"no_dlr":@0},@"total":@142},@{@"mccmnc":@{@"mcc":@"648",@"mnc":@"03"},@"statistics":@{@"delivered":@100,@"mo":@0,@"expired":@12,@"unknown":@20,@"rejected":@0,@"undelivered":@10,@"no_dlr":@0},@"total":@142}]]) {
		[mArr addObject:[con convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getDeliveryStatisticsForBach:(BSBatch *)batch withCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPAnalyticsBatch *con in [BSAPAnalyticsBatch arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@23,@"label":@"My batch",@"total":@142,@"statistics":@{@"delivered":@100,@"expired":@12,@"unknown":@20,@"rejected":@0,@"undelivered":@10,@"no_dlr":@0}},@{@"id":@24,@"label":@"My batch",@"total":@142,@"statistics":@{@"delivered":@100,@"expired":@12,@"unknown":@20,@"rejected":@0,@"undelivered":@10,@"no_dlr":@0}}]]) {
		[mArr addObject:[con convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

@end
