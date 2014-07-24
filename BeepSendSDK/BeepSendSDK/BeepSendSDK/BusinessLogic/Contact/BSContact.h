//
//  BSContactModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSGroup;

@interface BSContact : BSGeneralModel

/** Contact ID.
 */
@property (nonatomic, strong, readonly) NSString *contactID;

/** Contacts first name
 */
@property (nonatomic, strong) NSString *firstName;

/** Contacts last name
 */
@property (nonatomic, strong) NSString *lastName;

/** Mobile number
 */
@property (nonatomic, strong) NSString *phoneNumber;

/** Errors
 */
@property (nonatomic, strong, readonly) NSArray *errors;

/** Group where contact belongs
 */
@property (nonatomic, strong) BSGroup *group;

/** Init Contact with ID, name, phone, group, errors
 
 @param cID - Contact ID
 @param firstName - First name
 @param lastName - Last name
 @param phoneNumber - Phone number
 @param group - Group
 @param errors - Errors
 
 @return Returns Contact object
 */
- (BSContact *)initContactWithID:(NSString *)cID
					   firstName:(NSString *)firstName
						lastName:(NSString *)lastName
					 phoneNumber:(NSString *)phoneNumber
						   group:(BSGroup *)group
						  errors:(NSArray *)errors;

/** Init Contact with name, phone, group
 
 @param phoneNumber - Phone number
 @param firstName - First name
 @param lastName - Last name
 @param group - Group
 
 @return Returns Contact object
 */
- (BSContact *)initContactWithPhoneNumber:(NSString *)phoneNumber
								firstName:(NSString *)firstName
								 lastName:(NSString *)lastName
									group:(BSGroup *)group;

/** If changes were made to contact use update method to save changes.
 */
- (void)updateContact;

/** When new contact is created use save method to save contact
 */
- (void)saveContact;

/** When contact needs to be removed use remove method to delete it
 */
- (void)removeContact;

@end
