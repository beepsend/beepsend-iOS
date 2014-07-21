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

@property (nonatomic, strong, readonly) NSString *contactID;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong, readonly) NSArray *errors;

@property (nonatomic, strong) BSGroup *group;

- (BSContact *)initContactWithID:(NSString *)cID
					   firstName:(NSString *)firstName
						lastName:(NSString *)lastName
					 phoneNumber:(NSString *)phoneNumber
						   group:(BSGroup *)group
						  errors:(NSArray *)errors;

- (BSContact *)initContactWithPhoneNumber:(NSString *)phoneNumber
								firstName:(NSString *)firstName
								 lastName:(NSString *)lastName
									group:(BSGroup *)group;

- (void)updateContact;
- (void)saveContact;
- (void)removeContact;

@end
