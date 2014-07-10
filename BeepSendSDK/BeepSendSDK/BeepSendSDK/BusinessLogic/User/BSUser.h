//
//  BSUser.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSConnection;

@interface BSUser : NSObject

//User ID
@property (nonatomic, strong, readonly) NSString *userID;

//Editable data
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;

//Users default connection
@property (nonatomic, strong) BSConnection *defaultConnection;

//@property (nonatomic, strong, readonly) NSString *customer;

//@property (nonatomic, strong, readonly) NSString *apiToken;
//@property (nonatomic, strong, readonly) NSArray *userTypes;
//@property (nonatomic, strong, readonly) NSNumber *maxLevel;//Simple permission model. Allows access to all version 2 endpoints.
//@property (nonatomic, strong, readonly) BSVerifiedModel *verified;
//@property (nonatomic, strong, readonly) NSString *password;

//Initiate user with API token
+ (BSUser *)currentUser;

//Create user object with ID
- (BSUser *)initWithUserID:(NSString *)uID;

//After made changes with name, email, phone
//it is necessary to call method updateUser
- (void)updateUser;

//If API token is compromised use this method for token reset
- (void)resetUserTokenWithPassword:(NSString *)password;

//Async method for retrieving users connections
- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections))block;
//Sync method for retrieving users connections
- (NSArray *)getAvailableConnections;

@end
