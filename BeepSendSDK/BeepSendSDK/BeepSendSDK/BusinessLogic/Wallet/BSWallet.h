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

/** Wallet id.
 */
@property (nonatomic, strong, readonly) NSString *walletID;

/** Name of the wallet.
 */
@property (nonatomic, strong) NSString *name;

/** Current balance. In Euro (€).
 */
@property (nonatomic, strong, readonly) NSNumber *balance;

/** When balance is equal or below this value a notification 
	email will be sent to all listed users.
 */
@property (nonatomic, strong) NSNumber *minimumBalanceForNotification;

/** Linked connections.
 */
@property (nonatomic, strong, readonly) NSArray *connections;

/** Users which will receive warning notification when low balance.
 */
@property (nonatomic, strong, readonly) NSArray *users;

/** Init Pricelist with wallet ID, name, balance, min balance, connections, users
 
 @param wID - Wallet ID
 @param wName - Name
 @param wBalance - Balance
 @param wMinBalance - Minimum balance
 @param wConnections - Connections
 @param wUsers - Users
 
 @return Returns Wallet object
 */
- (BSWallet *)initWalletWithID:(NSString *)wID
						 named:(NSString *)wName
					   balance:(NSNumber *)wBalance
				minimumBalance:(NSNumber *)wMinBalance
				   connections:(NSArray *)wConnections
						 users:(NSArray *)wUsers;

/** Init Pricelist with wallet ID, name, balance
 
 @param wID - Wallet ID
 @param wName - Name
 @param wBalance - Balance
 
 @return Returns Wallet object
 */
- (BSWallet *)initWalletWithID:(NSString *)wID
						  name:(NSString *)wName
					   balance:(NSNumber *)wBalance;

/** Init Pricelist with wallet name, limit
 
 @param wName - Name
 @param wLimit - Balance
 
 @return Returns Wallet object
 */
- (BSWallet *)initWalletWithName:(NSString *)wName
						   limit:(NSNumber *)wLimit;

/** If changes were made to wallet use update method to save changes.
 */
- (void)updateWallet;

/** Fetch transaction log for wallet
 
 @param nextPage - If set to YES then new page with resulets will be loaded
 @param block - Block that will return array of logs
 */
- (void)getTransactionLogForNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *log))block;

/** Set how many logs you wish to receive per page
 
 @param logCount - Default 50. Maximum 200.
 */
- (void)setMaximumLogCount:(NSNumber *)logCount;

/** Method for transfering funds from current wallet
 
 @param funds - How much money you wish to transfer
 @param wallet - Wallet to which you want to transfer money
 */
- (void)transferFunds:(NSNumber *)funds toWallet:(BSWallet *)wallet;

/** Method for transfering funds to current wallet
 
 @param funds - How much money you wish to transfer
 @param wallet - Wallet from which you want to transfer money
 */
- (void)transferFunds:(NSNumber *)funds fromWallet:(BSWallet *)wallet;

/** Method for fetching emails associated with wallet
 
 @param block - Block that will return array of emails
 */
- (void)getEmailsOnCompletion:(void(^)(NSArray *emails))block;

/** Adds new email to wallet email listing
 
 @param email - Email to add to wallet
 */
- (void)addEmail:(NSString *)email;

/** Method for removing email from wallet email listing
 
 @param email - Email to remove from wallet
 */
- (void)removeEmail:(BSEmail *)email;

@end
