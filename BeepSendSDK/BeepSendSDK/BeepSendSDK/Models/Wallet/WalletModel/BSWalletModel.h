//
//  BSWalletModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSWalletModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *balance;
@property (nonatomic, strong, readonly) NSNumber *minimumBalanceForNotification;
@property (nonatomic, strong, readonly) NSArray *connections;
@property (nonatomic, strong, readonly) NSArray *users;

- (BSWalletModel *)initWalletWithID:(NSString *)wID
							  named:(NSString *)wName
							balance:(NSNumber *)wBalance
					 minimumBalance:(NSNumber *)wMinBalance
						connections:(NSArray *)wConnections
							  users:(NSArray *)wUsers;

- (BSWalletModel *)initWalletWithID:(NSString *)wID
							   name:(NSString *)wName
							balance:(NSNumber *)wBalance;

@end
