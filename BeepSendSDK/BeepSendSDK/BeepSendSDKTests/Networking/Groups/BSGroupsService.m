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

- (void)getAllGroupsWithCompletionBlock:(void(^)(NSArray *groups, NSArray *errors))block
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
						  
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getAllGroupsSinceID:(NSString *)sinceID
					  maxID:(NSString *)maxID
					  count:(NSNumber *)count
		withCompletionBlock:(void(^)(NSArray *groups, NSArray *errors))block
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
						  
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getDetailsForGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block
{
	[self getDetailsForGroupID:group.objectID withCompletionBlock:^(BSGroup *group, id error) {
		block(group, error);
	}];
}

- (void)getDetailsForGroupID:(NSString *)groupID withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration contactsGroupsForID:groupID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
	
						  block([[BSAPGroup classFromDict:response] convertToModel], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)addGroupNamed:(NSString *)groupName withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block
{
	NSDictionary *dict = [[BSAPGroup groupFromGroupModel:[[BSGroup alloc] initGroupWithName:groupName]] dictFromClass];
	BSDLog(@"%@", dict);
	
	[super executePOSTForMethod:[BSAPIConfiguration contactsGroups]
				 withParameters:dict
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPGroup classFromDict:response] convertToModel], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)updateName:(NSString *)gName inGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block
{
	NSDictionary *dict = [[BSAPGroup groupFromGroupModel:[[BSGroup alloc] initGroupWithName:gName]] dictFromClass];
	BSDLog(@"%@", dict);
	
	[super executePUTForMethod:[BSAPIConfiguration contactsGroupsForID:group.objectID]
				 withParameters:dict
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   
						   block([[BSAPGroup classFromDict:response] convertToModel], nil);
					   }
					   else {

						   block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					   }
				   }];
}

- (void)deleteGroup:(BSGroup *)group withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	[super executeDELETEForMethod:[BSAPIConfiguration contactsGroupsForID:group.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block(YES, nil);
					  }
					  else {

						  block(NO, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)searchContactGroups:(NSString *)query
					  limit:(NSUInteger)limit
		withCompletionBlock:(void(^)(NSArray *results, NSArray *errors))block
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
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

@end
