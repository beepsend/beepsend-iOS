//
//  ContactsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSContact.h"
#import "BSGroup.h"
#import "BSError.h"

@interface BSContactsService : NSObject

- (void)getAllContactsWithCompletionBlock:(void(^)(NSArray *contacts, NSArray *errors))block;
- (void)getAllContactsInGroup:(NSString *)groupID
					  sinceID:(NSString *)since
						maxID:(NSString *)max
				 contactCount:(NSNumber *)count
					   offset:(NSNumber *)offset
						 sort:(NSString *)sort
		  withCompletionBlock:(void(^)(NSArray *contacts, NSArray *errors))block;

- (void)addContact:(BSContact *)contact withCompletionBlock:(void(^)(BSContact *contact, NSArray *errors))block;

- (void)addContacts:(NSArray *)contacts withCompletionBlock:(void(^)(NSArray *contacts, NSArray *errors))block;

- (void)updateContact:(BSContact *)contact
		   withNumber:(NSString *)number
			firstName:(NSString *)firstName
			 lastName:(NSString *)lastName
			  groupID:(NSString *)groupID
  withCompletionBlock:(void(^)(BSContact *contact, NSArray *errors))block;

- (void)deleteContact:(BSContact *)contact withCompletionBlock:(void(^)(BOOL success, NSArray *errors))block;

- (void)searchContact:(NSString *)query
			  inGroup:(BSGroup *)group
				limit:(NSUInteger)limit
  withCompletionBlock:(void(^)(NSArray *results, NSArray *errors))block;

@end
