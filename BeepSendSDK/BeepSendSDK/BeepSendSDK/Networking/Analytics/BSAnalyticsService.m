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

- (void)getAnalyticsSummaryFromDate:(NSDate *)startDate toDate:(NSDate *)endDate usingConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *statistics, id error))block
{
	BSAPAccumulatedStatisticsRequest *request = [[BSAPAccumulatedStatisticsRequest alloc] init];
	request.from_date = startDate ? [NSString stringWithFormat:@"%f", [startDate timeIntervalSince1970]] : nil;
	request.to_date = endDate ? [NSString stringWithFormat:@"%f", [endDate timeIntervalSince1970]] : nil;
	NSDictionary *params = [request dictFromClass];
	
	[super executeGETForMethod:connection?[BSAPIConfiguration analyticsSummaryForID:connection.objectID]:[BSAPIConfiguration analyticsSummaryMe]
				withParameters:params
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPAccumulatedStatisticsResponse *con in [BSAPAccumulatedStatisticsResponse arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[con convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getNetworkDetailsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate mccmnc:(BSMCCMNC *)mccmnc usingConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *networkDetails, id error))block
{
	BSAPNetworkDetailsRequest *request = [[BSAPNetworkDetailsRequest alloc] init];
	request.from_date = startDate ? [NSString stringWithFormat:@"%f", [startDate timeIntervalSince1970]] : nil;
	request.to_date = endDate ? [NSString stringWithFormat:@"%f", [endDate timeIntervalSince1970]] : nil;
	request.MCC = mccmnc ? mccmnc.mcc : nil;
	request.MNC = mccmnc ? mccmnc.mnc : nil;
	NSDictionary *params = [request dictFromClass];
	
	[super executeGETForMethod:connection?[BSAPIConfiguration analyticsNetworkForID:connection.objectID]:[BSAPIConfiguration analyticsNetworkMe]
				withParameters:params
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPNetworkDetailsResponse *con in [BSAPNetworkDetailsResponse arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[con convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getDeliveryStatisticsForBach:(BSBatch *)batch withCompletionBlock:(void(^)(NSArray *statistics, id error))block
{
	[super executeGETForMethod:batch?[BSAPIConfiguration analyticsBatchesForID:batch.batchID]:[BSAPIConfiguration analyticsBatches]
				withParameters:@[]
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPAnalyticsBatch *con in [BSAPAnalyticsBatch arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[con convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

@end
