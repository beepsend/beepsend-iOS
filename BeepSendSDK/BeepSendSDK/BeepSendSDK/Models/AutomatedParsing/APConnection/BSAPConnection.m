//
//  APConnection.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPConnection.h"

#import "BSAPCUser.h"

#import "BSConnection.h"
#import "BSCallbacks.h"
#import "BSWallet.h"
#import "BSUser.h"

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
	
	if (![_whitelist isKindOfClass:[NSArray class]]) {
		_whitelist = nil;
	}
	
	return [[BSConnection alloc] initConnectionWithID:_id
											 apiToken:_api_token
											callbacks:[_callbacks convertToModel]
											 customer:_customer
										  description:_description
												label:_label?_label:_name?_name:@""
											 systemID:_system_id
									  tlvformccandmnc:_tlv_for_mcc_mnc
												 type:(BSConnectionType)[_type integerValue]
												users:[NSArray arrayWithArray:mUsers]
											   wallet:[_wallet convertToModel]
											whitelist:_whitelist
											 password:_password];
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

+ (BSAPConnection *)convertFromConnectionModel:(BSConnection *)connectionModel
{
	BSAPConnection *connection = [[BSAPConnection alloc] init];
	
	if ([connectionModel.connectionID isEqualToString:@"-1"]) {
		return connection;
	}
	
	BSAPCCallback *callback = [[BSAPCCallback alloc] init];
	callback.method = [connectionModel.callbackURLs.method isEqualToString:@""] ? nil : connectionModel.callbackURLs.method;
	callback.dlr = [connectionModel.callbackURLs.DLR isEqualToString:@""] ? nil : connectionModel.callbackURLs.DLR;
	callback.mo	= [connectionModel.callbackURLs.MO isEqualToString:@""] ? nil : connectionModel.callbackURLs.MO;
	connection.callbacks = callback;
	
	BSAPWallet *wallet = [[BSAPWallet alloc] init];
	wallet.id = [connectionModel.wallet.walletID isEqualToString:@"0"] ? nil : connectionModel.wallet.walletID;
	wallet.name = [connectionModel.wallet.name isEqualToString:@""] ? nil : connectionModel.wallet.name;
	wallet.balance = [connectionModel.wallet.balance isEqualToNumber:@0] ? nil : connectionModel.wallet.balance;
	connection.wallet = wallet;
	
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSUser *usr in connectionModel.users) {
		BSAPCUser *user = [[BSAPCUser alloc] init];
		user.id = [usr.userID isEqualToString:@"0"] ? nil : usr.userID;
		user.name = [usr.name isEqualToString:@""] ? nil : usr.name;
		user.username = [usr.email isEqualToString:@""] ? nil : usr.email;
		[mArr addObject:user];
	}
	connection.users = [NSArray arrayWithArray:mArr];
	
	connection.id = [connectionModel.connectionID isEqualToString:@"0"] ? nil : connectionModel.connectionID;
	connection.description = [connectionModel.description isEqualToString:@""] ? nil : connectionModel.description;
	connection.api_token = [connectionModel.apiToken isEqualToString:@""] ? nil : connectionModel.apiToken;
	connection.customer = [connectionModel.customer isEqualToString:@""] ? nil : connectionModel.customer;
	connection.label = [connectionModel.label isEqualToString:@""] ? nil : connectionModel.label;
	connection.system_id = [connectionModel.systemID isEqualToString:@""] ? nil : connectionModel.systemID;
	connection.tlv_for_mcc_mnc = [connectionModel.TLVForMCCAndMNC isEqualToNumber:@0] ? nil : connectionModel.TLVForMCCAndMNC;
	connection.type = [NSNumber numberWithInteger:connectionModel.type];
	connection.whitelist = connectionModel.whitelist.count == 0 ? nil : connectionModel.whitelist;
	connection.password = [connectionModel.password isEqualToString:@""] ? nil : connectionModel.password;
	
	return connection;
}

@end
