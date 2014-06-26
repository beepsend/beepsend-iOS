//
//  BSContactModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSContactModel.h"

@interface BSContactModel ()

@property (nonatomic, strong, readwrite) NSString *firstName;
@property (nonatomic, strong, readwrite) NSString *lastName;
@property (nonatomic, strong, readwrite) NSString *phoneNumber;
@property (nonatomic, strong, readwrite) NSNumber *groupID;
@property (nonatomic, strong, readwrite) NSString *groupName;
@property (nonatomic, strong, readwrite) NSArray *errors;

@end

@implementation BSContactModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular contact"]) {
		
	}
	return self;
}

- (BSContactModel *)initContactWithID:(NSString *)cID
							firstName:(NSString *)firstName
							 lastName:(NSString *)lastName
						  phoneNumber:(NSString *)phoneNumber
							  groupID:(NSNumber *)gID
							groupName:(NSString *)groupName
							   errors:(NSArray *)errors
{
	if (self = [super initWithID:cID andTitle:firstName]) {
		_firstName = firstName;
		_lastName = lastName;
		_phoneNumber = phoneNumber;
		_groupID = gID;
		_groupName = groupName;
		_errors = errors;
	}
	return self;
}

- (BSContactModel *)initContactWithPhoneNumber:(NSString *)phoneNumber
									 firstName:(NSString *)firstName
									  lastName:(NSString *)lastName
									   groupID:(NSNumber *)groupID
{
	if (self = [super initWithID:@"0" andTitle:firstName]) {
		_firstName = firstName;
		_lastName = lastName;
		_phoneNumber = phoneNumber;
		_groupID = groupID;
	}
	return self;
}

@end
