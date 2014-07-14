//
//  BSAPContact.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPContact.h"

#import "BSContact.h"

@implementation BSAPContact

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSContact alloc] initContactWithID:_id firstName:_firstname lastName:_lastname phoneNumber:_msisdn groupID:_group_id groupName:_group_name errors:_errors];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPContact classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

+ (BSAPContact *)contactFromContactModel:(BSContact *)contactModel
{
	BSAPContact *contact = [[BSAPContact alloc] init];
	
	if ([contactModel.objectID isEqualToString:@"-1"]) {
		return contact;
	}
	
	contact.id = [contactModel.objectID isEqualToString:@"0"] ? nil : contactModel.objectID;
	contact.firstname = contactModel.firstName;
	contact.lastname = contactModel.lastName;
	contact.msisdn = contactModel.phoneNumber;
	contact.group_id = contactModel.groupID;
	contact.group_name = contactModel.groupName;
	contact.errors = contactModel.errors;
	
	return contact;
}

@end
