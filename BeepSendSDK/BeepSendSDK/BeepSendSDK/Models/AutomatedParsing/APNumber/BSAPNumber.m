//
//  BSAPNumber.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPNumber.h"

#import "BSNumber.h"

@implementation BSAPNumber

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSNumber alloc] initWithID:_id country:[_country convertToModel] connection:[_connection convertToModel] andRecipientNumber:_number];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPNumber classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
