//
//  BSUser.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSVerified.h"

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
@property (nonatomic, strong, readonly) NSString *customer;

//Users API token
@property (nonatomic, strong, readonly) NSString *apiToken;

//User types
@property (nonatomic, strong, readonly) NSArray *userTypes;

//Simple permission model. Allows access to all version 2 endpoints.
@property (nonatomic, strong, readonly) NSNumber *maxLevel;

//Users password
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *theNewPassword;

//Is user verified
@property (nonatomic, strong, readonly) BSVerified *verified;

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

//Initiate user with API token
+ (BSUser *)currentUser;

//Create user object with ID
- (BSUser *)initWithUserID:(NSString *)uID;

//After made changes with name, email, phone
//it is necessary to call method updateUser
- (void)updateUser;

//If API token is compromised use this method for token reset
- (void)resetUserTokenWithPassword:(NSString *)password;

//Async method for retrieving users connections
- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections))block;
//Sync method for retrieving users connections
- (NSArray *)getAvailableConnections;

@end
