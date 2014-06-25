//
//  BSAPContact.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSContactModel.h"

@interface BSAPContact : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *msisdn;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSNumber *group_id;
@property (nonatomic, strong) NSString *group_name;
@property (nonatomic, strong) NSArray *errors;

- (BSContactModel *)convertToContactModel;
+ (BSAPContact *)contactFromContactModel:(BSContactModel *)contactModel;

@end
