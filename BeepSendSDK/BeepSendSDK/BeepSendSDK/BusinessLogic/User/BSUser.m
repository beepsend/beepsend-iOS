//
//  BSUser.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUser.h"

#import "BSInputData.h"

#import "BSUserService.h"
#import "BSConnectionsService.h"

#import "BSTestSemaphor.h"

#import "BSConnection.h"

@interface BSUser ()

@property (nonatomic, strong) BSUser *currentUser;

@property (nonatomic, strong) NSArray *connections;

@end

@implementation BSUser

#pragma mark - Properties

- (NSString *)name {
	return _currentUser ? _currentUser.name : _name;
}

- (NSString *)phone {
	return _currentUser ? _currentUser.phone : _phone;
}

- (NSString *)email {
	return _currentUser ? _currentUser.email : _email;
}

- (BSConnection *)defaultConnection {
	if (_defaultConnection) {
		return _defaultConnection;
	}
	return _defaultConnection = [[BSConnection alloc] initDefaultConnection];
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular user"]) {
		
	}
	return self;
}

- (BSUser *)initUserWithID:(NSString *)uID
					  name:(NSString *)uName
					 email:(NSString *)uEmail
{
	if (self = [super initWithID:uID andTitle:uName]) {
		_userID = uID;
		_name = uName;
		_email = uEmail;
	}
	return self;
}

- (BSUser *)initUserWithEmail:(NSString *)uEmail
				  andPassword:(NSString *)uPassword
{
	if (self = [super initWithID:@"0" andTitle:@"Update email user"]) {
		_userID = @"0";
		_email = uEmail;
		_password = uPassword;
	}
	return self;
}

- (BSUser *)initUserWithPassword:(NSString *)uPassword
				  andNewPassword:(NSString *)uNewPassword
{
	if (self = [super initWithID:@"0" andTitle:@"Update user password"]) {
		_userID = @"0";
		_password = uPassword;
		_theNewPassword = uNewPassword;
	}
	return self;
}

- (BSUser *)initWithName:(NSString *)uName
				   phone:(NSString *)uPhone
	   defaultConnection:(BSConnection *)uConnection
			   userTypes:(NSArray *)uTypes
				verified:(BSVerified *)uVerified
{
	if (self = [super initWithID:@"0" andTitle:uName]) {
		_userID = @"0";
		_name = uName;
		_phone = uPhone;
		_defaultConnection = uConnection;
		_userTypes = uTypes;
		_verified = uVerified;
	}
	return self;
}

- (BSUser *)initUserWithID:(NSString *)uID
					  name:(NSString *)uName
					 email:(NSString *)uEmail
					 phone:(NSString *)uPhone
				  customer:(NSString *)uCustomer
				  apiToken:(NSString *)uAPIToken
		 defaultConnection:(BSConnection *)uConnection
				 userTypes:(NSArray *)uUserTypes
				  maxLevel:(NSNumber *)uMaxLevel
				  verified:(BSVerified *)uVerified
{
	if (self = [super initWithID:uID andTitle:uName]) {
		_userID = uID;
		_name = uName;
		_email = uEmail;
		_phone = uPhone;
		_customer = uCustomer;
		_apiToken = uAPIToken;
		_defaultConnection = uConnection;
		_userTypes = uUserTypes;
		_maxLevel = uMaxLevel;
		_verified = uVerified;
	}
	return self;
}

- (BSUser *)init
{
	if (self = [super initWithID:@"0" andTitle:@"User"]) {
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"API_TOKEN" : APIToken }];
		
		[[BSUserService sharedService] getUserDetailsWithCompletionBlock:^(BSUser *user, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchUser"];
			
			_currentUser = user;
			
			_name = user.name;
			_email = user.email;
			_phone = user.phone;
			
			_userID = user.userID;

			_customer = user.customer;
			_apiToken = user.apiToken;

			_userTypes = user.userTypes;
			_maxLevel = user.maxLevel;
			_verified = user.verified;
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchUser"];
		
	}
	return self;
}

+ (BSUser *)currentUser
{
	static BSUser *singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[BSUser alloc] init];
	});
	return singleton;
}

- (BSUser *)initWithUserID:(NSString *)uID
{
	if (self = [super initWithID:@"0" andTitle:@"User"]) {
		_userID = uID;
	}
	return self;
}

#pragma mark - Public methods

- (void)updateUser
{
	if (!_currentUser) {
		return;
	}
	
	BSConnection *connectionModel;
	if (![_defaultConnection.connectionID isEqualToString:_currentUser.defaultConnection.objectID]) {
		connectionModel = [[BSConnection alloc] initConnectionWithID:_defaultConnection.connectionID];
	}
	[[BSUserService sharedService] updateUserWithName:[_name isEqualToString:_currentUser.name]?nil:_name
												phone:[_phone isEqualToString:_currentUser.phone]?nil:_phone
									defaultConnection:connectionModel
											userTypes:nil
										verifiedTerms:nil withCompletionBlock:^(BSUser *user, id error) {
											
											_currentUser = user;
											
											_name = user.name;
											_email = user.email;
											_phone = user.phone;
											
											_defaultConnection = user.defaultConnection;
	}];
}

- (void)resetUserTokenWithPassword:(NSString *)password
{
	[[BSUserService sharedService] resetUserTokenUsingPassword:password withCompletionBlock:^(NSString *apiToken, id error) {
		[[NSUserDefaults standardUserDefaults] setObject:apiToken forKey:@"API_TOKEN"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		_apiToken = apiToken;
	}];
}

- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections))block
{
	[[BSConnectionsService sharedService] getAllAvailableConnectsionOnCompletion:^(NSArray *connections, id error) {
		BSDLog(@"%@", connections);
		
		_connections = connections;
		
		block(_connections);
	}];
}

- (NSArray *)getAvailableConnections
{
	if (_connections) {
		return _connections;
	}
	else {
		[[BSConnectionsService sharedService] getAllAvailableConnectsionOnCompletion:^(NSArray *connections, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchConnections"];
			
			_connections = connections;
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnections"];
		
		return _connections;
	}
}

@end
