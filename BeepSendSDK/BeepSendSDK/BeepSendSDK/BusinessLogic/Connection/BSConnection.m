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

#import "BSUserModel.h"

#import "BSUser.h"
#import "BSMessage.h"

@interface BSConnection ()

@property (nonatomic, strong) BSConnectionModel *connectionModel;

@property (nonatomic, strong) BSPricelist *currentPricelist;
@property (nonatomic, strong) NSArray *pricelists;

@end

@implementation BSConnection

#pragma mark - Properties

- (NSString *)apiToken {
	return _connectionModel.apiToken;
}

#pragma mark - Initialization

- (BSConnection *)init
{
	if (self = [super init]) {
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"API_TOKEN" : APIToken }];
		
		[[BSConnectionsService sharedService] getMeConnectionOnCompletion:^(BSConnectionModel *connection, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchConnection"];
			
			_connectionModel = connection;
			
			_connectionID = connection.objectID;
			_type = connection.type;
			_label = connection.label;
			_description = connection.description;
			_systemID = connection.systemID;
			
			NSMutableArray *mArr = [@[] mutableCopy];
			for (BSUserModel *user in connection.users) {
				
				BSUser *u = [[BSUser alloc] initWithUserID:user.objectID];
				u.name = user.name;
				u.email = user.email;
				
				[mArr addObject:u];
			}
			_users = [NSArray arrayWithArray:mArr];
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnection"];
	}
	return self;
}

- (BSConnection *)initDefaultConnection {
	if (self = [super init]) {
		
		[[BSConnectionsService sharedService] getMeConnectionOnCompletion:^(BSConnectionModel *connection, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchConnection"];
			
			_connectionModel = connection;
			
			_connectionID = connection.objectID;
			_type = connection.type;
			_label = connection.label;
			_description = connection.description;
			_systemID = connection.systemID;
			
			NSMutableArray *mArr = [@[] mutableCopy];
			for (BSUserModel *user in connection.users) {
				
				BSUser *u = [[BSUser alloc] initWithUserID:user.objectID];
				u.name = user.name;
				u.email = user.email;
				
				[mArr addObject:u];
			}
			_users = [NSArray arrayWithArray:mArr];
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnection"];
	}
	return self;
}

#pragma mark - Public methods

//After made changes it is necessary to call method updateConnection
- (void)updateConnection
{
	[[BSConnectionsService sharedService] updateConnection:_connectionModel
										   withCallbackDLR:[_dlrCallback isEqualToString:_connectionModel.callbacks.DLR] ? nil : _dlrCallback
												  systemID:[_systemID isEqualToString:_connectionModel.systemID] ? nil : _systemID
													 label:[_label isEqualToString:_connectionModel.label] ? nil : _label
											   description:[_description isEqualToString:_connectionModel.description] ? nil : _description
									   withCompletionBlock:^(BSConnectionModel *connection, id error) {
	
										   _connectionModel = connection;
										   
										   _dlrCallback = connection.callbacks.DLR;
										   _systemID = connection.systemID;
										   _label = connection.label;
										   _description = connection.description;
										   
									   }];
}

//If API token is compromised use this method for token reset
- (void)resetConnectionToken
{
	[[BSConnectionsService sharedService] resetTokenForConnection:_connectionModel withCompletionBlock:^(BSConnectionModel *updatedModel, id error) {
		
		//If previously saved API token is equal to connection token
		//then overwrite it. Otherwise saved token is User token.
		if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"API_TOKEN"] isEqualToString:_connectionModel.apiToken]) {
			 [[NSUserDefaults standardUserDefaults] setObject:updatedModel.apiToken forKey:@"API_TOKEN"];
		}
		
		_connectionModel = updatedModel;
		
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
		BSLog(@"%@", response);
	}];
}

//Send messages
- (void)sendMultipleSMS:(NSArray *)messages
{
	[[BSSMSService sharedService] sendMessages:messages usingConnection:_connectionModel withCompletionBlock:^(NSArray *array, id error) {
		BSLog(@"%@", array);
	}];
}

//Validate SMS
- (void)validateSMS:(BSMessage *)message
{
	[[BSSMSService sharedService] validateSMSForMessage:message withCompletionBlock:^(BSMessage *message, id error) {
		BSLog(@"%@", message);
	}];
}

//Get sms details
- (void)getDetailsForSMS:(BSMessage *)message
{
	[[BSSMSService sharedService] lookupSMS:message withCompletionBlock:^(BSLookupModel *lookupResponse, id error) {
		BSLog(@"%@", lookupResponse);
	}];
}

@end
