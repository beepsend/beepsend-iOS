//
//  BSAPContact.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPContact.h"

#import "BSContact.h"
#import "BSGroup.h"

#import "BSAPError.h"

@implementation BSAPContact

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load

	BSAPContact *contact = [super classFromDict:dictionary];
	contact.errors = [BSAPError arrayOfObjectsFromArrayOfDictionaries:contact.errors];
	
	return contact;
}

- (id)convertToModel
{
	return [[BSContact alloc] initContactWithID:_id firstName:_firstname lastName:_lastname phoneNumber:_msisdn group:[[BSGroup alloc] initGroupWithID:_group_id name:_group_name contacts:nil] errors:[BSAPError arrayOfModelsFromArrayOfObjects:_errors]];
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
	
	contact.id = [contactModel.contactID isEqualToString:@"0"] ? nil : contactModel.contactID;
	contact.firstname = [contactModel.firstName isEqualToString:@""] ? nil : contactModel.firstName;
	contact.lastname = [contactModel.lastName isEqualToString:@""] ? nil : contactModel.lastName;
	contact.msisdn = [contactModel.phoneNumber isEqualToString:@""] ? nil : contactModel.phoneNumber;
	contact.group_id = [contactModel.group.groupID isEqualToString:@"0"] ? nil : contactModel.group.groupID;
	contact.group_name = [contactModel.group.name isEqualToString:@""] ? nil : contactModel.group.name;
	contact.errors = contactModel.errors.count == 0 ? nil : contactModel.errors;
	
	return contact;
}

@end
