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
	BSCallbacksModel *callback = [[BSCallbacksModel alloc] initCallbackWithMethod:_callbacks.method
																			  dlr:_callbacks.dlr
																			   mo:_callbacks.mo];
	
	BSWalletModel *wallet = [[BSWalletModel alloc] initWalletWithID:_wallet.id
															   name:_wallet.name
															balance:_wallet.balance];
	
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPCUser *user in _users) {
		BSUserModel *usr = [[BSUserModel alloc] initUserWithID:user.id
														  name:user.name
														 email:user.username];
		[mArr addObject:usr];
	}
	NSArray *users = [NSArray arrayWithArray:mArr];
	
	BSConnectionModel *connection = [[BSConnectionModel alloc] initConnectionWithID:_id
																		   apiToken:_api_token
																		  callbacks:callback
																		   customer:_customer
																		description:_description
																			  label:_label
																		   systemID:_system_id
																	tlvformccandmnc:_tlv_for_mcc_mnc
																			   type:_type
																			  users:users
																			 wallet:wallet
																		  whitelist:_whitelist];
	
	return connection;
}

+ (BSAPConnection *)convertFromConnectionModel:(BSConnectionModel *)connectionModel
{
	BSAPConnection *connection = [[BSAPConnection alloc] init];
	
	BSAPCCallback *callback = [[BSAPCCallback alloc] init];
	callback.method = connectionModel.callbacks.method;
	callback.dlr = connectionModel.callbacks.DLR;
	callback.mo	= connectionModel.callbacks.MO;
	connection.callbacks = callback;
	
	BSAPCWallet *wallet = [[BSAPCWallet alloc] init];
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
	connection.type = connectionModel.type;
	connection.whitelist = connectionModel.whitelist;
	
	return connection;
}

@end
