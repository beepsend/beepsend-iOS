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

- (void)getAllAvailableConnectsionOnCompletion:(void(^)(NSArray *connections, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration connections]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPConnection *conn in [BSAPConnection arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[conn convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
	}];
}

- (void)getMeConnectionOnCompletion:(void(^)(BSConnectionModel *connection, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration connectionsMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
		
					  if (!error) {
						  block([[BSAPConnection classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
	}];
}

- (void)updateConnection:(BSConnectionModel *)connection
		 withCallbackDLR:(NSString *)calbackDLR
				systemID:(NSString *)systemID
				   label:(NSString *)label
			 description:(NSString *)description
	 withCompletionBlock:(void(^)(BSConnectionModel *connection, id error))block
{
	//	{
	//		"callbacks": {
	//			"dlr": "https://beepsend.com/securedlr"
	//		},
	//		"system_id": "crossover",
	//		"label": "Pawnee-connection",
	/*
	 //		"password": "cake",
	 */
	//		"description": "Cool. Cool, cool, cool"
	//	}
	
	//	If authenticating with a user API Token you can even set specified connection to be your default.
	//
	//	{
	//		"default_connection": true
	//	}
	
	BSAPConnection *conn = [[BSAPConnection alloc] init];
	
	BSAPCCallback *call = [[BSAPCCallback alloc] init];
	call.dlr = calbackDLR;
	
	conn.callbacks = call;
	conn.system_id = systemID;
	conn.label = label;
	conn.description = description;
	
	NSString *method = connection ? [BSAPIConfiguration connectionsWithID:connection.objectID] : [BSAPIConfiguration connectionsMe];
	
	[super executePUTForMethod:method
				withParameters:[conn dictionaryFromClass]
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block([[BSAPConnection classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, error);
					  }
				  }];
}

- (void)resetTokenForConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(BSConnectionModel *updatedModel, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration connectionResetForID:connection.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  BSConnectionModel *newToken = [[BSConnectionModel alloc] initWithConnectionModel:connection
																						  withNewToken:[[[BSAPConnection classFromDict:response] convertToModel] apiToken]];
					  
					  if (!error) {
						  block(newToken, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, error);
					  }
				  }];
}

- (void)resetPasswordForConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(BSConnectionModel *updatedModel, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration connectionPasswordResetForID:connection.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  BSConnectionModel *newPass = [[BSConnectionModel alloc] initWithConnectionModel:connection
																						  withNewPassword:[[[BSAPConnection classFromDict:response] convertToModel] password]];
					  
					  if (!error) {
						  block(newPass, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, error);
					  }
				  }];
}

@end
