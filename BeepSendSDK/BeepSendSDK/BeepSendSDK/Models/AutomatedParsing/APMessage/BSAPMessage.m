//
//  BSAPMessage.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPMessage.h"

#import "BSMessage.h"
#import "BSAPError.h"

@implementation BSAPMessage

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPBatch class];
	
	BSAPMessage *message = [super classFromDict:dictionary];
	message.errors = [BSAPError arrayOfObjectsFromArrayOfDictionaries:message.errors];
	
	return message;
}

- (id)convertToModel
{
	return [[BSMessage alloc] initMessageWithID:_id batch:[_batch convertToModel] recipients:_to sender:_from errors:[_errors isKindOfClass:[NSArray class]]?[BSAPError arrayOfModelsFromArrayOfObjects:_errors]:nil recipientGroups:_groups];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPMessage classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
