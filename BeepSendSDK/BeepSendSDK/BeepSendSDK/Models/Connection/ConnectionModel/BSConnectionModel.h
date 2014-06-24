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

@interface BSConnectionModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *apiToken;

@property (nonatomic, strong, readonly) BSCallbacksModel *callbacks;

@property (nonatomic, strong, readonly) NSString *customer;
@property (nonatomic, strong, readonly) NSString *description;
@property (nonatomic, strong, readonly) NSString *label;
@property (nonatomic, strong, readonly) NSString *systemID;
@property (nonatomic, strong, readonly) NSNumber *TLVForMCCAndMNC;//Tag-Length-Value field for returning mcc and mnc in DLR.
@property (nonatomic, strong, readonly) NSNumber *type;//Type of connection, 1 for SMS connection or 2 for HLR connection.

@property (nonatomic, strong, readonly) NSArray *users;

@property (nonatomic, strong, readonly) BSWalletModel *wallet;

@property (nonatomic, strong, readonly) NSString *whitelist;

- (BSConnectionModel *)initConnectionWithID:(NSString *)cID;

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
								  whitelist:(NSString *)cWhitelist;

- (BSConnectionModel *)initWithConnectionModel:(BSConnectionModel *)connectionModel
								  withNewToken:(NSString *)newToken;

- (BSConnectionModel *)initConnectionWithID:(NSString *)cID
									  label:(NSString *)cLabel
								   systemID:(NSString *)cSystemID
									   type:(NSNumber *)cType;

@end
