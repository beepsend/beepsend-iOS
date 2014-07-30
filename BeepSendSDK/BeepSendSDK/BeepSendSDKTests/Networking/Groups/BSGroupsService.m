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
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPGroup *group in [BSAPGroup arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@1,@"name":@"Customers",@"contacts_count":@27,@"processing":@1},@{@"id":@2,@"name":@"Others",@"contacts_count":@2,@"processing":@0}]]) {
		[mArr addObject:[group convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getAllGroupsSinceID:(NSString *)sinceID
					  maxID:(NSString *)maxID
					  count:(NSNumber *)count
		withCompletionBlock:(void(^)(NSArray *groups, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPGroup *group in [BSAPGroup arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@1,@"name":@"Customers",@"contacts_count":@27,@"processing":@1},@{@"id":@2,@"name":@"Others",@"contacts_count":@2,@"processing":@0}]]) {
		[mArr addObject:[group convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getDetailsForGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block
{
	block(group, nil);
}

- (void)getDetailsForGroupID:(NSString *)groupID withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block
{
	block([[BSGroup alloc] initGroupWithID:groupID name:@"nameg" contacts:@2], nil);
}

- (void)addGroupNamed:(NSString *)groupName withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block
{
	block([[BSGroup alloc] initGroupWithID:@1 name:groupName contacts:@2], nil);
}

- (void)updateName:(NSString *)gName inGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block
{
	group.name = gName;
	block(group, nil);
}

- (void)deleteGroup:(BSGroup *)group withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block
{
	block(YES, nil);
}

- (void)searchContactGroups:(NSString *)query
					  limit:(NSUInteger)limit
		withCompletionBlock:(void(^)(NSArray *results, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPContact *con in [BSAPContact arrayOfObjectsFromArrayOfDictionaries:@[@{@"id":@1,@"name":query,@"contacts_count":@27,@"processing":@1},@{@"id":@2,@"name":query,@"contacts_count":@2,@"processing":@0}]]) {
		  [mArr addObject:[con convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

@end
