//
//  BSConnection.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSStructs.h"

#import "BSPricelist.h"

@class BSMessage;
@class BSWallet;

@interface BSConnection : NSObject

//Connection ID
@property (nonatomic, strong, readonly) NSString *connectionID;
//Connection type: HLR connection or SMS connection
@property (nonatomic, assign, readonly) BSConnectionType type;

//Users who have privileges to read/write connection
@property (nonatomic, strong, readonly) NSArray *users;
//Wallet that belongs to connection
@property (nonatomic, strong, readonly) BSWallet *wallet;

//Properties that can be edited by user
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *systemID;//Login name

//Specifies if connection is default
@property (nonatomic, assign) BOOL defaultConnection;

//Connection API token
@property (nonatomic, strong, readonly) NSString *apiToken;

//Callback URLs
@property (nonatomic, strong) NSString *dlrCallback;

//@property (nonatomic, strong, readonly) BSCallbacksModel *callbacks;
//@property (nonatomic, strong, readonly) NSString *customer;
//@property (nonatomic, strong, readonly) NSNumber *TLVForMCCAndMNC;//Tag-Length-Value field for returning mcc and mnc in DLR.
//@property (nonatomic, strong, readonly) NSString *whitelist;
//@property (nonatomic, strong, readonly) NSString *password;

//Initiate connection with API token
- (BSConnection *)init;

//Accessible only if User is initiated with apiToken
- (BSConnection *)initDefaultConnection;

//After made changes it is necessary to call method updateConnection
- (void)updateConnection;

//If API token is compromised use this method for token reset
- (void)resetConnectionToken;

//Returns pricelists
- (void)getPricelistsOnCompletion:(void(^)(NSArray *pricelists))block;

//Returns current pricelists
- (void)getCurrentPricelistOnCompletion:(void(^)(BSPricelist *pricelist))block;

//Send message
- (void)sendSMS:(BSMessage *)message;

//Send messages
- (void)sendMultipleSMS:(NSArray *)messages;

//Validate SMS
- (void)validateSMS:(BSMessage *)message;

//Get sms details
- (void)getDetailsForSMS:(BSMessage *)message;

@end
