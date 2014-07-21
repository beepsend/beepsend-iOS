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

@interface BSGroupsService : BSBaseService

- (void)getAllGroupsWithCompletionBlock:(void(^)(NSArray *groups, id error))block;
- (void)getAllGroupsSinceID:(NSString *)sinceID
					  maxID:(NSString *)maxID
					  count:(NSNumber *)count
		withCompletionBlock:(void(^)(NSArray *groups, id error))block;

- (void)getDetailsForGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, id error))block;
- (void)getDetailsForGroupID:(NSString *)groupID withCompletionBlock:(void(^)(BSGroup *group, id error))block;

- (void)addGroupNamed:(NSString *)groupName withCompletionBlock:(void(^)(BSGroup *group, id error))block;

- (void)updateName:(NSString *)gName inGroup:(BSGroup *)group withCompletionBlock:(void(^)(BSGroup *group, id error))block;

- (void)deleteGroup:(BSGroup *)group withCompletionBlock:(void(^)(BOOL success, id error))block;

- (void)searchContactGroups:(NSString *)query
					  limit:(NSUInteger)limit
		withCompletionBlock:(void(^)(NSArray *results, id error))block;

@end
