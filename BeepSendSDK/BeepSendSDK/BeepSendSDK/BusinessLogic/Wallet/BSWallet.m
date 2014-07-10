//
//  BSWalletModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSWallet.h"

@interface BSWallet ()

@property (nonatomic, strong, readwrite) NSString *walletID;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSNumber *balance;
@property (nonatomic, strong, readwrite) NSNumber *minimumBalanceForNotification;
@property (nonatomic, strong, readwrite) NSArray *connections;
@property (nonatomic, strong, readwrite) NSArray *users;

@end

@implementation BSWallet

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular wallet"]) {
		
	}
	return self;
}

- (BSWallet *)initWalletWithID:(NSString *)wID
						 named:(NSString *)wName
					   balance:(NSNumber *)wBalance
				minimumBalance:(NSNumber *)wMinBalance
				   connections:(NSArray *)wConnections
						 users:(NSArray *)wUsers
{
	if (self = [super initWithID:wID andTitle:wName]) {
		_walletID = wID;
		_name = wName;
		_balance = wBalance;
		_minimumBalanceForNotification = wMinBalance;
		_connections = wConnections;
		_users = wUsers;
	}
	return self;
}

- (BSWallet *)initWalletWithID:(NSString *)wID
						  name:(NSString *)wName
					   balance:(NSNumber *)wBalance
{
	if (self = [super initWithID:wID andTitle:wName]) {
		_walletID = wID;
		_name = wName;
		_balance = wBalance;
	}
	return self;
}

- (BSWallet *)initWalletWithName:(NSString *)wName
						   limit:(NSNumber *)wLimit
{
	if (self = [super initWithID:@"0" andTitle:wName]) {
		_name = wName;
		_minimumBalanceForNotification = wLimit;
	}
	return self;
}

@end
