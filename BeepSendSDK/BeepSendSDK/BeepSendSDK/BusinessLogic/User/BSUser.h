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

@property (nonatomic, strong, readonly) NSString *userID;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) BSConnection *defaultConnection;

- (BSUser *)initWithToken:(NSString *)apiToken;

- (BSUser *)initWithUserID:(NSString *)uID;

- (void)updateUser;
- (void)resetUserTokenWithPassword:(NSString *)password;

//Async
- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections))block;
//Sync
- (NSArray *)getAvailableConnections;

@end
