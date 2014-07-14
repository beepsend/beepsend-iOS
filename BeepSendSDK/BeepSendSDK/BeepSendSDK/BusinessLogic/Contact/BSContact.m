//
//  BSContactModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSContact.h"

@interface BSContact ()

@property (nonatomic, strong, readwrite) NSString *firstName;
@property (nonatomic, strong, readwrite) NSString *lastName;
@property (nonatomic, strong, readwrite) NSString *phoneNumber;
@property (nonatomic, strong, readwrite) NSString *groupID;
@property (nonatomic, strong, readwrite) NSString *groupName;
@property (nonatomic, strong, readwrite) NSArray *errors;

@end

@implementation BSContact

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular contact"]) {
		
	}
	return self;
}

- (BSContact *)initContactWithID:(NSString *)cID
					   firstName:(NSString *)firstName
						lastName:(NSString *)lastName
					 phoneNumber:(NSString *)phoneNumber
						 groupID:(NSString *)gID
					   groupName:(NSString *)groupName
						  errors:(NSArray *)errors
{
	if (self = [super initWithID:cID andTitle:firstName]) {
		_contactID = cID;
		_firstName = firstName;
		_lastName = lastName;
		_phoneNumber = phoneNumber;
		_groupID = gID;
		_groupName = groupName;
		_errors = errors;
	}
	return self;
}

- (BSContact *)initContactWithPhoneNumber:(NSString *)phoneNumber
								firstName:(NSString *)firstName
								 lastName:(NSString *)lastName
								  groupID:(NSString *)groupID
{
	if (self = [super initWithID:@"0" andTitle:firstName]) {
		_contactID = @"0";
		_firstName = firstName;
		_lastName = lastName;
		_phoneNumber = phoneNumber;
		_groupID = groupID;
	}
	return self;
}

@end
