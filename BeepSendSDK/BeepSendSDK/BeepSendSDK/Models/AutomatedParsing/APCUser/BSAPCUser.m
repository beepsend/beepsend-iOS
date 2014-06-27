//
//  APCUser.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPCUser.h"

#import "BSAPUserType.h"

#import "BSUserTypeModel.h"

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

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPCUser classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

- (BSUserModel *)convertToUserModel
{
	BSVerifiedModel *verified =
	[[BSVerifiedModel alloc] initUserWithEmailVerified:[_verified.email boolValue]
										 phoneVerified:[_verified.phone boolValue]
										 termsVerified:[_verified.terms boolValue]];
	
	BSConnectionModel *connection =
	[[BSConnectionModel alloc] initConnectionWithID:_default_connection.id
											  label:_default_connection.label
										   systemID:_default_connection.system_id
											   type:(BSConnectionType)_default_connection.type.integerValue];
	
	NSMutableArray *mUserTypes = [@[] mutableCopy];
	for (BSAPUserType *uType in _user_types) {
		BSUserTypeModel *userType = [[BSUserTypeModel alloc] initUserTypeWithID:uType.id
																		   name:uType.name];
		[mUserTypes addObject:userType];
	}
	
	BSUserModel *usrModel =
	[[BSUserModel alloc] initUserWithID:_id
								   name:_name
								  email:_email
								  phone:_phone
							   customer:_customer
							   apiToken:_api_token
					  defaultConnection:connection
							  userTypes:[NSArray arrayWithArray:mUserTypes]
							   maxLevel:_max_level
							   verified:verified];
	
	return usrModel;
}

+ (BSAPCUser *)convertFromConnectionModel:(BSUserModel *)userModel
{
	
	BSAPCUser *user = [[BSAPCUser alloc] init];
	
	if ([userModel.objectID isEqualToString:@"-1"]) {
		return user;
	}
	
	user.id = [userModel.objectID isEqualToString:@"0"] ? nil : userModel.objectID;
	user.name = userModel.name;
	user.username = userModel.email;
	user.email = userModel.email;
	user.phone = userModel.phoneNumber;
	user.customer = userModel.customer;
	user.api_token = userModel.apiToken;
	
	user.password = userModel.password;
	user.new_password = userModel.theNewPassword;
	
	BSAPConnection *defaultConnection = [BSAPConnection convertFromConnectionModel:userModel.defaultConnection];
	user.default_connection = defaultConnection;
	
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSUserTypeModel *uType in userModel.userTypes) {
		BSAPUserType *ut = [[BSAPUserType alloc] init];
		
		ut.id = uType.objectID;
		ut.name = uType.name;
		
		[mArr addObject:ut];
	}
	user.user_types = [NSArray arrayWithArray:mArr];
	
	user.max_level = userModel.maxLevel;
	
	BSAPVerified *verified = [[BSAPVerified alloc] init];
	if (userModel.verified) {
		verified.terms = [NSNumber numberWithBool:userModel.verified.termsVerified];
		verified.email = [NSNumber numberWithBool:userModel.verified.emailVerified];
		verified.phone = [NSNumber numberWithBool:userModel.verified.phoneVerified];
	}
	user.verified = verified;
	
	return user;
}

@end
