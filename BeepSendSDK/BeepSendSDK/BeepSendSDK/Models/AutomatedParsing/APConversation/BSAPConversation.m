//
//  BSAPConversation.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPConversation.h"

#import "BSAPSMSLookup.h"

#import "BSConversation.h"

@implementation BSAPConversation

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPSender class];
	[BSAPSMSLookup class];
	
	BSAPConversation *conversation = [super classFromDict:dictionary];
	
	conversation.items = [BSAPSMSLookup arrayOfObjectsFromArrayOfDictionaries:conversation.items];
	
	return conversation;
}

- (id)convertToModel
{
	NSDate *timestamp =
	_timestamp!=nil && ![_timestamp isKindOfClass:[NSNull class]] && ![_timestamp isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_timestamp doubleValue]]
	:
	nil;
	
	NSMutableArray *cItems = [@[] mutableCopy];
	for (BSAPSMSLookup *item in _items) {
		[cItems addObject:[item convertToModel]];
	}
	
	return [[BSConversation alloc] initConversationWithID:_id
												recipient:_to
												   sender:[_from convertToModel]
											  messageBody:_body
									lastReceivedMessageAt:timestamp
													items:cItems];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPConversation classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
