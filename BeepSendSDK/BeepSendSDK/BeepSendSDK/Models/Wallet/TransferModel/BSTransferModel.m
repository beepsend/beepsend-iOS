//
//  BSTransferModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSTransferModel.h"

#import "BSWalletModel.h"

@interface BSTransferModel ()

@property (nonatomic, strong, readwrite) BSWalletModel *source;
@property (nonatomic, strong, readwrite) BSWalletModel *target;
@property (nonatomic, strong, readwrite) NSNumber *amount;

@end

@implementation BSTransferModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Transfer"]) {
		
	}
	return self;
}

- (BSTransferModel *)initTransferWithSourceWallet:(BSWalletModel *)wallet1 destinationWallet:(BSWalletModel *)wallet2 withAmount:(NSNumber *)amount
{
	if (self = [super initWithID:@"0" andTitle:@"Transfer"]) {
		_source = wallet1;
		_target = wallet2;
		_amount = amount;
	}
	return self;
}

@end
