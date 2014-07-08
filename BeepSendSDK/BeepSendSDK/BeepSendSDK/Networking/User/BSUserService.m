
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

- (void)getUserDetailsWithCompletionBlock:(void(^)(BSUserModel *user, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration userMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSUserModel *userModel = [[BSAPCUser classFromDict:response] convertToModel];
						  
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
		 defaultConnection:(BSConnectionModel *)uConnection
				 userTypes:(NSArray *)uTypes
			 verifiedTerms:(NSNumber *)uVerifiedTerms
	   withCompletionBlock:(void(^)(BSUserModel *user, id error))block
{
	
	BSConnectionModel *connection = [[BSConnectionModel alloc] initConnectionWithID:uConnection.objectID];
	
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSUserTypeModel *uType in uTypes) {
		BSUserTypeModel *t = [[BSUserTypeModel alloc] initUserTypeWithID:uType.objectID];
		[mArr addObject:t];
	}
	
	BSVerifiedModel *verified = nil;
	if (uVerifiedTerms) {
		verified = [[BSVerifiedModel alloc] initUserWithTermsVerified:uVerifiedTerms];
	}
	
	
	BSUserModel *userUpdate =
	[[BSUserModel alloc] initWithName:uName
								phone:uPhone
					defaultConnection:connection
							userTypes:[NSArray arrayWithArray:mArr]
							 verified:verified];
	
	NSDictionary *userUpdateDictionary = [[BSAPCUser convertFromUserModel:userUpdate] dictFromClass];
	
	BSLog(@"%@", userUpdateDictionary);
	
	[super executePUTForMethod:[BSAPIConfiguration userMe]
				withParameters:userUpdateDictionary
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSUserModel *userModel = [[BSAPCUser classFromDict:response] convertToModel];
						  
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
	BSUserModel *userUpdate = [[BSUserModel alloc] initUserWithEmail:newEmail andPassword:password];
	
	NSDictionary *userUpdateDictionary = [[BSAPCUser convertFromUserModel:userUpdate] dictFromClass];
	
	BSLog(@"%@", userUpdateDictionary);
	
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
	BSUserModel *userUpdate = [[BSUserModel alloc] initUserWithPassword:password andNewPassword:newPassword];
	
	NSDictionary *userUpdateDictionary = [[BSAPCUser convertFromUserModel:userUpdate] dictFromClass];
	
	BSLog(@"%@", userUpdateDictionary);
	
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

@end
