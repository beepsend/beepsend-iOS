//
//  BSAPEstimatedCost.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPEstimatedCost.h"

#import "BSEstimateCost.h"

@implementation BSAPEstimatedCost

#pragma mark - Inherited methods

- (id)convertToModel
{
	NSMutableArray *recipients = [@[] mutableCopy];
	if (_to) {
		for (NSString *key in [_to allKeys]) {
			[recipients addObject:[[BSValueForNumber alloc] initWithValue:key cost:_to[key]]];
		}
	}
	else if (_groups) {
		for (NSString *key in [_groups allKeys]) {
			[recipients addObject:[[BSValueForNumber alloc] initWithValue:key cost:_to[key]]];
		}
	}
	
	return [[BSEstimateCost alloc] initWithRecipients:[NSArray arrayWithArray:recipients] totalCost:_total_cost];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPEstimatedCost classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
