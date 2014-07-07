//
//  APConnection.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPConnection.h"

#import "BSAPCUser.h"

#import "BSConnectionModel.h"
#import "BSUserModel.h"

@implementation BSAPConnection

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPCCallback class];
	[BSAPWallet class];
	
	BSAPConnection *connection = [super classFromDict:dictionary];
	
	connection.users = [BSAPCUser arrayOfObjectsFromArrayOfDictionaries:connection.users];
	
	return connection;
}

- (id)convertToModel
{
	NSMutableArray *mUsers = [@[] mutableCopy];
	for (BSAPCUser *user in _users) {
		[mUsers addObject:[user convertToModel]];
	}
	
	return [[BSConnectionModel alloc] initConnectionWithID:_id apiToken:_api_token callbacks:[_callbacks convertToModel] customer:_customer description:_description label:_label?_label:_name?_name:@"" systemID:_system_id tlvformccandmnc:_tlv_for_mcc_mnc type:(BSConnectionType)[_type integerValue] users:[NSArray arrayWithArray:mUsers] wallet:[_wallet convertToModel] whitelist:_whitelist password:_password];
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

+ (NSArray *)arrayOfModelsFromArrayOfObjects:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[object convertToModel]];
	}
	return [NSArray arrayWithArray:results];
}

+ (BSAPConnection *)convertFromConnectionModel:(BSConnectionModel *)connectionModel
{
	BSAPConnection *connection = [[BSAPConnection alloc] init];
	
	BSAPCCallback *callback = [[BSAPCCallback alloc] init];
	callback.method = connectionModel.callbacks.method;
	callback.dlr = connectionModel.callbacks.DLR;
	callback.mo	= connectionModel.callbacks.MO;
	connection.callbacks = callback;
	
	BSAPWallet *wallet = [[BSAPWallet alloc] init];
	wallet.id = connectionModel.wallet.objectID;
	wallet.name = connectionModel.wallet.name;
	wallet.balance = connectionModel.wallet.balance;
	connection.wallet = wallet;
	
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSUserModel *usr in connectionModel.users) {
		BSAPCUser *user = [[BSAPCUser alloc] init];
		user.id = usr.objectID;
		user.name = usr.name;
		user.username = usr.email;
		[mArr addObject:user];
	}
	connection.users = [NSArray arrayWithArray:mArr];
	
	connection.id = connectionModel.objectID;
	connection.description = connectionModel.description;
	connection.api_token = connectionModel.apiToken;
	connection.customer = connectionModel.customer;
	connection.label = connectionModel.label;
	connection.system_id = connectionModel.systemID;
	connection.tlv_for_mcc_mnc = connectionModel.TLVForMCCAndMNC;
	connection.type = [NSNumber numberWithInteger:connectionModel.type];
	connection.whitelist = connectionModel.whitelist;
	connection.password = connectionModel.password;
	
	return connection;
}

@end
