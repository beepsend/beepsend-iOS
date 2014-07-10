//
//  BSGroupsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSGroupModel.h"
#import "BSContactModel.h"

@interface BSGroupsService : BSBaseService

- (void)getAllGroupsWithCompletionBlock:(void(^)(NSArray *groups, id error))block;
- (void)getAllGroupsSinceID:(NSString *)sinceID
					  maxID:(NSString *)maxID
					  count:(NSNumber *)count
		withCompletionBlock:(void(^)(NSArray *groups, id error))block;


- (void)getDetailsForGroup:(BSGroupModel *)group withCompletionBlock:(void(^)(BSGroupModel *group, id error))block;
- (void)getDetailsForGroupID:(NSString *)groupID withCompletionBlock:(void(^)(BSGroupModel *group, id error))block;

- (void)addGroupNamed:(NSString *)groupName withCompletionBlock:(void(^)(BSGroupModel *group, id error))block;

- (void)updateName:(NSString *)gName inGroup:(BSGroupModel *)group withCompletionBlock:(void(^)(BSGroupModel *group, id error))block;

- (void)deleteGroup:(BSGroupModel *)group withCompletionBlock:(void(^)(BOOL success, id error))block;

- (void)searchContactGroups:(NSString *)query
					  limit:(NSUInteger)limit
		withCompletionBlock:(void(^)(NSArray *results, id error))block;

@end
