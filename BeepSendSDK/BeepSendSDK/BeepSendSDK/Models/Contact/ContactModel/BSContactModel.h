//
//  BSContactModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSContactModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *firstName;
@property (nonatomic, strong, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *phoneNumber;
@property (nonatomic, strong, readonly) NSNumber *groupID;
@property (nonatomic, strong, readonly) NSString *groupName;
@property (nonatomic, strong, readonly) NSArray *errors;

- (BSContactModel *)initContactWithID:(NSString *)cID
							firstName:(NSString *)firstName
							 lastName:(NSString *)lastName
						  phoneNumber:(NSString *)phoneNumber
							  groupID:(NSNumber *)gID
							groupName:(NSString *)groupName
							   errors:(NSArray *)errors;

- (BSContactModel *)initContactWithFirstName:(NSString *)firstName
									lastName:(NSString *)lastName
								 phoneNumber:(NSString *)phoneNumber
									 groupID:(NSNumber *)gID
								   groupName:(NSString *)groupName
									  errors:(NSArray *)errors;

@end
