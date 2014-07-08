//
//  BSConnection.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSConnection.h"

#import "BSTestSemaphor.h"

#import "BSConnectionsService.h"
#import "BSUserModel.h"

#import "BSUser.h"

@interface BSConnection ()

@property (nonatomic, strong) BSConnectionModel *defaultConnectionModel;

@end

@implementation BSConnection

- (BSConnection *)initWithToken:(NSString *)apiToken
{
	if (self = [super init]) {
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"API_TOKEN" : apiToken }];
		
		[[BSConnectionsService sharedService] getMeConnectionOnCompletion:^(BSConnectionModel *connection, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchConnection"];
			
			_defaultConnectionModel = connection;
			
			_connectionID = connection.objectID;
			_type = connection.type;
			_label = connection.label;
			_description = connection.description;
			_systemID = connection.systemID;
			
			NSMutableArray *mArr = [@[] mutableCopy];
			for (BSUserModel *user in connection.users) {
				
				BSUser *u = [[BSUser alloc] initWithUserID:user.objectID];
				u.name = user.name;
				u.email = user.email;
				
				[mArr addObject:u];
			}
			_users = [NSArray arrayWithArray:mArr];
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnection"];
	}
	return self;
}

- (BSConnection *)initDefaultConnection {
	if (self = [super init]) {
		
		[[BSConnectionsService sharedService] getMeConnectionOnCompletion:^(BSConnectionModel *connection, id error) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchConnection"];
			
			_defaultConnectionModel = connection;
			
			_connectionID = connection.objectID;
			_type = connection.type;
			_label = connection.label;
			_description = connection.description;
			_systemID = connection.systemID;
			
			NSMutableArray *mArr = [@[] mutableCopy];
			for (BSUserModel *user in connection.users) {
				
				BSUser *u = [[BSUser alloc] initWithUserID:user.objectID];
				u.name = user.name;
				u.email = user.email;
				
				[mArr addObject:u];
			}
			_users = [NSArray arrayWithArray:mArr];
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnection"];
	}
	return self;
}

- (BSConnection *)initWIthID:(NSString *)cID andConnectionType:(BSConnectionType)cType
{
	if (self = [super init]) {
		_connectionID = cID;
		_type = cType;
	}
	return self;
}

@end
