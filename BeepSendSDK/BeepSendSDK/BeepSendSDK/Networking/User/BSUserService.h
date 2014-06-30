//
//  BSUserService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSUserModel.h"
#import "BSUserTypeModel.h"

@interface BSUserService : BSBaseService

- (void)getUserDetailsWithCompletionBlock:(void(^)(BSUserModel *user, id error))block;

- (void)updateUserWithName:(NSString *)uName
					 phone:(NSString *)uPhone
		 defaultConnection:(BSConnectionModel *)uConnection
				 userTypes:(NSArray *)uTypes
			 verifiedTerms:(NSNumber *)uVerifiedTerms
	   withCompletionBlock:(void(^)(BSUserModel *user, id error))block;

- (void)updateUserEmail:(NSString *)newEmail
		   userPassword:(NSString *)password
	withCompletionBlock:(void(^)(BOOL success, id error))block;

- (void)updateUserPassword:(NSString *)password
		   userNewPassword:(NSString *)newPassword
	   withCompletionBlock:(void(^)(BOOL success, id error))block;

- (void)resetUserTokenWithCompletionBlock:(void(^)(NSString *apiToken, id error))block;

@end
