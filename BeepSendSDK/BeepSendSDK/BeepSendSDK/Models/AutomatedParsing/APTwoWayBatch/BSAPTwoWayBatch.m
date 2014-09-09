//
//  BSAPTwoWayBatch.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPTwoWayBatch.h"

#import "BSTwoWayBatch.h"

@implementation BSAPTwoWayBatch

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSTwoWayBatch alloc] initWithMtSmsID:_mt_sms_id mtBody:_mt_body moSmsID:_mo_sms_id moBody:_mo_body deliveryStatus:_dlr_stst];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPTwoWayBatch classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
