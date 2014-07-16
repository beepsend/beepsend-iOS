//
//  BSGroupModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSContact;

@interface BSGroup : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *groupID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *contactsCount;
@property (nonatomic, strong, readonly) NSNumber *processing;

- (BSGroup *)initGroupWithID:(NSString *)gID
						name:(NSString *)gName
					contacts:(NSNumber *)gContactsCount
				  processing:(NSNumber *)gProcessing;

- (BSGroup *)initGroupWithName:(NSString *)gName;

- (BSGroup *)initGroupWithID:(NSString *)gID
						name:(NSString *)gName
					contacts:(NSNumber *)gContactsCount;

- (void)updateGroup;
- (void)saveGroup;
- (void)removeGroup;

- (void)addContact:(BSContact *)contact;
- (void)addContacts:(NSArray *)contacts;
- (void)removeContact:(BSContact *)contact;
- (void)removeContacts:(NSArray *)contacts;

@end
