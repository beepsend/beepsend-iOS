//
//  BSWalletService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSWalletService.h"

#import "BSAPIConfiguration.h"

#import "BSAPWallet.h"
#import "BSAPEmail.h"
#import "BSAPTransactionLog.h"
#import "BSAPTransfer.h"
#import "BSAPWalletRequest.h"

@implementation BSWalletService

#pragma mark - Initialization

+ (instancetype)sharedService
{
	static id singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[[self class] alloc] init];
	});
	return singleton;
}

#pragma mark - Public methods

- (void)getAllWalletsWithCompletionBlock:(void(^)(NSArray *wallets, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPWallet *wallet in [BSAPWallet arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@1,@"balance":@47.60858,@"name":@"Beepsend wallet",@"notify_limit":@0,@"connections":@[@{@"system_id":@"beepsend",@"name":@"beepsend-connection",@"id":@1}],@"users":@[@{@"email":@"user@beepsend.se",@"name":@"Beep Beepson",@"id":@1}]},@{@"id":@2,@"balance":@47.60858,@"name":@"Beepsend wallet 2",@"notify_limit":@0,@"connections":@[@{@"system_id":@"beepsend",@"name":@"beepsend-connection",@"id":@1}],@"users":@[@{@"email":@"user@beepsend.se",@"name":@"Beep Beepson",@"id":@1}]}]]) {
	  [mArr addObject:[wallet convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getWalletDetailsForID:(NSString *)walletID withCompletionBlock:(void(^)(BSWallet *wallet, NSArray *errors))block
{
	block([[BSAPWallet classFromDict:@{@"id":[NSNumber numberWithInteger:[walletID integerValue]],@"balance":@47.60858,@"name":@"Beepsend wallet",@"notify_limit":@0,@"connections":@[@{@"system_id":@"beepsend",@"name":@"beepsend-connection",@"id":@1}],@"users":@[@{@"email":@"user@beepsend.se",@"name":@"Beep Beepson",@"id":@1}]}] convertToModel], nil);
}

- (void)updateWallet:(BSWallet *)wallet withName:(NSString *)wName notifyLimit:(NSNumber *)wLimit withCompletionBlock:(void(^)(BSWallet *wallet, NSArray *errors))block
{
	wallet.name = wName;
	wallet.minimumBalanceForNotification = wLimit;
	
	block(wallet, nil);
}

- (void)getEmailsForWallet:(BSWallet *)wallet withCompletionBlock:(void(^)(NSArray *emails, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPEmail *mail in [BSAPEmail arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@1,@"email":@"mailman@beepsend.com"},@{@"id":@2,@"email":@"mailman2@beepsend.com"},@{@"id":@3,@"email":@"mailman3@beepsend.com"}]]) {
		[mArr addObject:[mail convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getEmailForWallet:(BSWallet *)wallet andEmailID:(NSString *)emailID withCompletionBlock:(void(^)(BSEmail *email, NSArray *errors))block
{
	block(@{@"id":[NSNumber numberWithInteger:[emailID integerValue]],@"email":@"mailman@beepsend.com"}, nil);
}

- (void)addEmail:(NSString *)email toWallet:(BSWallet *)wallet withCompletionBlock:(void(^)(BSEmail *email, NSArray *errors))block
{
	block(@{@"id":@1,@"email":email}, nil);
}

- (void)deleteEmailInWallet:(BSWallet *)wallet email:(BSEmail *)email withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	block(YES, nil);
}

- (void)getTransactionLogForWallet:(BSWallet *)wallet since:(NSString *)sinceID max:(NSString *)maxID count:(NSNumber *)count withCompletionBlock:(void(^)(NSArray *log, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPTransactionLog *log in [BSAPTransactionLog arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@20,@"timestamp":@1388669449,@"new_balance":@8085.56838,@"change":@200},@{@"id":@21,@"timestamp":@1388669500,@"new_balance":@80.56838,@"change":@200},@{@"id":@22,@"timestamp":@1388669700,@"new_balance":@808.56838,@"change":@200}]]) {
		[mArr addObject:[log convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)transferFunds:(NSNumber *)ammount fromWallet:(BSWallet *)wallet1 toWallet:(BSWallet *)wallet2 withCompletionBlock:(void(^)(BSTransfer *transfer, NSArray *errors))block
{
	block([[BSAPTransfer classFromDict:@{@"source_wallet":@{@"id":@1,@"name":@"wallet-1",@"balance":@273.45},@"target_wallet":@{@"id":@2,@"name":@"wallet-2",@"balance":@125},@"amount":@123.45}] convertToModel], nil);
}

@end
