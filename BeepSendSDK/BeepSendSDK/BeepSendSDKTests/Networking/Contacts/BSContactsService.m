//
//  ContactsService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSContactsService.h"

#import "BSAPIConfiguration.h"

#import "BSAPContact.h"
#import "BSAPContactsRequests.h"

@implementation BSContactsService

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

- (void)getAllContactsWithCompletionBlock:(void(^)(NSArray *contacts, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPContact *con in [BSAPContact arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@22594418,@"msisdn":@"46736007518",@"name":@"Phone",@"group_id":[NSNull null],@"group_name":[NSNull null]},@{@"id":@22594419,@"msisdn":@"46736007519",@"name":@"Phone",@"group_id":[NSNull null],@"group_name":[NSNull null]},@{@"id":@22594420,@"msisdn":@"46736007520",@"name":@"Phone",@"group_id":[NSNull null],@"group_name":[NSNull null]}]]) {
		[mArr addObject:[con convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getAllContactsInGroup:(NSString *)groupID
					  sinceID:(NSString *)since
						maxID:(NSString *)max
				 contactCount:(NSNumber *)count
					   offset:(NSNumber *)offset
						 sort:(NSString *)sort
		  withCompletionBlock:(void(^)(NSArray *contacts, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPContact *con in [BSAPContact arrayOfObjectsFromArrayOfDictionaries:@[
  @{
	  @"id":@22594418,
	  @"msisdn":@"46736007518",
	  @"name":@"Phone",
	  @"group_id":groupID?groupID:@"",
	  @"group_name":@"nameg"
	  },@{
	  @"id":@22594419,
	  @"msisdn":@"46736007519",
	  @"name":@"Phone",
	  @"group_id":groupID?groupID:@"",
	  @"group_name":@"nameg"
	  },@{
	  @"id":@22594420,
	  @"msisdn":@"46736007520",
	  @"name":@"Phone",
	  @"group_id":groupID?groupID:@"",
	  @"group_name":@"nameg"}]]) {
		[mArr addObject:[con convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)addContact:(BSContact *)contact
withCompletionBlock:(void(^)(BSContact *contact, NSArray *errors))block
{
	BSContact *co = [[BSContact alloc] initContactWithID:@"213" firstName:contact.firstName lastName:contact.lastName phoneNumber:contact.phoneNumber group:nil errors:nil];
	block(co, nil);
}

- (void)addContacts:(NSArray *)contacts
withCompletionBlock:(void(^)(NSArray *cts, NSArray *errors))block
{
	block(contacts, nil);
}

- (void)updateContact:(BSContact *)contact
		   withNumber:(NSString *)number
			firstName:(NSString *)firstName
			 lastName:(NSString *)lastName
			  groupID:(NSString *)groupID
  withCompletionBlock:(void(^)(BSContact *contact, NSArray *errors))block
{
	contact.phoneNumber = number;
	contact.firstName = firstName;
	contact.lastName = lastName;
	contact.group = [[BSGroup alloc] initGroupWithID:groupID name:@"nameg" contacts:@0];
	
	block(contact, nil);
}

- (void)deleteContact:(BSContact *)contact
  withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	block(YES, nil);
}

- (void)searchContact:(NSString *)query
			  inGroup:(BSGroup *)group
				limit:(NSUInteger)limit
  withCompletionBlock:(void(^)(NSArray *results, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPContact *con in [BSAPContact arrayOfObjectsFromArrayOfDictionaries:
  @[
  @{
	  @"id":@22594418,
	  @"msisdn":@"46736007518",
	  @"name":query,
	  @"group_id":[NSNull null],
	  @"group_name":[NSNull null]
	  },@{
	  @"id":@22594419,
	  @"msisdn":@"46736007519",
	  @"name":query,
	  @"group_id":[NSNull null],
	  @"group_name":[NSNull null]
	  },@{
	  @"id":@22594420,
	  @"msisdn":@"46736007520",
	  @"name":query,
	  @"group_id":[NSNull null],
	  @"group_name":[NSNull null]
	  }]]) {
		[mArr addObject:[con convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

@end
