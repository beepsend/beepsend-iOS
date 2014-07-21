
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

- (void)getUserDetailsWithCompletionBlock:(void(^)(BSUser *user, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration userMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSUser *userModel = [[BSAPCUser classFromDict:response] convertToModel];
						  
						  block(userModel, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)updateUserWithName:(NSString *)uName
					 phone:(NSString *)uPhone
		 defaultConnection:(BSConnection *)uConnection
				 userTypes:(NSArray *)uTypes
			 verifiedTerms:(NSNumber *)uVerifiedTerms
	   withCompletionBlock:(void(^)(BSUser *user, id error))block
{
	
	BSConnection *connection = [[BSConnection alloc] initConnectionWithID:uConnection.connectionID];
	
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSUserType *uType in uTypes) {
		BSUserType *t = [[BSUserType alloc] initUserTypeWithID:uType.objectID];
		[mArr addObject:t];
	}
	
	BSVerified *verified = nil;
	if (uVerifiedTerms) {
		verified = [[BSVerified alloc] initUserWithTermsVerified:uVerifiedTerms];
	}
	
	BSUser *userUpdate =
	[[BSUser alloc] initWithName:uName
						   phone:uPhone
			   defaultConnection:connection
					   userTypes:[NSArray arrayWithArray:mArr]
						verified:verified];
	
	NSDictionary *userUpdateDictionary = [[BSAPCUser convertFromUserModel:userUpdate] dictFromClass];
	
	BSDLog(@"%@", userUpdateDictionary);
	
	[super executePUTForMethod:[BSAPIConfiguration userMe]
				withParameters:userUpdateDictionary
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSUser *userModel = [[BSAPCUser classFromDict:response] convertToModel];
						  
						  block(userModel, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)updateUserEmail:(NSString *)newEmail
		   userPassword:(NSString *)password
	withCompletionBlock:(void(^)(BOOL success, id error))block
{
	BSUser *userUpdate = [[BSUser alloc] initUserWithEmail:newEmail andPassword:password];
	
	NSDictionary *userUpdateDictionary = [[BSAPCUser convertFromUserModel:userUpdate] dictFromClass];
	
	BSDLog(@"%@", userUpdateDictionary);
	
	[super executePUTForMethod:[BSAPIConfiguration updateUserEmail]
				withParameters:userUpdateDictionary
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(YES, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(NO, response);
					  }
				  }];
}

- (void)updateUserPassword:(NSString *)password
		   userNewPassword:(NSString *)newPassword
	   withCompletionBlock:(void(^)(BOOL success, id error))block
{
	BSUser *userUpdate = [[BSUser alloc] initUserWithPassword:password andNewPassword:newPassword];
	
	NSDictionary *userUpdateDictionary = [[BSAPCUser convertFromUserModel:userUpdate] dictFromClass];
	
	BSDLog(@"%@", userUpdateDictionary);
	
	[super executePUTForMethod:[BSAPIConfiguration updateUserPassword]
				withParameters:userUpdateDictionary
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(YES, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(NO, response);
					  }
				  }];
}

- (void)resetUserTokenUsingPassword:(NSString *)password withCompletionBlock:(void(^)(NSString *apiToken, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration resetTokenMe]
				withParameters:@{@"password":password}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(response[@"api_token"], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)verifyEmailWithHash:(NSString *)hash withCompletionBlock:(void(^)(BOOL success, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration verifyEmailWithHash:hash]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(YES, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(NO, response);
					  }
					  
				  }];
}

- (void)verifyPhoneWithHash:(NSString *)hash withCompletionBlock:(void(^)(BOOL success, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration verifyPhoneWithHash:hash]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(YES, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(NO, response);
					  }
					  
				  }];
}

@end
