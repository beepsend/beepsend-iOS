//
//  APConnection.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPCCallback.h"
#import "BSAPWallet.h"

@class BSConnectionModel;

@interface BSAPConnection : BSSerializableObject

@property (nonatomic, strong) NSString *api_token;
@property (nonatomic, strong) BSAPCCallback *callbacks;
@property (nonatomic, strong) NSString *customer;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *system_id;
@property (nonatomic, strong) NSNumber *tlv_for_mcc_mnc;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) BSAPWallet *wallet;
@property (nonatomic, strong) NSString *whitelist;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;
+ (NSArray *)arrayOfModelsFromArrayOfObjects:(NSArray *)array;

+ (BSAPConnection *)convertFromConnectionModel:(BSConnectionModel *)connectionModel;

@end
