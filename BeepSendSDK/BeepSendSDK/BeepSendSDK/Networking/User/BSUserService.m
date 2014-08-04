
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
	[super executeGETForMethod:[BSAPIConfiguration userMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  if (!error) {
						  
						  BSUser *userModel = [[BSAPCUser classFromDict:response] convertToModel];
						  
						  block(userModel, nil);
					  }
					  else {
			  
						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)updateUserWithName:(NSString *)uName
					 phone:(NSString *)uPhone
		 defaultConnection:(BSConnection *)uConnection
				 userTypes:(NSArray *)uTypes
			 verifiedTerms:(NSNumber *)uVerifiedTerms
	   withCompletionBlock:(void(^)(BSUser *user, NSArray *errors))block
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
						  
						  block(userModel, nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)updateUserEmail:(NSString *)newEmail
		   userPassword:(NSString *)password
	withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	BSUser *userUpdate = [[BSUser alloc] initUserWithEmail:newEmail andPassword:password];
	
	NSDictionary *userUpdateDictionary = [[BSAPCUser convertFromUserModel:userUpdate] dictFromClass];
	
	BSDLog(@"%@", userUpdateDictionary);
	
	[super executePUTForMethod:[BSAPIConfiguration updateUserEmail]
				withParameters:userUpdateDictionary
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(YES, nil);
					  }
					  else {

						  block(NO, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)updateUserPassword:(NSString *)password
		   userNewPassword:(NSString *)newPassword
	   withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	BSUser *userUpdate = [[BSUser alloc] initUserWithPassword:password andNewPassword:newPassword];
	
	NSDictionary *userUpdateDictionary = [[BSAPCUser convertFromUserModel:userUpdate] dictFromClass];
	
	BSDLog(@"%@", userUpdateDictionary);
	
	[super executePUTForMethod:[BSAPIConfiguration updateUserPassword]
				withParameters:userUpdateDictionary
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(YES, nil);
					  }
					  else {

						  block(NO, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)resetUserTokenUsingPassword:(NSString *)password withCompletionBlock:(void(^)(NSString *apiToken, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration resetTokenMe]
				withParameters:@{@"password" : password}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(response[@"api_token"], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)resetUserPasswordForEmail:(NSString *)email withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration resetPassword]
				withParameters:@{@"email" : email}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(YES, nil);
					  }
					  else {
						  
						  block(NO, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)verifyEmailWithHash:(NSString *)hash withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration verifyEmailWithHash:hash]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(YES, nil);
					  }
					  else {

						  block(NO, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
					  
				  }];
}

- (void)verifyPhoneWithHash:(NSString *)hash withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration verifyPhoneWithHash:hash]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block(YES, nil);
					  }
					  else {

						  block(NO, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
					  
				  }];
}

@end
