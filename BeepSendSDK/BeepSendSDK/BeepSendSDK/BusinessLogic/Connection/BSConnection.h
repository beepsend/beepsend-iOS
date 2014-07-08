//
//  BSConnection.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSStructs.h"

@class BSWallet;

@interface BSConnection : NSObject

@property (nonatomic, strong, readonly) NSString *connectionID;
@property (nonatomic, assign, readonly) BSConnectionType type;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *systemID;//Login name

@property (nonatomic, assign) BOOL defaultConnection;

@property (nonatomic, strong) NSArray *users;

@property (nonatomic, strong, readonly) BSWallet *wallet;

- (BSConnection *)initWithToken:(NSString *)apiToken;

//Accessible only if User is initated with apiToken
- (BSConnection *)initDefaultConnection;

- (BSConnection *)initWIthID:(NSString *)cID andConnectionType:(BSConnectionType)cType;

@end
