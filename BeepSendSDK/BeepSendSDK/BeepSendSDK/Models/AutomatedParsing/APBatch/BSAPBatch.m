//
//  BSAPBatch.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPBatch.h"

#import "BSBatchModel.h"

@implementation BSAPBatch

#pragma mark - Inherited methods

- (id)convertToModel
{
	NSDate *dateOfCreation =
	_date_created!=nil && ![_date_created isKindOfClass:[NSNull class]] && ![_date_created isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_date_created doubleValue]]
	:
	nil;
	
	NSDate *dateOfLastUse =
	_last_used!=nil && ![_last_used isKindOfClass:[NSNull class]] && ![_last_used isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_last_used doubleValue]]
	:
	nil;
	
	return [[BSBatchModel alloc] initBatchWithID:_id label:_label dateOfCreation:dateOfCreation dateOfLastUse:dateOfLastUse];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPBatch classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
