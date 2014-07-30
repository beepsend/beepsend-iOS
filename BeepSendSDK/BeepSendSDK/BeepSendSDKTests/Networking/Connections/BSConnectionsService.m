//
//  ConnectionsService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSConnectionsService.h"

#import "BSAPIConfiguration.h"

#import "BSAPConnection.h"

@implementation BSConnectionsService

#pragma mark - Initialization

+ (instancetype)sharedService
{
	static id singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[[self class] alloc] init];
	});
	return singleton;
}

#pragma mark - Public methods

- (void)getAllAvailableConnectsionOnCompletion:(void(^)(NSArray *connections, NSArray *errors))block
{

	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPConnection *conn in [BSAPConnection arrayOfObjectsFromArrayOfDictionaries:@[@{@"tlv_for_mcc_mnc":@0,@"type":@1,@"description":@"",@"id":@1,@"system_id":@"beepsend",@"label":@"beepsend-connection",@"api_token":@"abc123",@"callbacks":@{@"dlr":@"http://beepsend.com/dlr",@"mo":@"https://beepsend.com/mocallback",@"method":@"PUT"},@"users":@[@{@"username":@"beepsend-user",@"name":@"Beep Beepson",@"id":@1}],@"wallet":@{@"balance":@5028.14758,@"name":@"Beepsend wallet",@"id":@1},@"customer":@"Beepsend AB"},@{@"tlv_for_mcc_mnc":@0,@"type":@2,@"description":@"",@"id":@1,@"system_id":@"beepsend2",@"label":@"beepsend-connection2",@"api_token":@"abc1234",@"callbacks":@{@"dlr":@"http://beepsend.com/dlr",@"mo":@"https://beepsend.com/mocallback",@"method":@"PUT"},@"users":@[@{@"username":@"beepsend-user",@"name":@"Beep Beepson",@"id":@1}],@"wallet":@{@"balance":@5028.14758,@"name":@"Beepsend wallet",@"id":@2},@"customer":@"Beepsend AB"}]]) {
	  [mArr addObject:[conn convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);

}

- (void)getMeConnectionOnCompletion:(void(^)(BSConnection *connection, NSArray *errors))block
{
	block([[BSAPConnection classFromDict:@{@"tlv_for_mcc_mnc":@0,@"type":@1,@"description":@"",@"id":@1,@"system_id":@"beepsend",@"label":@"beepsend-connection",@"api_token":@"abc123",@"callbacks":@{@"dlr":@"http://beepsend.com/dlr",@"mo":@"https://beepsend.com/mocallback",@"method":@"PUT"},@"users":@[@{@"username":@"beepsend-user",@"name":@"Beep Beepson",@"id":@1}],@"wallet":@{@"balance":@5028.14758,@"name":@"Beepsend wallet",@"id":@1},@"customer":@"Beepsend AB"}] convertToModel], nil);
}

- (void)updateConnection:(BSConnection *)connection
		 withCallbackDLR:(NSString *)calbackDLR
			  callbackMO:(NSString *)callbackMO
		  callbackMethod:(NSString *)callbackMethod
				systemID:(NSString *)systemID
				   label:(NSString *)label
			 description:(NSString *)description
	 withCompletionBlock:(void(^)(BSConnection *connection, NSArray *errors))block
{
	connection.callbackURLs.DLR = calbackDLR;
	connection.callbackURLs.MO = callbackMO;
	connection.callbackURLs.method = callbackMethod;
	
	connection.systemID = systemID;
	connection.label = label;
	connection.description = description;
	
	block(connection, nil);
}

- (void)resetTokenForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSConnection *updatedModel, NSArray *errors))block
{
	BSConnection *newToken = [[BSConnection alloc] initWithConnectionModel:connection withNewToken:@"NEW_TOKEN"];
	block(newToken, nil);
}

- (void)resetPasswordForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSConnection *updatedModel, NSArray *errors))block
{
	BSConnection *newPass = [[BSConnection alloc] initWithConnectionModel:connection withNewPassword:@"NEW_PASSWORD"];
	block(newPass, nil);
}

@end
