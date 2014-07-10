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

- (void)getAllWalletsWithCompletionBlock:(void(^)(NSArray *wallets, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration wallets]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPWallet *wallet in [BSAPWallet arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[wallet convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getWalletDetailsForID:(NSString *)walletID withCompletionBlock:(void(^)(BSWallet *wallet, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration walletsForID:walletID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {

						  block([[BSAPWallet classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)updateWallet:(BSWallet *)wallet withName:(NSString *)wName notifyLimit:(NSNumber *)wLimit withCompletionBlock:(void(^)(BSWallet *wallet, id error))block
{
	NSDictionary *parameters = [[BSAPWallet convertFromWalletModel:[[BSWallet alloc] initWalletWithName:wName limit:wLimit]] dictFromClass];
	
	[super executePUTForMethod:[BSAPIConfiguration walletsForID:wallet.objectID]
				withParameters:parameters
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPWallet classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getEmailsForWallet:(BSWallet *)wallet withCompletionBlock:(void(^)(NSArray *emails, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration walletsEmailsForID:wallet.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPEmail *mail in [BSAPEmail arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[mail convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getEmailForWallet:(BSWallet *)wallet andEmailID:(NSString *)emailID withCompletionBlock:(void(^)(BSEmail *email, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration walletsEmailsForWalletID:wallet.objectID andEmailID:emailID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPEmail classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)addEmail:(NSString *)email toWallet:(BSWallet *)wallet withCompletionBlock:(void(^)(BSEmail *email, id error))block
{
	[super executePOSTForMethod:[BSAPIConfiguration walletsEmailsForID:wallet.objectID]
				withParameters:[[BSAPEmail convertFromEmailModel:[[BSEmail alloc] initEmailWithAddress:email]] dictFromClass]
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPEmail classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)deleteEmailInWallet:(BSWallet *)wallet email:(BSEmail *)email withCompletionBlock:(void(^)(BOOL success, id error))block
{
	[super executeDELETEForMethod:[BSAPIConfiguration walletsEmailsForWalletID:wallet.objectID andEmailID:email.objectID]
				   withParameters:@{}
					 onCompletion:^(id response, id error) {
					   
						 if (!error) {
						   
							 block(YES, error);
						 }
						 else {
							 //TODO: Create error handling
							 block(NO, response);
						 }
					 }];
}

- (void)getTransactionLogForWallet:(BSWallet *)wallet withCompletionBlock:(void(^)(NSArray *log, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration walletsTransactionForID:wallet.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPTransactionLog *log in [BSAPTransactionLog arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[log convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)transferFunds:(NSNumber *)ammount fromWallet:(BSWallet *)wallet1 toWallet:(BSWallet *)wallet2 withCompletionBlock:(void(^)(BSTransfer *transfer, id error))block
{
	[super executePOSTForMethod:[BSAPIConfiguration walletsTransferFundsFromWallet:wallet1.objectID toWallet:wallet2.objectID]
				 withParameters:@{@"amount" : ammount}
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   
						   block([[BSAPTransfer classFromDict:response] convertToModel], error);
					   }
					   else {
						   //TODO: Create error handling
						   block(nil, response);
					   }
				   }];
}

@end
