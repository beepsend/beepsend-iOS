//
//  BSWalletService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSWalletModel.h"

@interface BSWalletService : BSBaseService

- (void)getAllWalletsWithCompletionBlock:(void(^)(NSArray *wallets, id error))block;

- (void)getWalletDetailsForID:(NSString *)walletID withCompletionBlock:(void(^)(BSWalletModel *wallet, id error))block;

@end
