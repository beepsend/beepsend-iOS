//
//  ContactsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSContactModel.h"

@interface BSContactsService : BSBaseService

- (void)getAllContactsWithCompletionBlock:(void(^)(NSArray *contacts, id error))block;

- (void)addContact:(BSContactModel *)contact withCompletionBlock:(void(^)(BSContactModel *contact, id error))block;

- (void)addContacts:(NSArray *)contacts withCompletionBlock:(void(^)(NSArray *contacts, id error))block;

- (void)updateContact:(BSContactModel *)contact
		   withNumber:(NSString *)number
			firstName:(NSString *)firstName
			 lastName:(NSString *)lastName
			  groupID:(NSNumber *)groupID
  withCompletionBlock:(void(^)(BSContactModel *contact, id error))block;

- (void)deleteContact:(BSContactModel *)contact withCompletionBlock:(void(^)(BOOL success, id error))block;

@end
