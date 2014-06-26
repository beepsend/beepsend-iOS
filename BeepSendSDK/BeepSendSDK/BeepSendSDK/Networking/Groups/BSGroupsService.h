//
//  BSGroupsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSGroupModel.h"
#import "BSUserModel.h"
#import "BSContactModel.h"

@interface BSGroupsService : BSBaseService

- (void)getAllGroupsWithCompletionBlock:(void(^)(NSArray *groups, id error))block;

- (void)getDetailsForGroup:(NSString *)groupID withCompletionBlock:(void(^)(BSGroupModel *group, id error))block;

- (void)addGroupNamed:(NSString *)groupName withCompletionBlock:(void(^)(BSGroupModel *group, id error))block;

- (void)updateName:(NSString *)gName inGroup:(BSGroupModel *)group withCompletionBlock:(void(^)(BSGroupModel *group, id error))block;

- (void)deleteGroup:(BSGroupModel *)group withCompletionBlock:(void(^)(BOOL success, id error))block;

@end
