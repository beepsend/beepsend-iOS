//
//  BSWalletService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSWalletModel.h"
#import "BSEmailModel.h"

@interface BSWalletService : BSBaseService

- (void)getAllWalletsWithCompletionBlock:(void(^)(NSArray *wallets, id error))block;

- (void)getWalletDetailsForID:(NSString *)walletID withCompletionBlock:(void(^)(BSWalletModel *wallet, id error))block;

- (void)updateWallet:(BSWalletModel *)wallet withName:(NSString *)wName notifyLimit:(NSNumber *)wLimit withCompletionBlock:(void(^)(BSWalletModel *wallet, id error))block;

- (void)getEmailsForWallet:(BSWalletModel *)wallet withCompletionBlock:(void(^)(NSArray *emails, id error))block;
- (void)getEmailForWallet:(BSWalletModel *)wallet andEmailID:(NSString *)emailID withCompletionBlock:(void(^)(BSEmailModel *email, id error))block;
- (void)addEmail:(NSString *)email toWallet:(BSWalletModel *)wallet withCompletionBlock:(void(^)(BSEmailModel *email, id error))block;
- (void)deleteEmailInWallet:(BSWalletModel *)wallet email:(BSEmailModel *)email withCompletionBlock:(void(^)(BOOL success, id error))block;

@end
