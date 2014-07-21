//
//  BSTransferModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSTransfer.h"

#import "BSWallet.h"

@interface BSTransfer ()

@property (nonatomic, strong, readwrite) BSWallet *source;
@property (nonatomic, strong, readwrite) BSWallet *target;
@property (nonatomic, strong, readwrite) NSNumber *amount;

@end

@implementation BSTransfer

#pragma mark - Properties

- (NSNumber *)amount
{
	return _amount ? _amount : @0;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Transfer"]) {
		
	}
	return self;
}

- (BSTransfer *)initTransferWithSourceWallet:(BSWallet *)wallet1 destinationWallet:(BSWallet *)wallet2 withAmount:(NSNumber *)amount
{
	if (self = [super initWithID:@"0" andTitle:@"Transfer"]) {
		_source = wallet1;
		_target = wallet2;
		_amount = amount;
	}
	return self;
}

@end
