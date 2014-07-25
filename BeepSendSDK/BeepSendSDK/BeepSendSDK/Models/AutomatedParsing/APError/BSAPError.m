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
	if (![dictionary isKindOfClass:[NSDictionary class]] && ![dictionary isKindOfClass:[NSString class]]) {
		return nil;
	}
	
	if ([dictionary isKindOfClass:[NSDictionary class]]) {
		BSAPError *error = [super classFromDict:dictionary];
		return error;
	}
	else if	([dictionary isKindOfClass:[NSString class]]) {
		BSAPError *error = [[BSAPError alloc] init];
		error.code = @0;
		error.description = (NSString *)dictionary;
		return error;
	}
	
	return nil;
}

- (id)convertToModel
{
	return [[BSError alloc] initWithCode:_code andDescription:_description];
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

+ (NSArray *)arrayOfModelsFromArrayOfObjects:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[object convertToModel]];
	}
	return [NSArray arrayWithArray:results];
}

@end
