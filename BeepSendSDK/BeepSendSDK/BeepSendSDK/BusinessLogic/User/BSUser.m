//
//  BSUser.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUser.h"

#import "BSInputData.h"

#import "BSUserService.h"
#import "BSConnectionsService.h"

#import "BSTestSemaphor.h"

#import "BSConnection.h"

@interface BSUser ()

@property (nonatomic, strong) BSUserModel *currentUser;

@property (nonatomic, strong) NSArray *connections;

@end

@implementation BSUser

#pragma mark - Properties

- (NSString *)name {
	return _currentUser.name;
}

- (NSString *)phone {
	return _currentUser.phoneNumber;
}

- (NSString *)email {
	return _currentUser.email;
}

- (BSConnection *)defaultConnection {
	if (_defaultConnection) {
		return _defaultConnection;
	}
	return _defaultConnection = [[BSConnection alloc] initDefaultConnection];
}

#pragma mark - Initialization

- (BSUser *)init
{
	if (self = [super init]) {
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"API_TOKEN" : APIToken }];
		
		[[BSUserService sharedService] getUserDetailsWithCompletionBlock:^(BSUserModel *user, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchUser"];
			
			_currentUser = user;
			
			_name = user.name;
			_email = user.email;
			_phone = user.phoneNumber;
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchUser"];
		
	}
	return self;
}

+ (BSUser *)currentUser
{
	static BSUser *singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[BSUser alloc] init];
	});
	return singleton;
}

- (BSUser *)initWithUserID:(NSString *)uID
{
	if (self = [super init]) {
		_userID = uID;
	}
	return self;
}

#pragma mark - Public methods

- (void)updateUser
{
	BSConnection *connectionModel;
	if (![_defaultConnection.connectionID isEqualToString:_currentUser.defaultConnection.objectID]) {
		connectionModel = [[BSConnection alloc] initConnectionWithID:_defaultConnection.connectionID];
	}
	[[BSUserService sharedService] updateUserWithName:[_name isEqualToString:_currentUser.name]?nil:_name
												phone:[_phone isEqualToString:_currentUser.phoneNumber]?nil:_phone
									defaultConnection:connectionModel
											userTypes:nil
										verifiedTerms:nil withCompletionBlock:^(BSUserModel *user, id error) {
											
											_currentUser = user;
											
											_name = user.name;
											_email = user.email;
											_phone = user.phoneNumber;
											
	}];
}

- (void)resetUserTokenWithPassword:(NSString *)password
{
	[[BSUserService sharedService] resetUserTokenUsingPassword:password withCompletionBlock:^(NSString *apiToken, id error) {
		[[NSUserDefaults standardUserDefaults] setObject:apiToken forKey:@"API_TOKEN"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}];
}

- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections))block
{
	[[BSConnectionsService sharedService] getAllAvailableConnectsionOnCompletion:^(NSArray *connections, id error) {
		BSLog(@"%@", connections);
		
//		NSMutableArray *mArr = [@[] mutableCopy];
//		for (BSConnectionModel *cm in connections) {
//			
//			BSConnection *connection = [[BSConnection alloc] initWIthID:cm.objectID andConnectionType:cm.type];
//			connection.label = cm.label;
//			connection.description = cm.description;
//			connection.systemID = cm.systemID;
//			
//			[mArr addObject:connection];
//		}
//		_connections = [NSArray arrayWithArray:mArr];
		
		block(_connections);
	}];
}

- (NSArray *)getAvailableConnections
{
	if (_connections) {
		return _connections;
	}
	else {
		[[BSConnectionsService sharedService] getAllAvailableConnectsionOnCompletion:^(NSArray *connections, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchConnections"];
			
//			NSMutableArray *mArr = [@[] mutableCopy];
//			for (BSConnectionModel *cm in connections) {
//				
//				BSConnection *connection = [[BSConnection alloc] initWIthID:cm.objectID andConnectionType:cm.type];
//				connection.label = cm.label;
//				connection.description = cm.description;
//				connection.systemID = cm.systemID;
//				
//				[mArr addObject:connection];
//			}
//			_connections = [NSArray arrayWithArray:mArr];
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnections"];
		
		return _connections;
	}
}

@end
