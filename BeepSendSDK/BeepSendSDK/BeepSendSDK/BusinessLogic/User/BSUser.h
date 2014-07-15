//
//  BSUser.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSCustomer;
@class BSVerified;
@class BSConnection;

@interface BSUser : BSGeneralModel

//User ID
@property (nonatomic, strong, readonly) NSString *userID;

//Editable data
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;

//Users default connection
@property (nonatomic, strong) BSConnection *defaultConnection;

//Customer that ownes user
@property (nonatomic, strong, readonly) NSString *customerName;

//Users API token
@property (nonatomic, strong, readonly) NSString *apiToken;

//User types
@property (nonatomic, strong) NSArray *userTypes;

//Simple permission model. Allows access to all version 2 endpoints.
@property (nonatomic, strong, readonly) NSNumber *maxLevel;

//Users password
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *theNewPassword;

//Is user verified
@property (nonatomic, strong, readonly) BSVerified *verified;

//Accessible only if customer details are enquired 
@property (nonatomic, strong, readonly) BSCustomer *customer;

- (BSUser *)initUserWithID:(NSString *)uID
					  name:(NSString *)uName
					 email:(NSString *)uEmail;

- (BSUser *)initUserWithEmail:(NSString *)uEmail
				  andPassword:(NSString *)uPassword;

- (BSUser *)initUserWithPassword:(NSString *)uPassword
				  andNewPassword:(NSString *)uNewPassword;

- (BSUser *)initWithName:(NSString *)uName
				   phone:(NSString *)uPhone
	   defaultConnection:(BSConnection *)uConnection
			   userTypes:(NSArray *)uTypes
				verified:(BSVerified *)uVerified;

- (BSUser *)initUserWithID:(NSString *)uID
					  name:(NSString *)uName
					 email:(NSString *)uEmail
					 phone:(NSString *)uPhone
				  customer:(NSString *)uCustomer
				  apiToken:(NSString *)uAPIToken
		 defaultConnection:(BSConnection *)uConnection
				 userTypes:(NSArray *)uUserTypes
				  maxLevel:(NSNumber *)uMaxLevel
				  verified:(BSVerified *)uVerified;

//Create user object with ID
- (BSUser *)initWithUserID:(NSString *)uID;

//Initiate user with API token
+ (BSUser *)currentUser;

//After made changes with name, phone or defaultConnection
//it is necessary to call method updateUser
- (void)updateUser;

//For updateing email address user needs to enter password
- (void)updateUserEmailWithPassword:(NSString *)password;

//Method for changing password
- (void)changePassword:(NSString *)currentPassword withNewPassword:(NSString *)newPassword;

//If API token is compromised use this method for token reset
- (void)resetUserTokenWithPassword:(NSString *)password;

//Async method for retrieving users connections
- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections))block;
//Sync method for retrieving users connections
- (NSArray *)getAvailableConnections;

- (void)getCustomerDetailsOnCompletion:(void(^)(BSCustomer *customer, id error))block;

- (void)getAvailableWalletsOnCompletion:(void(^)(NSArray *wallets, id error))block;
- (NSArray *)getAvailableWallets;

@end
