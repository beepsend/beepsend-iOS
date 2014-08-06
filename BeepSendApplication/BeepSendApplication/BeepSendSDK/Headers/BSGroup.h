//
//  BSGroupModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSContact;

/*!
 @class BSGroup
 @discussion Group of contacts.
 Group can be created, edited or deleted.
 Contacts can be added to group or removed from group.
 */
@interface BSGroup : BSGeneralModel

/*! The id of the group.
 */
@property (nonatomic, strong, readonly) NSString *groupID;

/*! Contact group name.
 */
@property (nonatomic, strong) NSString *name;

/*! Number of contacts in the group.
 */
@property (nonatomic, strong, readonly) NSNumber *contactsCount;

/*! This flag is 1 if contacts are being imported, otherwise 0.
 */
@property (nonatomic, strong, readonly) NSNumber *processing;

/*! Create Group object
 Used for initializing group with object received from server
 
 @param gID - The id of the group
 @param gName - Contact group name
 @param gContactsCount - Number of contacts in the group
 @param gProcessing - This flag is 1 if contacts are being imported, otherwise 0
 
 @return Returns Group object
 */
- (BSGroup *)initGroupWithID:(NSString *)gID
						name:(NSString *)gName
					contacts:(NSNumber *)gContactsCount
				  processing:(NSNumber *)gProcessing;

/*! Create Group object
 When create group make sure you call saveGroup method to save it on server
 
 @param gName - Contact group name
 
 @return Returns Group object
 */
- (BSGroup *)initGroupWithName:(NSString *)gName;

/*! Create Group object
 Used when processing property is unknown
 
 @param gID - The id of the group
 @param gName - Contact group name
 @param gContactsCount - Number of contacts in the group
 
 @return Returns Group object
 */
- (BSGroup *)initGroupWithID:(NSString *)gID
						name:(NSString *)gName
					contacts:(NSNumber *)gContactsCount;

/*! If changes were made to group use update method to save changes.
 
 @param block - Return group on success or errors on failure
 */
- (void)updateGroupOnCompletion:(void(^)(BSGroup *group, NSArray *errors))block;

/*! When new group is created use save method to save group
 
 @param block - Return group on success or errors on failure
 */
- (void)saveGroupOnCompletion:(void(^)(BSGroup *group, NSArray *errors))block;

/*! When group needs to be removed use remove method to delete it
 
 @param block - Return true on success or errors on failure
 */
- (void)removeGroupOnCompletion:(void(^)(BOOL success, NSArray *errors))block;

/*! Method for adding new contact to group
 
 @param contact - Contact to add to group
 @param block - Return contact on success or errors on failure
 */
- (void)addContact:(BSContact *)contact onCompletion:(void(^)(BSContact *contact, NSArray *errors))block;

/*! Method for adding contact list to group
 
 @param contacts - Contacts to add to group
 @param block - Return contacts on success or errors on failure
 */
- (void)addContacts:(NSArray *)contacts onCompletion:(void(^)(NSArray *contacts, NSArray *errors))block;

/*! Method for removing contact from group
 
 @param contact - Contact to remove from group
 @param block - Return true on success or errors on failure
 */
- (void)removeContact:(BSContact *)contact onCompletion:(void(^)(BOOL success, NSArray *errors))block;

/*! Method for removing contact list from group
 
 @param contacts - Contacts to remove from group
 @param block - Return true on success or errors on failure
 */
- (void)removeContacts:(NSArray *)contacts onCompletion:(void(^)(BOOL success, NSArray *errors))block;;

@end
