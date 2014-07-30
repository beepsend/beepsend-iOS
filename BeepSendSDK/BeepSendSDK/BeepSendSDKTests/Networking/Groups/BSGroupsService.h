//
//  BSGroupsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSGroup.h"
#import "BSContact.h"
#import "BSError.h"

@interface BSGroupsService : BSBaseService

- (void)getAllGroupsWithCompletionBlock:(void(^)(NSArray *groups, NSArray *errors))block;
- (void)getAllGroupsSinceID:(NSString *)sinceID
					  maxID:(NSString *)maxID
					  count:(NSNumber *)count
		withCompletionBlock:(void(^)(NSArray *groups, NSArray *errors))block;

- (void)getDetailsForGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block;
- (void)getDetailsForGroupID:(NSString *)groupID withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block;

- (void)addGroupNamed:(NSString *)groupName withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block;

- (void)updateName:(NSString *)gName inGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, NSArray *errors))block;

- (void)deleteGroup:(BSGroup *)group withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block;

- (void)searchContactGroups:(NSString *)query
					  limit:(NSUInteger)limit
		withCompletionBlock:(void(^)(NSArray *results, NSArray *errors))block;

@end
