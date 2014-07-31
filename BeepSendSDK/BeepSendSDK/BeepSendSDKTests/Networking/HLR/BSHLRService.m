//
//  BSHLRService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSHLRService.h"

#import "BSAPIConfiguration.h"

#import "BSAPHLR.h"
#import "BSAPHLRValidateResponse.h"

@implementation BSHLRService

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

- (void)doImmediateHLRForNumber:(NSString *)number
				 withConnection:(BSConnection *)connection
			withCompletionBlock:(void(^)(BSHLR *hlr, NSArray *errors))block
{
	BSHLR *hlr = [[BSAPHLR classFromDict:@{@"id":@"08087780013866630151559112345",@"timestamps":@{@"hlr":@{@"in":@1383225355,@"delivered":@1383225359},@"dlr_out":@1383225359},@"dlr":@{@"status":@"DELIVRD",@"error":@0},@"mccmnc":@{@"mcc":@"402",@"mnc":@"02"},@"imsi":@"423900000000000000000",@"ported":@YES,@"roaming":@YES,@"prefix":@{@"mcc":@"402",@"mnc":@"02"}}] convertToModel];

	block(hlr, nil);
}

- (void)validateHLRForNumber:(NSString *)number
			  withConnection:(BSConnection *)connection
		 withCompletionBlock:(void(^)(BSHLR *response, NSArray *errors))block
{
	BSHLR *hlr = [[BSAPHLRValidateResponse classFromDict:@{@"id":[NSNull null],@"batch_label":@"My custom name for my batch",@"to":@"502040",@"from":@"lolboll",@"errors":[NSNull null]}] convertToModel];
	block(hlr, nil);
}

@end
