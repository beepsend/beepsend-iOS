//
//  BSWalletService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSWallet.h"
#import "BSEmail.h"
#import "BSTransfer.h"
#import "BSLog.h"
#import "BSError.h"

@interface BSWalletService : BSBaseService

- (void)getAllWalletsWithCompletionBlock:(void(^)(NSArray *wallets, NSArray *errors))block;

- (void)getWalletDetailsForID:(NSString *)walletID withCompletionBlock:(void(^)(BSWallet *wallet, NSArray *errors))block;

- (void)updateWallet:(BSWallet *)wallet withName:(NSString *)wName notifyLimit:(NSNumber *)wLimit withCompletionBlock:(void(^)(BSWallet *wallet, NSArray *errors))block;

- (void)getEmailsForWallet:(BSWallet *)wallet withCompletionBlock:(void(^)(NSArray *emails, NSArray *errors))block;
- (void)getEmailForWallet:(BSWallet *)wallet andEmailID:(NSString *)emailID withCompletionBlock:(void(^)(BSEmail *email, NSArray *errors))block;
- (void)addEmail:(NSString *)email toWallet:(BSWallet *)wallet withCompletionBlock:(void(^)(BSEmail *email, NSArray *errors))block;
- (void)deleteEmailInWallet:(BSWallet *)wallet email:(BSEmail *)email withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block;

- (void)getTransactionLogForWallet:(BSWallet *)wallet since:(NSString *)sinceID max:(NSString *)maxID count:(NSNumber *)count withCompletionBlock:(void(^)(NSArray *log, NSArray *errors))block;
- (void)transferFunds:(NSNumber *)ammount fromWallet:(BSWallet *)wallet1 toWallet:(BSWallet *)wallet2 withCompletionBlock:(void(^)(BSTransfer *transfer, NSArray *errors))block;

@end
