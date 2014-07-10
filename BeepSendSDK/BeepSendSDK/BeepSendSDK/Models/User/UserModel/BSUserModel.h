//
//  BSUserModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSConnection.h"
#import "BSVerifiedModel.h"

@interface BSUserModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *email;

@property (nonatomic, strong, readonly) NSString *phoneNumber;
@property (nonatomic, strong, readonly) NSString *customer;
@property (nonatomic, strong, readonly) NSString *apiToken;
@property (nonatomic, strong, readonly) BSConnection *defaultConnection;
@property (nonatomic, strong, readonly) NSArray *userTypes;
@property (nonatomic, strong, readonly) NSNumber *maxLevel;//Simple permission model. Allows access to all version 2 endpoints.
@property (nonatomic, strong, readonly) BSVerifiedModel *verified;

@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *theNewPassword;

- (BSUserModel *)initUserWithID:(NSString *)uID
						   name:(NSString *)uName
						  email:(NSString *)uEmail;

- (BSUserModel *)initUserWithEmail:(NSString *)uEmail
					   andPassword:(NSString *)uPassword;

- (BSUserModel *)initUserWithPassword:(NSString *)uPassword
					   andNewPassword:(NSString *)uNewPassword;

- (BSUserModel *)initWithName:(NSString *)uName
						phone:(NSString *)uPhone
			defaultConnection:(BSConnection *)uConnection
					userTypes:(NSArray *)uTypes
					 verified:(BSVerifiedModel *)uVerified;

- (BSUserModel *)initUserWithID:(NSString *)uID
						   name:(NSString *)uName
						  email:(NSString *)uEmail
						  phone:(NSString *)uPhone
					   customer:(NSString *)uCustomer
					   apiToken:(NSString *)uAPIToken
			  defaultConnection:(BSConnection *)uConnection
					  userTypes:(NSArray *)uUserTypes
					   maxLevel:(NSNumber *)uMaxLevel
					   verified:(BSVerifiedModel *)uVerified;

@end
