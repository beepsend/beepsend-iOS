//
//  BSConnectionModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSConnectionModel.h"

@interface BSConnectionModel ()

@property (nonatomic, strong, readwrite) NSString *connectionAPIToken;

@property (nonatomic, strong, readwrite) BSCallbacksModel *connectionCallbacks;

@property (nonatomic, strong, readwrite) NSString *connectionCustomer;
@property (nonatomic, strong, readwrite) NSString *connectionDescription;
@property (nonatomic, strong, readwrite) NSString *connectionID;
@property (nonatomic, strong, readwrite) NSString *connectionLabel;
@property (nonatomic, strong, readwrite) NSString *connectionSystemID;
@property (nonatomic, strong, readwrite) NSNumber *connectionTLVForMCCAndMNC;//Tag-Length-Value field for returning mcc and mnc in DLR.
@property (nonatomic, strong, readwrite) NSNumber *connectionType;//Type of connection, 1 for SMS connection or 2 for HLR connection.

@property (nonatomic, strong, readwrite) NSArray *connectionUsers;

@property (nonatomic, strong, readwrite) BSWalletModel *connectionWallet;

@property (nonatomic, strong, readwrite) NSString *connectionWhitelist;

@end

@implementation BSConnectionModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular connection"]) {
		
	}
	return self;
}

- (BSConnectionModel *)initConnectionWithID:(NSString *)cID
								   apiToken:(NSString *)cAPIToken
								  callbacks:(BSCallbacksModel *)cCallbacks
								   customer:(NSString *)cCustomer
								description:(NSString *)cDescription
									  label:(NSString *)cLabel
								   systemID:(NSString *)cSystemID
							tlvformccandmnc:(NSNumber *)cTlvformccandmnc
									   type:(NSNumber *)cType
									  users:(NSArray *)cUsers
									 wallet:(BSWalletModel *)cWallet
								  whitelist:(NSString *)cWhitelist
{
	if (self = [super initWithID:cID andTitle:cLabel]) {
		_connectionAPIToken = cAPIToken;
		_connectionCallbacks = cCallbacks;
		_connectionCustomer = cCustomer;
		_connectionDescription = cDescription;
		_connectionLabel = cLabel;
		_connectionSystemID = cSystemID;
		_connectionTLVForMCCAndMNC = cTlvformccandmnc;
		_connectionType = cType;
		_connectionUsers = cUsers;
		_connectionWallet = cWallet;
		_connectionWhitelist = cWhitelist;
	}
	return self;
}

@end
