//
//  BSWalletModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSWallet.h"

#import "BSWalletService.h"

@interface BSWallet ()

@property (nonatomic, strong) NSArray *log;

@end

@implementation BSWallet

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular wallet"]) {
		_walletID = @"-1";
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
		_walletID = @"0";
		_name = wName;
		_minimumBalanceForNotification = wLimit;
	}
	return self;
}

#pragma mark - Public methods

- (void)updateWallet
{
	
}

- (void)getTransactionLogOnCompletion:(void(^)(NSArray *log))block
{
	if (_log) {
		block(_log);
	}
	
	[[BSWalletService sharedService] getTransactionLogForWallet:self withCompletionBlock:^(NSArray *log, id error) {
		_log = log;
		block(log);
	}];
}

- (void)transferFunds:(NSNumber *)funds toWallet:(BSWallet *)wallet
{
	[[BSWalletService sharedService] transferFunds:funds fromWallet:self toWallet:wallet withCompletionBlock:^(BSTransfer *transfer, id error) {
		
	}];
}

- (void)transferFunds:(NSNumber *)funds fromWallet:(BSWallet *)wallet
{
	[[BSWalletService sharedService] transferFunds:funds fromWallet:wallet toWallet:self withCompletionBlock:^(BSTransfer *transfer, id error) {
		
	}];
}

- (void)getEmailsOnCompletion:(void(^)(NSArray *emails))block
{
	[[BSWalletService sharedService] getEmailsForWallet:self withCompletionBlock:^(NSArray *emails, id error) {
		block(emails);
	}];
}

- (void)addEmail:(NSString *)email
{
	[[BSWalletService sharedService] addEmail:email toWallet:self withCompletionBlock:^(BSEmail *email, id error) {
		
	}];
}

- (void)removeEmail:(BSEmail *)email
{
	[[BSWalletService sharedService] deleteEmailInWallet:self email:email withCompletionBlock:^(BOOL success, id error) {
		
	}];
}

@end
