//
//  BSAPError.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPError.h"

#import "BSError.h"

@implementation BSAPError

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	BSAPError *error = [super classFromDict:dictionary];
	return error;
}

- (id)convertToModel
{
	return [[BSError alloc] initWithCode:@0 andDescription:@""];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPError classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}
@end
