//
//  BSContactModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSContact : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *contactID;
@property (nonatomic, strong, readonly) NSString *firstName;
@property (nonatomic, strong, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *phoneNumber;
@property (nonatomic, strong, readonly) NSString *groupID;
@property (nonatomic, strong, readonly) NSString *groupName;
@property (nonatomic, strong, readonly) NSArray *errors;

- (BSContact *)initContactWithID:(NSString *)cID
					   firstName:(NSString *)firstName
						lastName:(NSString *)lastName
					 phoneNumber:(NSString *)phoneNumber
						 groupID:(NSString *)gID
					   groupName:(NSString *)groupName
						  errors:(NSArray *)errors;

- (BSContact *)initContactWithPhoneNumber:(NSString *)phoneNumber
								firstName:(NSString *)firstName
								 lastName:(NSString *)lastName
								  groupID:(NSString *)groupID;

@end
