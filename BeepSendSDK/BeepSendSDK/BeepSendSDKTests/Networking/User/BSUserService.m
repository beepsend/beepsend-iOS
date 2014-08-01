
//
//  BSUserService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUserService.h"

#import "BSAPIConfiguration.h"

#import "BSAPCUser.h"

#import "BSVerified.h"

@implementation BSUserService

#pragma mark - Initialization

+ (instancetype)sharedService
{
	static id singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[[self class] alloc] init];
	});
	return singleton;
}

#pragma mark - Public methods

- (void)getUserDetailsWithCompletionBlock:(void(^)(BSUser *user, NSArray *errors))block
{
	BSUser *userModel = [[BSAPCUser classFromDict:@{@"id":@4,@"name":@"Beep",@"email":@"beep@beepsend.com",@"phone":@"46736007518",@"customer":@"Beepsend AB",@"api_token":@"abc123",@"default_connection":@{@"id":@27,@"label":@"The Beep Connection",@"system_id":@"beep-connect",@"type":@1},@"user_types":@[@{@"id":@1,@"name":@"Technical Contact"}],@"max_level":@2,@"verified":@{@"email":@YES,@"phone":@NO,@"terms":@YES}}] convertToModel];
	block(userModel, nil);
}

- (void)updateUserWithName:(NSString *)uName
					 phone:(NSString *)uPhone
		 defaultConnection:(BSConnection *)uConnection
				 userTypes:(NSArray *)uTypes
			 verifiedTerms:(NSNumber *)uVerifiedTerms
	   withCompletionBlock:(void(^)(BSUser *user, NSArray *errors))block
{
	BSUser *userModel = [[BSAPCUser classFromDict:
  @{
	@"id":@4,
	@"name":uName,
	@"email":@"beep@beepsend.com",
	@"phone":uPhone,
	@"customer":@"Beepsend AB",
	@"api_token":@"abc123",
	@"default_connection":@{
			@"id":[NSNumber numberWithInteger:[uConnection.connectionID integerValue]],
			@"label":uConnection.label,
			@"system_id":uConnection.systemID,
			@"type":[NSNumber numberWithInteger:uConnection.type]},
	@"user_types":@[
  @{@"id":@1,
	@"name":@"Technical Contact"}
  ],
	@"max_level":@2,
	@"verified":@{
			@"email":@YES,
			@"phone":@NO,
			@"terms":@YES}}] convertToModel];
	block(userModel, nil);
}

- (void)updateUserEmail:(NSString *)newEmail
		   userPassword:(NSString *)password
	withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	block(YES, nil);
}

- (void)updateUserPassword:(NSString *)password
		   userNewPassword:(NSString *)newPassword
	   withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	block(YES, nil);
}

- (void)resetUserTokenUsingPassword:(NSString *)password withCompletionBlock:(void(^)(NSString *apiToken, NSArray *errors))block
{
	block(@"NEW_TOKEN", nil);
}

- (void)verifyEmailWithHash:(NSString *)hash withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	block(YES, nil);
}

- (void)verifyPhoneWithHash:(NSString *)hash withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	block(YES, nil);
}

@end
