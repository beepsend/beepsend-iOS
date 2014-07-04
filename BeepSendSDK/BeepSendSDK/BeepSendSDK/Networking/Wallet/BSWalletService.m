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

- (void)getWalletDetailsForID:(NSString *)walletID withCompletionBlock:(void(^)(BSWalletModel *wallet, id error))block
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

- (void)updateWallet:(BSWalletModel *)wallet withName:(NSString *)wName notifyLimit:(NSNumber *)wLimit withCompletionBlock:(void(^)(BSWalletModel *wallet, id error))block
{
	NSDictionary *parameters = [[BSAPWallet convertFromWalletModel:[[BSWalletModel alloc] initWalletWithName:wName limit:wLimit]] dictFromClass];
	
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

@end
