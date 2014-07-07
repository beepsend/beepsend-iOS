//
//  BSConnectionModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSConnectionModel.h"

@interface BSConnectionModel ()

@property (nonatomic, strong, readwrite) NSString *cAPIToken;

@property (nonatomic, strong, readwrite) BSCallbacksModel *callbacks;

@property (nonatomic, strong, readwrite) NSString *customer;
@property (nonatomic, strong, readwrite) NSString *description;
@property (nonatomic, strong, readwrite) NSString *label;
@property (nonatomic, strong, readwrite) NSString *systemID;
@property (nonatomic, strong, readwrite) NSNumber *cTLVForMCCAndMNC;//Tag-Length-Value field for returning mcc and mnc in DLR.
@property (nonatomic, assign, readwrite) BSConnectionType type;//Type of connection, 1 for SMS connection or 2 for HLR connection.

@property (nonatomic, strong, readwrite) NSArray *users;

@property (nonatomic, strong, readwrite) BSWalletModel *wallet;

@property (nonatomic, strong, readwrite) NSString *whitelist;

@property (nonatomic, strong, readwrite) NSString *password;

@end

@implementation BSConnectionModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular connection"]) {
		
	}
	return self;
}

- (BSConnectionModel *)initConnectionWithID:(NSString *)cID
{
	if (self = [super initWithID:cID andTitle:@"ID Connection"]) {
		
	}
	return self;
}

- (BSConnectionModel *)initConnectionWithID:(NSString *)cID
								   apiToken:(NSString *)cAPIToken
								  callbacks:(BSCallbacksModel *)cCallbacks
								   customer:(NSString *)cCustomer
								description:(NSString *)cDescription
									  label:(NSString *)cLabel
								   systemID:(NSString *)cSystemID
							tlvformccandmnc:(NSNumber *)cTlvformccandmnc
									   type:(BSConnectionType)cType
									  users:(NSArray *)cUsers
									 wallet:(BSWalletModel *)cWallet
								  whitelist:(NSString *)cWhitelist
								   password:(NSString *)password
{
	if (self = [super initWithID:cID andTitle:cLabel]) {
		_apiToken = cAPIToken;
		_callbacks = cCallbacks;
		_customer = cCustomer;
		_description = cDescription;
		_label = cLabel;
		_systemID = cSystemID;
		_TLVForMCCAndMNC = cTlvformccandmnc;
		_type = cType;
		_users = cUsers;
		_wallet = cWallet;
		_whitelist = cWhitelist;
		_password = password;
	}
	return self;
}

- (BSConnectionModel *)initWithConnectionModel:(BSConnectionModel *)connectionModel withNewToken:(NSString *)newToken
{
	if (self = [super initWithID:connectionModel.objectID andTitle:connectionModel.label]) {
		_apiToken = newToken;
		_callbacks = connectionModel.callbacks;
		_customer = connectionModel.customer;
		_description = connectionModel.description;
		_label = connectionModel.label;
		_systemID = connectionModel.systemID;
		_TLVForMCCAndMNC = connectionModel.TLVForMCCAndMNC;
		_type = connectionModel.type;
		_users = connectionModel.users;
		_wallet = connectionModel.wallet;
		_whitelist = connectionModel.whitelist;
		_password = connectionModel.password;
	}
	return self;
}

- (BSConnectionModel *)initWithConnectionModel:(BSConnectionModel *)connectionModel withNewPassword:(NSString *)newPassword
{
	if (self = [super initWithID:connectionModel.objectID andTitle:connectionModel.label]) {
		_apiToken = connectionModel.apiToken;
		_callbacks = connectionModel.callbacks;
		_customer = connectionModel.customer;
		_description = connectionModel.description;
		_label = connectionModel.label;
		_systemID = connectionModel.systemID;
		_TLVForMCCAndMNC = connectionModel.TLVForMCCAndMNC;
		_type = connectionModel.type;
		_users = connectionModel.users;
		_wallet = connectionModel.wallet;
		_whitelist = connectionModel.whitelist;
		_password = newPassword;
	}
	return self;
}

- (BSConnectionModel *)initConnectionWithID:(NSString *)cID
									  label:(NSString *)cLabel
								   systemID:(NSString *)cSystemID
									   type:(BSConnectionType)cType
{
	if (self = [super initWithID:cID andTitle:cLabel]) {
		_label = cLabel;
		_systemID = cSystemID;
		_type = cType;

	}
	return self;
}

@end
