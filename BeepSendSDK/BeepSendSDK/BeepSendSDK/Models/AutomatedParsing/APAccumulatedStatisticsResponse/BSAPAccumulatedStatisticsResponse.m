//
//  BSAPAccumulatedStatisticsResponse.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPAccumulatedStatisticsResponse.h"

#import "BSAccumulatedStatistics.h"

@implementation BSAPAccumulatedStatisticsResponse

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSAccumulatedStatistics alloc] initWithAccount:_account count:_count price:_price];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPAccumulatedStatisticsResponse classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
