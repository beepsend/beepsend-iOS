//
//  BSWalletModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSWalletModel.h"

@interface BSWalletModel ()

@property (nonatomic, strong, readwrite) NSString *walletName;
@property (nonatomic, strong, readwrite) NSNumber *walletBalance;

@end

@implementation BSWalletModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular wallet"]) {
		
	}
	return self;
}

- (BSWalletModel *)initWalletWithID:(NSString *)wID
							   name:(NSString *)wName
							balance:(NSNumber *)wBalance
{
	if (self = [super initWithID:wID andTitle:wName]) {
		_walletName = wName;
		_walletBalance = wBalance;
	}
	return self;
}

@end
