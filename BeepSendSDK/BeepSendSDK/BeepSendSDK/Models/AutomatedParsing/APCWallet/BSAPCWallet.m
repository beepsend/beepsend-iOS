//
//  APCWallet.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPCWallet.h"

#import "BSWalletModel.h"

@implementation BSAPCWallet

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSWalletModel alloc] initWalletWithID:_id name:_name?_name:@"" balance:_balance?_balance:@0];
}

@end
