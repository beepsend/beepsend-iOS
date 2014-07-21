//
//  BSMCCMNCModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSMCCMNC.h"

@interface BSMCCMNC ()

@property (nonatomic, strong, readwrite) NSNumber *mnc;
@property (nonatomic, strong, readwrite) NSNumber *mcc;

@end

@implementation BSMCCMNC

#pragma mark - Properties

- (NSNumber *)mnc
{
	return _mnc ? _mnc : @0;
}

- (NSNumber *)mcc
{
	return _mcc ? _mcc : @0;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular MCC - MNC"]) {
		
	}
	return self;
}

- (BSMCCMNC *)initWithMNC:(NSNumber *)mnc
						andMCC:(NSNumber *)mcc
{
	if (self = [super initWithID:@"0" andTitle:@"MCC - MNC"]) {
		_mnc = mnc;
		_mcc = mcc;
	}
	return self;
}

@end
