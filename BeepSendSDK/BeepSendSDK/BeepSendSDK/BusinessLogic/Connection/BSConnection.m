//
//  BSConnection.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSConnection.h"

#import "BSInputData.h"

#import "BSTestSemaphor.h"

#import "BSConnectionsService.h"
#import "BSPricelistService.h"
#import "BSSMSService.h"

#import "BSUser.h"
#import "BSMessage.h"

@interface BSConnection ()

@property (nonatomic, strong) BSConnection *connectionModel;

@property (nonatomic, strong) BSPricelist *currentPricelist;
@property (nonatomic, strong) NSArray *pricelists;

@end

@implementation BSConnection

#pragma mark - Properties

- (NSString *)label {
	return _connectionModel ? _connectionModel.label : _label;
}

- (NSString *)description {
	return _connectionModel ? _connectionModel.description : _description;
}

- (NSString *)systemID {
	return _connectionModel ? _connectionModel.systemID : _systemID;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular connection"]) {
		_connectionID = @"-1";
	}
	return self;
}

- (BSConnection *)initConnectionWithID:(NSString *)cID
{
	if (self = [super initWithID:cID andTitle:@"Connection"]) {
		_connectionID = cID;
	}
	return self;
}

- (BSConnection *)initConnectionWithID:(NSString *)cID
								   apiToken:(NSString *)cAPIToken
								  callbacks:(BSCallbacks *)cCallbacks
								   customer:(NSString *)cCustomer
								description:(NSString *)cDescription
									  label:(NSString *)cLabel
								   systemID:(NSString *)cSystemID
							tlvformccandmnc:(NSNumber *)cTlvformccandmnc
									   type:(BSConnectionType)cType
									  users:(NSArray *)cUsers
									 wallet:(BSWallet *)cWallet
								  whitelist:(NSArray *)cWhitelist
								   password:(NSString *)password
{
	if (self = [super initWithID:cID andTitle:cLabel]) {
		_connectionID = cID;
		_apiToken = cAPIToken;
		_callbackURLs = cCallbacks;
		_customer = cCustomer;
		_description = cDescription;
		_label = cLabel;
		_systemID = cSystemID;
		_TLVForMCCAndMNC = cTlvformccandmnc;
		_type = cType;
		_users = cUsers;
		_wallet = cWallet;
		_whitelist = cWhitelist;
		_password = password;
	}
	return self;
}

- (BSConnection *)initWithConnectionModel:(BSConnection *)connectionModel withNewToken:(NSString *)newToken
{
	if (self = [super initWithID:connectionModel.objectID andTitle:connectionModel.label]) {
		_connectionID = connectionModel.objectID;
		_apiToken = newToken;
		_callbackURLs = connectionModel.callbackURLs;
		_customer = connectionModel.customer;
		_description = connectionModel.description;
		_label = connectionModel.label;
		_systemID = connectionModel.systemID;
		_TLVForMCCAndMNC = connectionModel.TLVForMCCAndMNC;
		_type = connectionModel.type;
		_users = connectionModel.users;
		_wallet = connectionModel.wallet;
		_whitelist = connectionModel.whitelist;
		_password = connectionModel.password;
	}
	return self;
}

- (BSConnection *)initWithConnectionModel:(BSConnection *)connectionModel withNewPassword:(NSString *)newPassword
{
	if (self = [super initWithID:connectionModel.objectID andTitle:connectionModel.label]) {
		_connectionID = connectionModel.objectID;
		_apiToken = connectionModel.apiToken;
		_callbackURLs = connectionModel.callbackURLs;
		_customer = connectionModel.customer;
		_description = connectionModel.description;
		_label = connectionModel.label;
		_systemID = connectionModel.systemID;
		_TLVForMCCAndMNC = connectionModel.TLVForMCCAndMNC;
		_type = connectionModel.type;
		_users = connectionModel.users;
		_wallet = connectionModel.wallet;
		_whitelist = connectionModel.whitelist;
		_password = newPassword;
	}
	return self;
}

- (BSConnection *)initConnectionWithID:(NSString *)cID
									  label:(NSString *)cLabel
								   systemID:(NSString *)cSystemID
									   type:(BSConnectionType)cType
{
	if (self = [super initWithID:cID andTitle:cLabel]) {
		_connectionID = cID;
		_label = cLabel;
		_systemID = cSystemID;
		_type = cType;
		
	}
	return self;
}

- (BSConnection *)init
{
	if (self = [super initWithID:@"0" andTitle:@"Connection"]) {
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"API_TOKEN" : APIToken }];
		
		[[BSConnectionsService sharedService] getMeConnectionOnCompletion:^(BSConnection *connection, id error) {
//			[[BSTestSemaphor sharedInstance] lift:@"FetchConnection"];
			
			_connectionModel = connection;
			
			_connectionID = connection.objectID;
			_type = connection.type;
			_label = connection.label;
			_description = connection.description;
			_systemID = connection.systemID;
			
			_users = connection.users;
			
			_wallet = connection.wallet;
			_apiToken = connection.apiToken;
			_callbackURLs = connection.callbackURLs;
			_customer = connection.customer;
			_TLVForMCCAndMNC = connection.TLVForMCCAndMNC;
			_whitelist = connection.whitelist;
			_password = connection.password;
		}];
