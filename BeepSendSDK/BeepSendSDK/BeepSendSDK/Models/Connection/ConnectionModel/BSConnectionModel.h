//
//  BSConnectionModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSCallbacksModel.h"
#import "BSUserModel.h"
#import "BSWalletModel.h"

@interface BSConnectionModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *connectionAPIToken;

@property (nonatomic, strong, readonly) BSCallbacksModel *connectionCallbacks;

@property (nonatomic, strong, readonly) NSString *connectionCustomer;
@property (nonatomic, strong, readonly) NSString *connectionDescription;
@property (nonatomic, strong, readonly) NSString *connectionID;
@property (nonatomic, strong, readonly) NSString *connectionLabel;
@property (nonatomic, strong, readonly) NSString *connectionSystemID;
@property (nonatomic, strong, readonly) NSNumber *connectionTLVForMCCAndMNC;//Tag-Length-Value field for returning mcc and mnc in DLR.
@property (nonatomic, strong, readonly) NSNumber *connectionType;//Type of connection, 1 for SMS connection or 2 for HLR connection.

@property (nonatomic, strong, readonly) NSArray *connectionUsers;

@property (nonatomic, strong, readonly) BSWalletModel *connectionWallet;

@property (nonatomic, strong, readonly) NSString *connectionWhitelist;

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

@end
