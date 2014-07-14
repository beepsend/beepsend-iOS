//
//  BSGroupsService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGroupsService.h"

#import "BSAPIConfiguration.h"

#import "BSAPGroup.h"
#import "BSAPContact.h"
#import "BSAPGroupsRequest.h"

@implementation BSGroupsService

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

- (void)getAllGroupsWithCompletionBlock:(void(^)(NSArray *groups, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration contactsGroups]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPGroup *group in [BSAPGroup arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[group convertToModel]];
						  }
						  
						  BSDLog(@"%@", mArr);
						  
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getAllGroupsSinceID:(NSString *)sinceID
					  maxID:(NSString *)maxID
					  count:(NSNumber *)count
		withCompletionBlock:(void(^)(NSArray *groups, id error))block
{
	BSAPGroupsRequest *groupsRequest = [[BSAPGroupsRequest alloc] init];
	groupsRequest.since_id = sinceID;
	groupsRequest.max_id = maxID;
	groupsRequest.count = count;
	[super executeGETForMethod:[BSAPIConfiguration contactsGroups]
				withParameters:[groupsRequest dictFromClass]
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPGroup *group in [BSAPGroup arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[group convertToModel]];
						  }
						  
						  BSDLog(@"%@", mArr);
						  
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getDetailsForGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, id error))block
{
	[self getDetailsForGroupID:group.objectID withCompletionBlock:^(BSGroup *group, id error) {
		block(group, error);
	}];
}

- (void)getDetailsForGroupID:(NSString *)groupID withCompletionBlock:(void(^)(BSGroup *group, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration contactsGroupsForID:groupID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
	
						  block([[BSAPGroup classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)addGroupNamed:(NSString *)groupName withCompletionBlock:(void(^)(BSGroup *group, id error))block
{
	NSDictionary *dict = [[BSAPGroup groupFromGroupModel:[[BSGroup alloc] initGroupWithName:groupName]] dictFromClass];
	BSDLog(@"%@", dict);
	
	[super executePOSTForMethod:[BSAPIConfiguration contactsGroups]
				 withParameters:dict
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPGroup classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)updateName:(NSString *)gName inGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, id error))block
{
	NSDictionary *dict = [[BSAPGroup groupFromGroupModel:[[BSGroup alloc] initGroupWithName:gName]] dictFromClass];
	BSDLog(@"%@", dict);
	
	[super executePUTForMethod:[BSAPIConfiguration contactsGroupsForID:group.objectID]
				 withParameters:dict
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   
						   block([[BSAPGroup classFromDict:response] convertToModel], error);
					   }
					   else {
						   //TODO: Create error handling
						   block(nil, response);
					   }
				   }];
}

- (void)deleteGroup:(BSGroup *)group withCompletionBlock:(void(^)(BOOL success, id error))block
{
	[super executeDELETEForMethod:[BSAPIConfiguration contactsGroupsForID:group.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block(YES, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(NO, response);
					  }
				  }];
}

- (void)searchContactGroups:(NSString *)query
					  limit:(NSUInteger)limit
		withCompletionBlock:(void(^)(NSArray *results, id error))block
{
	NSMutableDictionary *parameters = [@{} mutableCopy];
	[parameters setObject:query forKey:@"query"];
	
	if (limit != 0) {
		[parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
	}
	
	[super executeGETForMethod:[BSAPIConfiguration searchContactGroups]
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