//		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnection"];
	}
	return self;
}

- (BSConnection *)initDefaultConnection {
	if (self = [super initWithID:@"0" andTitle:@"Connection"]) {
		
		[[BSConnectionsService sharedService] getMeConnectionOnCompletion:^(BSConnection *connection, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchConnection"];
			
			_connectionModel = connection;
			
			_connectionID = connection.objectID;
			_type = connection.type;
			_label = connection.label;
			_description = connection.description;
			_systemID = connection.systemID;
			
			_users = connection.users;
			
			_wallet = connection.wallet;
			_apiToken = connection.apiToken;
			_callbackURLs = connection.callbackURLs;
			_customer = connection.customer;
			_TLVForMCCAndMNC = connection.TLVForMCCAndMNC;
			_whitelist = connection.whitelist;
			_password = connection.password;

		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnection"];
	}
	return self;
}

+ (BSConnection *)currentConnection
{
	static BSConnection *singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[BSConnection alloc] init];
	});
	return singleton;
}

#pragma mark - Public methods

//After made changes it is necessary to call method updateConnection
- (void)updateConnection
{
	if (!_connectionModel) {
		return;
	}
	
	[[BSConnectionsService sharedService] updateConnection:_connectionModel
										   withCallbackDLR:[_callbackURLs.DLR isEqualToString:_connectionModel.callbackURLs.DLR] ? nil : _callbackURLs.DLR
												  systemID:[_systemID isEqualToString:_connectionModel.systemID] ? nil : _systemID
													 label:[_label isEqualToString:_connectionModel.label] ? nil : _label
											   description:[_description isEqualToString:_connectionModel.description] ? nil : _description
									   withCompletionBlock:^(BSConnection *connection, id error) {
	
										   _connectionModel = connection;
										   
										   _callbackURLs.DLR = connection.callbackURLs.DLR;
										   _systemID = connection.systemID;
										   _label = connection.label;
										   _description = connection.description;
										   
									   }];
}

//If API token is compromised use this method for token reset
- (void)resetConnectionToken
{
	[[BSConnectionsService sharedService] resetTokenForConnection:_connectionModel withCompletionBlock:^(BSConnection *updatedModel, id error) {
		
		//If previously saved API token is equal to connection token
		//then overwrite it. Otherwise saved token is User token.
		if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"API_TOKEN"] isEqualToString:_connectionModel.apiToken]) {
			 [[NSUserDefaults standardUserDefaults] setObject:updatedModel.apiToken forKey:@"API_TOKEN"];
		}
		
		_connectionModel = updatedModel;
		_apiToken = updatedModel.apiToken;
		
	}];
}

//Returns pricelists
- (void)getPricelistsOnCompletion:(void(^)(NSArray *pricelists))block
{
	if (_pricelists) {
		block(_pricelists);
		return;
	}
	
	[[BSPricelistService sharedService] getPricelistsForConnection:_connectionModel withCompletionBlock:^(NSArray *pricelists, id error) {
		_pricelists = pricelists;
		block(_pricelists);
	}];
}

//Returns current pricelists
- (void)getCurrentPricelistOnCompletion:(void(^)(BSPricelist *pricelist))block
{
	if (_currentPricelist) {
		block(_currentPricelist);
		return;
	}
	
	[[BSPricelistService sharedService] getCurrentPricelistsForConnection:_connectionModel withCompletionBlock:^(BSPricelist *pricelist, id error) {
		_currentPricelist = pricelist;
		block(_currentPricelist);
	}];
}

//Send message
- (void)sendSMS:(BSMessage *)message
{
	[[BSSMSService sharedService] sendMessage:message usingConnection:_connectionModel withCompletionBlock:^(NSArray *response, id error) {
		BSDLog(@"%@", response);
	}];
}

//Send messages
- (void)sendMultipleSMS:(NSArray *)messages
{
	[[BSSMSService sharedService] sendMessages:messages usingConnection:_connectionModel withCompletionBlock:^(NSArray *array, id error) {
		BSDLog(@"%@", array);
	}];
}

//Validate SMS
- (void)validateSMS:(BSMessage *)message
{
	[[BSSMSService sharedService] validateSMSForMessage:message withCompletionBlock:^(BSMessage *message, id error) {
		BSDLog(@"%@", message);
	}];
}

//Get sms details
- (void)getDetailsForSMS:(BSMessage *)message
{
	[[BSSMSService sharedService] lookupSMS:message withCompletionBlock:^(BSLookup *lookupResponse, id error) {
		BSDLog(@"%@", lookupResponse);
	}];
}

@end
