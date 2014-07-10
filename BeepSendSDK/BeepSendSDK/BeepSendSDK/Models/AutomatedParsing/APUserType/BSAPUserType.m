//
//  BSAPUserType.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPUserType.h"

#import "BSUserType.h"

@implementation BSAPUserType

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSUserType alloc] initUserTypeWithID:_id name:_name?_name:@""];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPUserType classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
