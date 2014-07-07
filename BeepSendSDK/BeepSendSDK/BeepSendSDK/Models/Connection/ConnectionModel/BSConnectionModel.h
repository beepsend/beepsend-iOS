//
//  BSConnectionModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSCallbacksModel.h"
#import "BSWalletModel.h"

typedef enum {
	BSConnectionTypeSMS = 1,
	BSConnectionTypeHLR = 2
} BSConnectionType;

@interface BSConnectionModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *apiToken;

@property (nonatomic, strong, readonly) BSCallbacksModel *callbacks;

@property (nonatomic, strong, readonly) NSString *customer;
@property (nonatomic, strong, readonly) NSString *description;
@property (nonatomic, strong, readonly) NSString *label;
@property (nonatomic, strong, readonly) NSString *systemID;
@property (nonatomic, strong, readonly) NSNumber *TLVForMCCAndMNC;//Tag-Length-Value field for returning mcc and mnc in DLR.
@property (nonatomic, assign, readonly) BSConnectionType type;//Type of connection, 1 for SMS connection or 2 for HLR connection.

@property (nonatomic, strong, readonly) NSArray *users;

@property (nonatomic, strong, readonly) BSWalletModel *wallet;

@property (nonatomic, strong, readonly) NSString *whitelist;

@property (nonatomic, strong, readonly) NSString *password;

- (BSConnectionModel *)initConnectionWithID:(NSString *)cID;

- (BSConnectionModel *)initConnectionWithID:(NSString *)cID
								   apiToken:(NSString *)cAPIToken
								  callbacks:(BSCallbacksModel *)cCallbacks
								   customer:(NSString *)cCustomer
								description:(NSString *)cDescription
									  label:(NSString *)cLabel
								   systemID:(NSString *)cSystemID
							tlvformccandmnc:(NSNumber *)cTlvformccandmnc
									   type:(BSConnectionType)cType
									  users:(NSArray *)cUsers
									 wallet:(BSWalletModel *)cWallet
								  whitelist:(NSString *)cWhitelist
								   password:(NSString *)password;

- (BSConnectionModel *)initWithConnectionModel:(BSConnectionModel *)connectionModel
								  withNewToken:(NSString *)newToken;
- (BSConnectionModel *)initWithConnectionModel:(BSConnectionModel *)connectionModel withNewPassword:(NSString *)newPassword;

- (BSConnectionModel *)initConnectionWithID:(NSString *)cID
									  label:(NSString *)cLabel
								   systemID:(NSString *)cSystemID
									   type:(BSConnectionType)cType;

@end
