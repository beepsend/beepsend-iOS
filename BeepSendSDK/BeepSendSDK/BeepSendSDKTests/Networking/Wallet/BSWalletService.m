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
	[super executeGETForMethod:[BSAPIConfiguration wallets]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPWallet *wallet in [BSAPWallet arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[wallet convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getWalletDetailsForID:(NSString *)walletID withCompletionBlock:(void(^)(BSWallet *wallet, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration walletsForID:walletID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {

						  block([[BSAPWallet classFromDict:response] convertToModel], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)updateWallet:(BSWallet *)wallet withName:(NSString *)wName notifyLimit:(NSNumber *)wLimit withCompletionBlock:(void(^)(BSWallet *wallet, NSArray *errors))block
{
	NSDictionary *parameters = [[BSAPWallet convertFromWalletModel:[[BSWallet alloc] initWalletWithName:wName limit:wLimit]] dictFromClass];
	
	[super executePUTForMethod:[BSAPIConfiguration walletsForID:wallet.objectID]
				withParameters:parameters
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPWallet classFromDict:response] convertToModel], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getEmailsForWallet:(BSWallet *)wallet withCompletionBlock:(void(^)(NSArray *emails, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration walletsEmailsForID:wallet.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPEmail *mail in [BSAPEmail arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[mail convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getEmailForWallet:(BSWallet *)wallet andEmailID:(NSString *)emailID withCompletionBlock:(void(^)(BSEmail *email, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration walletsEmailsForWalletID:wallet.objectID andEmailID:emailID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPEmail classFromDict:response] convertToModel], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)addEmail:(NSString *)email toWallet:(BSWallet *)wallet withCompletionBlock:(void(^)(BSEmail *email, NSArray *errors))block
{
	[super executePOSTForMethod:[BSAPIConfiguration walletsEmailsForID:wallet.objectID]
				withParameters:[[BSAPEmail convertFromEmailModel:[[BSEmail alloc] initEmailWithAddress:email]] dictFromClass]
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPEmail classFromDict:response] convertToModel], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)deleteEmailInWallet:(BSWallet *)wallet email:(BSEmail *)email withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	[super executeDELETEForMethod:[BSAPIConfiguration walletsEmailsForWalletID:wallet.objectID andEmailID:email.objectID]
				   withParameters:@{}
					 onCompletion:^(id response, id error) {
					   
						 if (!error) {
						   
							 block(YES, nil);
						 }
						 else {

							 block(NO, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
						 }
					 }];
}

- (void)getTransactionLogForWallet:(BSWallet *)wallet since:(NSString *)sinceID max:(NSString *)maxID count:(NSNumber *)count withCompletionBlock:(void(^)(NSArray *log, NSArray *errors))block
{
	BSAPWalletRequest *wRequest = [[BSAPWalletRequest alloc] init];
	wRequest.since_id = sinceID;
	wRequest.max_id = maxID;
	wRequest.count = count;
	
	[super executeGETForMethod:[BSAPIConfiguration walletsTransactionForID:wallet.objectID]
				withParameters:[wRequest dictFromClass]
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPTransactionLog *log in [BSAPTransactionLog arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[log convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)transferFunds:(NSNumber *)ammount fromWallet:(BSWallet *)wallet1 toWallet:(BSWallet *)wallet2 withCompletionBlock:(void(^)(BSTransfer *transfer, NSArray *errors))block
{
	[super executePOSTForMethod:[BSAPIConfiguration walletsTransferFundsFromWallet:wallet1.objectID toWallet:wallet2.objectID]
				 withParameters:@{@"amount" : ammount}
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   
						   block([[BSAPTransfer classFromDict:response] convertToModel], nil);
					   }
					   else {

						   block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					   }
				   }];
}

@end
