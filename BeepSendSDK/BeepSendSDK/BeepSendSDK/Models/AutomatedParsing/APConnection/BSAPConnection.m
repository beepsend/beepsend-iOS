//
//  APConnection.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPConnection.h"

@implementation BSAPConnection

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPCCallback class];
	[BSAPCWallet class];
	
	BSAPConnection *connection = [super classFromDict:dictionary];
	
	connection.users = [BSAPCUser arrayOfObjectsFromArrayOfDictionaries:connection.users];
	
	return connection;
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPConnection classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

- (BSConnectionModel *)convertToConnectionModel
{
	//TODO: Convert to real objects
	return [[BSConnectionModel alloc] init];
}

@end
