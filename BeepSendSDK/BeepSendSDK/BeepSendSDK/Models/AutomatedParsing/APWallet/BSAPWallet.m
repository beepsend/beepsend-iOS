//
//  BSAPWallet.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPWallet.h"

#import "BSAPConnection.h"
#import "BSAPCUser.h"

#import "BSWalletModel.h"

@implementation BSAPWallet

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	BSAPWallet *wallet = [super classFromDict:dictionary];

	wallet.connections = [BSAPConnection arrayOfObjectsFromArrayOfDictionaries:wallet.connections];
	wallet.users = [BSAPCUser arrayOfObjectsFromArrayOfDictionaries:wallet.users];
	
	return wallet;
}

- (id)convertToModel
{
	return [[BSWalletModel alloc] initWalletWithID:_id
											 named:_name
										   balance:_balance
									minimumBalance:_notify_limit
									   connections:[BSAPConnection arrayOfModelsFromArrayOfObjects:_connections]
											 users:[BSAPCUser arrayOfModelsFromArrayOfObjects:_users]];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPWallet classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
