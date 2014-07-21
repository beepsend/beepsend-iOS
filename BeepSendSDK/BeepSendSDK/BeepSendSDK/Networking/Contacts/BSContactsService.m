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

- (void)getAllContactsWithCompletionBlock:(void(^)(NSArray *contacts, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration contacts]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPContact *con in [BSAPContact arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[con convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getAllContactsInGroup:(NSString *)groupID
					  sinceID:(NSString *)since
						maxID:(NSString *)max
				 contactCount:(NSNumber *)count
					   offset:(NSNumber *)offset
						 sort:(NSString *)sort
		  withCompletionBlock:(void(^)(NSArray *contacts, id error))block
{
	BSAPContactsRequests *request = [[BSAPContactsRequests alloc] init];
	request.group = groupID;
	request.since_id = since;
	request.max_id = max;
	request.count = count;
	request.offset = offset;
	request.sort = sort;
	
	[super executeGETForMethod:[BSAPIConfiguration contacts]
				withParameters:[request dictFromClass]
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPContact *con in [BSAPContact arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[con convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)addContact:(BSContact *)contact withCompletionBlock:(void(^)(BSContact *contact, id error))block
{
	NSDictionary *contactToAdd = [[BSAPContact contactFromContactModel:contact] dictFromClass];
	
	[super executePOSTForMethod:[BSAPIConfiguration contacts]
				withParameters:contactToAdd
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPContact classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)addContacts:(NSArray *)contacts withCompletionBlock:(void(^)(NSArray *contacts, id error))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSContact *model in contacts) {
		[mArr addObject:[[BSAPContact contactFromContactModel:model] dictFromClass]];
	}
	
	[super executePOSTForMethod:[BSAPIConfiguration contacts]
				 withParameters:mArr
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   
						   block(response, error);
					   }
					   else {
						   //TODO: Create error handling
						   block(nil, response);
					   }
				   }];
}


- (void)updateContact:(BSContact *)contact
		   withNumber:(NSString *)number
			firstName:(NSString *)firstName
			 lastName:(NSString *)lastName
			  groupID:(NSString *)groupID
  withCompletionBlock:(void(^)(BSContact *contact, id error))block
{
	
	NSDictionary *contactToUpdate = [[BSAPContact contactFromContactModel:[[BSContact alloc] initContactWithPhoneNumber:number?number:contact.phoneNumber firstName:firstName lastName:lastName group:[[BSGroup alloc] initGroupWithID:groupID name:nil contacts:nil]]] dictFromClass];
	
	[super executePUTForMethod:[BSAPIConfiguration contactsForID:contact.objectID]
				withParameters:contactToUpdate
				  onCompletion:^(id response, id error) {
					   
					  if (!error) {
					   
						  block([[BSAPContact classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)deleteContact:(BSContact *)contact withCompletionBlock:(void(^)(BOOL success, id error))block
{
	[super executeDELETEForMethod:[BSAPIConfiguration contactsForID:contact.objectID]
				   withParameters:@{}
					 onCompletion:^(id response, id error) {
					  
						 if (!error) {
						  
							 block(YES, response);
						 }
						 else {
							 //TODO: Create error handling
							 block(NO, response);
						 }
					 }];
}

- (void)searchContact:(NSString *)query
			  inGroup:(BSGroup *)group
				limit:(NSUInteger)limit
  withCompletionBlock:(void(^)(NSArray *results, id error))block
{
	NSMutableDictionary *parameters = [@{} mutableCopy];
	[parameters setObject:query forKey:@"query"];
	
	if (group) {
		[parameters setObject:group.objectID forKey:@"group_id"];
	}
	
	if (limit != 0) {
		[parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
	}
	
	[super executeGETForMethod:[BSAPIConfiguration searchContacts]
				withParameters:parameters
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPContact *con in [BSAPContact arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[con convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

@end
