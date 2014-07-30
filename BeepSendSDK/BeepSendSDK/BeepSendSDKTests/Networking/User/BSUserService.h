//
//  BSUserService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSUser.h"
#import "BSUserType.h"
#import "BSConnection.h"
#import "BSError.h"

@interface BSUserService : BSBaseService

- (void)getUserDetailsWithCompletionBlock:(void(^)(BSUser *user, NSArray *errors))block;

- (void)updateUserWithName:(NSString *)uName
					 phone:(NSString *)uPhone
		 defaultConnection:(BSConnection *)uConnection
				 userTypes:(NSArray *)uTypes
			 verifiedTerms:(NSNumber *)uVerifiedTerms
	   withCompletionBlock:(void(^)(BSUser *user, NSArray *errors))block;

- (void)updateUserEmail:(NSString *)newEmail
		   userPassword:(NSString *)password
	withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block;

- (void)updateUserPassword:(NSString *)password
		   userNewPassword:(NSString *)newPassword
	   withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block;

- (void)resetUserTokenUsingPassword:(NSString *)password withCompletionBlock:(void(^)(NSString *apiToken, NSArray *errors))block;

- (void)verifyEmailWithHash:(NSString *)hash withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block;
- (void)verifyPhoneWithHash:(NSString *)hash withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block;

@end
