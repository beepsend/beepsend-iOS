//
//  BSUserModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUserModel.h"

@interface BSUserModel ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *email;

@property (nonatomic, strong, readwrite) NSString *phoneNumber;
@property (nonatomic, strong, readwrite) NSString *customer;
@property (nonatomic, strong, readwrite) NSString *apiToken;
@property (nonatomic, strong, readwrite) BSConnection *defaultConnection;
@property (nonatomic, strong, readwrite) NSArray *userTypes;
@property (nonatomic, strong, readwrite) NSNumber *maxLevel;//Simple permission model. Allows access to all version 2 endpoints.
@property (nonatomic, strong, readwrite) BSVerifiedModel *verified;

@property (nonatomic, strong, readwrite) NSString *password;
@property (nonatomic, strong, readwrite) NSString *theNewPassword;

@end

@implementation BSUserModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular user"]) {
		
	}
	return self;
}

- (BSUserModel *)initUserWithID:(NSString *)uID
						   name:(NSString *)uName
						  email:(NSString *)uEmail
{
	if (self = [super initWithID:uID andTitle:uName]) {
		_name = uName;
		_email = uEmail;
	}
	return self;
}

- (BSUserModel *)initUserWithEmail:(NSString *)uEmail
					   andPassword:(NSString *)uPassword
{
	if (self = [super initWithID:@"0" andTitle:@"Update email user"]) {
		_email = uEmail;
		_password = uPassword;
	}
	return self;
}

- (BSUserModel *)initUserWithPassword:(NSString *)uPassword
					   andNewPassword:(NSString *)uNewPassword
{
	if (self = [super initWithID:@"0" andTitle:@"Update user password"]) {
		_password = uPassword;
		_theNewPassword = uNewPassword;
	}
	return self;
}

- (BSUserModel *)initWithName:(NSString *)uName
						phone:(NSString *)uPhone
			defaultConnection:(BSConnection *)uConnection
					userTypes:(NSArray *)uTypes
					 verified:(BSVerifiedModel *)uVerified
{
	if (self = [super initWithID:@"0" andTitle:uName]) {
		_name = uName;
		_phoneNumber = uPhone;
		_defaultConnection = uConnection;
		_userTypes = uTypes;
		_verified = uVerified;
	}
	return self;
}

- (BSUserModel *)initUserWithID:(NSString *)uID
						   name:(NSString *)uName
						  email:(NSString *)uEmail
						  phone:(NSString *)uPhone
					   customer:(NSString *)uCustomer
					   apiToken:(NSString *)uAPIToken
			  defaultConnection:(BSConnection *)uConnection
					  userTypes:(NSArray *)uUserTypes
					   maxLevel:(NSNumber *)uMaxLevel
					   verified:(BSVerifiedModel *)uVerified
{
	if (self = [super initWithID:uID andTitle:uName]) {
		_name = uName;
		_email = uEmail;
		_phoneNumber = uPhone;
		_customer = uCustomer;
		_apiToken = uAPIToken;
		_defaultConnection = uConnection;
		_userTypes = uUserTypes;
		_maxLevel = uMaxLevel;
		_verified = uVerified;
	}
	return self;
}

@end
