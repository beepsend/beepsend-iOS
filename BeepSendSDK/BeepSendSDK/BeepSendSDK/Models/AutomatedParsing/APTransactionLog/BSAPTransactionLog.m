//
//  BSAPTransactionLog.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPTransactionLog.h"

#import "BSLogModel.h"

@implementation BSAPTransactionLog

#pragma mark - Inherited methods

- (id)convertToModel
{
	NSDate *transactionTime =
	_timestamp!=nil && ![_timestamp isKindOfClass:[NSNull class]] && ![_timestamp isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_timestamp doubleValue]]
	:
	nil;
	
	return [[BSLogModel alloc] initLogWithID:_id atTime:transactionTime withBalance:_new_balance change:_change comment:_comment];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPTransactionLog classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

+ (NSArray *)arrayOfModelsFromArrayOfObjects:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[object convertToModel]];
	}
	return [NSArray arrayWithArray:results];
}

@end
