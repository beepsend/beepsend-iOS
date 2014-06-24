
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

#import "BSUserTypeModel.h"

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
						  
						  BSUserModel *userModel = [[BSAPCUser classFromDict:response] convertToUserModel];
						  
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
			 verifiedTerms:(BOOL)uVerifiedTerms
	   withCompletionBlock:(void(^)(BSUserModel *user, id error))block
{
	
	BSConnectionModel *connection = [[BSConnectionModel alloc] initConnectionWithID:uConnection.objectID];
	
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSUserTypeModel *uType in uTypes) {
		BSUserTypeModel *t = [[BSUserTypeModel alloc] initUserTypeWithID:uType.objectID];
		[mArr addObject:t];
	}
	
	BSVerifiedModel *verified = [[BSVerifiedModel alloc] initUserWithTermsVerified:uVerifiedTerms];
	
	BSUserModel *userUpdate =
	[[BSUserModel alloc] initWithName:uName
								phone:uPhone
					defaultConnection:connection
							userTypes:[NSArray arrayWithArray:mArr]
							 verified:verified];
	
	BSAPCUser *user = [BSAPCUser convertFromConnectionModel:userUpdate];
	
	BSLog(@"%@", [user dictFromClass]);
	
	[super executePUTForMethod:[BSAPIConfiguration userMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSUserModel *userModel = [[BSAPCUser classFromDict:response] convertToUserModel];
						  
						  block(userModel, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

@end
