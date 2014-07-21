//
//  BSWalletModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSEmail;

@interface BSWallet : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *walletID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *balance;
@property (nonatomic, strong) NSNumber *minimumBalanceForNotification;
@property (nonatomic, strong, readonly) NSArray *connections;
@property (nonatomic, strong, readonly) NSArray *users;

- (BSWallet *)initWalletWithID:(NSString *)wID
						 named:(NSString *)wName
					   balance:(NSNumber *)wBalance
				minimumBalance:(NSNumber *)wMinBalance
				   connections:(NSArray *)wConnections
						 users:(NSArray *)wUsers;

- (BSWallet *)initWalletWithID:(NSString *)wID
						  name:(NSString *)wName
					   balance:(NSNumber *)wBalance;

- (BSWallet *)initWalletWithName:(NSString *)wName
						   limit:(NSNumber *)wLimit;

- (void)updateWallet;

- (void)getTransactionLogForNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *log))block;
- (void)setMaximumLogCount:(NSNumber *)logCount; //Default 50. Maximum 200.

- (void)transferFunds:(NSNumber *)funds toWallet:(BSWallet *)wallet;
- (void)transferFunds:(NSNumber *)funds fromWallet:(BSWallet *)wallet;

- (void)getEmailsOnCompletion:(void(^)(NSArray *emails))block;
- (void)addEmail:(NSString *)email;
- (void)removeEmail:(BSEmail *)email;

@end
