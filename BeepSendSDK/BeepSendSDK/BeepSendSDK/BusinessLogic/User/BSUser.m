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
#import "BSCustomerService.h"
#import "BSWalletService.h"
#import "BSContactsService.h"
#import "BSGroupsService.h"

#import "BSTestSemaphor.h"

#import "BSConnection.h"
#import "BSWallet.h"
#import "BSVerified.h"
#import "BSCustomer.h"

@interface BSUser ()

@property (nonatomic, strong) BSUser *currentUser;

@property (nonatomic, strong) NSArray *connections;
@property (nonatomic, strong) NSArray *wallets;

@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSArray *groups;

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
	return _defaultConnection = [BSConnection currentConnection];
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
		_customerName = uCustomer;
		_apiToken = uAPIToken;
		_defaultConnection = uConnection;
		_userTypes = uUserTypes;
		_maxLevel = uMaxLevel;
		_verified = uVerified;
	}
	return self;
}

- (BSUser *)initWithUserID:(NSString *)uID
{
	if (self = [super initWithID:@"0" andTitle:@"User"]) {
		_userID = uID;
	}
	return self;
}

- (BSUser *)init
{
	if (self = [super initWithID:@"0" andTitle:@"User"]) {
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"API_TOKEN" : APIToken }];
		
		[[BSUserService sharedService] getUserDetailsWithCompletionBlock:^(BSUser *user, id error) {
//			[[BSTestSemaphor sharedInstance] lift:@"FetchUser"];
			
			_currentUser = user;
			
			_name = user.name;
			_email = user.email;
			_phone = user.phone;
			
			_userID = user.userID;

			_customerName = user.customerName;
			_apiToken = user.apiToken;

			_userTypes = user.userTypes;
			_maxLevel = user.maxLevel;
			_verified = user.verified;
			
			_defaultConnection = [BSConnection currentConnection];
			
		}];
//		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchUser"];
		
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

#pragma mark - Public methods

- (void)updateUser
{
	if (!_currentUser) {
		return; //User object can not be edited
	}
	
	if ([_name isEqualToString:_currentUser.name] &&
		[_phone isEqualToString:_currentUser.phone] &&
		[_defaultConnection.connectionID isEqualToString:_currentUser.defaultConnection.objectID] &&
		[_userTypes isEqualToArray:_currentUser.userTypes] &&
		_verified.isVerifiedTerms==_currentUser.verified.isVerifiedTerms) {
		return; //No changes were made
	}
	
	[[BSUserService sharedService] updateUserWithName:[_name isEqualToString:_currentUser.name]?nil:_name
												phone:[_phone isEqualToString:_currentUser.phone]?nil:_phone
									defaultConnection:[_defaultConnection.connectionID isEqualToString:_currentUser.defaultConnection.objectID]?nil:_defaultConnection
											userTypes:[_userTypes isEqualToArray:_currentUser.userTypes]?nil:_userTypes
										verifiedTerms:_verified.isVerifiedTerms==_currentUser.verified.isVerifiedTerms?nil:_verified.termsVerified
								  withCompletionBlock:^(BSUser *user, id error) {
									  
									  _currentUser = user;
									  
									  _name = user.name;
									  _phone = user.phone;
									  
									  _defaultConnection = user.defaultConnection;
									  
									  _userTypes = user.userTypes;
									  
									  _verified.termsVerified = user.verified.termsVerified;
	}];
}

- (void)updateUserEmailWithPassword:(NSString *)password
{
	if (!password) {
		return;//Missing password
	}
	
	if (_password) {
		if (![_password isEqualToString:password]) {
			return;//Invalid password
		}
	}
	
	if (![_email isEqualToString:_currentUser.email]) {
		[[BSUserService sharedService] updateUserEmail:_email userPassword:password withCompletionBlock:^(BOOL success, id error) {
			if (success) {
				_currentUser.email = _email;
				_password = password;
			}
		}];
	}
}

- (void)changePassword:(NSString *)currentPassword withNewPassword:(NSString *)newPassword
{
	if (!currentPassword || !newPassword) {
		return; //Missing password
	}
	
	if ([currentPassword isEqualToString:newPassword]) {
		return; //Passwords don't match
	}
	
	if (_password) {
		if (![_password isEqualToString:currentPassword]) {
			return; //Invalid password
		}
	}
	
	[[BSUserService sharedService] updateUserPassword:_password userNewPassword:_theNewPassword withCompletionBlock:^(BOOL success, id error) {
		if (success) {
			_password = _theNewPassword;
			_theNewPassword = nil;
		}
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

- (void)getCustomerDetailsOnCompletion:(void(^)(BSCustomer *customer, id error))block
{
	if (_customer) {
		block(_customer, nil);
	}
	
	[[BSCustomerService sharedService] getCustomerOnCompletion:^(BSCustomer *customer, id error) {
		
		if (!_customer) {
			block(customer, error);
		}
		
		_customer = customer;
	}];
}

- (void)getAvailableWalletsOnCompletion:(void(^)(NSArray *wallets, id error))block
{
	[[BSWalletService sharedService] getAllWalletsWithCompletionBlock:^(NSArray *wallets, id error) {
		
		_wallets = wallets;
		
		block(wallets, error);
	}];
}

- (NSArray *)getAvailableWallets
{
	if (_wallets) {
		return _wallets;
	}
	else {
		[[BSWalletService sharedService] getAllWalletsWithCompletionBlock:^(NSArray *wallets, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchWallets"];
			
			_wallets = wallets;
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchWallets"];
		
		return _wallets;
	}
}

- (void)getAllContactsOnCompletion:(void(^)(NSArray *contacts, id error))block
{
	if (_contacts) {
		block(_contacts, nil);
	}
	
	[[BSContactsService sharedService] getAllContactsWithCompletionBlock:^(NSArray *contacts, id error) {
			
		if (!_contacts) {
			block(contacts, error);
		}
		
		_contacts = contacts;
	}];
}

- (NSArray *)getAllContacts
{
	if (_contacts) {
		return _contacts;
	}
	else {
		[[BSContactsService sharedService] getAllContactsWithCompletionBlock:^(NSArray *contacts, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchContacts"];
			
			_contacts = contacts;
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchContacts"];
		
		return _contacts;
	}
}

- (void)addMultipleContacts:(NSArray *)contacts onCompletion:(void(^)(NSArray *response, id error))block
{
	[[BSContactsService sharedService] addContacts:contacts withCompletionBlock:^(NSArray *contacts, id error) {
		block(contacts, error);
	}];
}

- (void)searchContactsWithQuery:(NSString *)query inGroup:(BSGroup *)group limit:(NSNumber *)limit onCompletion:(void(^)(NSArray *results, id error))block
{
	[[BSContactsService sharedService] searchContact:query inGroup:group limit:limit.integerValue withCompletionBlock:^(NSArray *results, id error) {
		block(results, error);
	}];
}

- (void)getAllGroupsOnCompletion:(void(^)(NSArray *groups, id error))block
{
	if (_groups) {
		block(_groups, nil);
	}
	
	[[BSGroupsService sharedService] getAllGroupsWithCompletionBlock:^(NSArray *groups, id error) {
		
		if (!_groups) {
			block(groups, error);
		}
		
		_groups = groups;
	}];
}

- (NSArray *)getAllGroups
{
	if (_groups) {
		return _groups;
	}
	else {
		[[BSGroupsService sharedService] getAllGroupsWithCompletionBlock:^(NSArray *groups, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchGroups"];
			
			_groups = groups;
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchGroups"];
		
		return _groups;
	}
}

@end
