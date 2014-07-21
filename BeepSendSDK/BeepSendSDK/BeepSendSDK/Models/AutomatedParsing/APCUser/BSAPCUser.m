//
//  APCUser.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPCUser.h"

#import "BSAPUserType.h"

#import "BSUser.h"
#import "BSUserType.h"
#import "BSVerified.h"

@implementation BSAPCUser

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPConnection class];
	[BSAPVerified class];
	
	BSAPCUser *user = [super classFromDict:dictionary];
	
	user.user_types = [BSAPUserType arrayOfObjectsFromArrayOfDictionaries:user.user_types];
	
	return user;
}

- (id)convertToModel
{
	NSMutableArray *mUserTypes = [@[] mutableCopy];
	for (BSAPUserType *uType in _user_types) {
		[mUserTypes addObject:[uType convertToModel]];
	}
	
	return [[BSUser alloc] initUserWithID:_id
									 name:_name
									email:_email?_email:_username?_username:@""
									phone:_phone
								 customer:_customer
								 apiToken:_api_token
						defaultConnection:[_default_connection convertToModel]
								userTypes:[NSArray arrayWithArray:mUserTypes]
								 maxLevel:_max_level
								 verified:[_verified convertToModel]];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPCUser classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

+ (NSArray *)arrayOfModelsFromArrayOfObjects:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[object convertToModel]];
	}
	return [NSArray arrayWithArray:results];
}

+ (BSAPCUser *)convertFromUserModel:(BSUser *)userModel
{
	
	BSAPCUser *user = [[BSAPCUser alloc] init];
	
	if ([userModel.userID isEqualToString:@"-1"]) {
		return user;
	}
	
	user.id = [userModel.userID isEqualToString:@"0"] ? nil : userModel.userID;
	user.name = userModel.name;
	user.username = userModel.email;
	user.email = userModel.email;
	user.phone = userModel.phone;
	user.customer = userModel.customerName;
	user.api_token = userModel.apiToken;
	
	user.password = userModel.password;
	user.new_password = userModel.theNewPassword;
	
	BSAPConnection *defaultConnection = [BSAPConnection convertFromConnectionModel:userModel.defaultConnection];
	user.default_connection = defaultConnection;
	
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSUserType *uType in userModel.userTypes) {
		BSAPUserType *ut = [[BSAPUserType alloc] init];
		
		ut.id = uType.objectID;
		ut.name = uType.name;
		
		[mArr addObject:ut];
	}
	user.user_types = [NSArray arrayWithArray:mArr];
	
	user.max_level = userModel.maxLevel;
	
	BSAPVerified *verified = [[BSAPVerified alloc] init];
	if (userModel.verified) {
		verified.terms = userModel.verified.termsVerified;
		verified.email = userModel.verified.emailVerified;
		verified.phone = userModel.verified.phoneVerified;
	}
	user.verified = verified;
	
	return user;
}

@end
