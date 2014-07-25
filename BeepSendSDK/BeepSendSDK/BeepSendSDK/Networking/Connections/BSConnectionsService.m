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
	[super executeGETForMethod:[BSAPIConfiguration connections]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPConnection *conn in [BSAPConnection arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[conn convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
	}];
}

- (void)getMeConnectionOnCompletion:(void(^)(BSConnection *connection, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration connectionsMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
		
					  if (!error) {
						  block([[BSAPConnection classFromDict:response] convertToModel], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
	}];
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
	
	BSAPConnection *conn = [[BSAPConnection alloc] init];
	
	BSAPCCallback *call = [[BSAPCCallback alloc] init];
	call.dlr = calbackDLR;
	call.mo = callbackMO;
	call.method = callbackMethod;
	
	conn.callbacks = call;
	conn.system_id = systemID;
	conn.label = label;
	conn.description = description;
	
	NSString *method = connection ? [BSAPIConfiguration connectionsWithID:connection.objectID] : [BSAPIConfiguration connectionsMe];
	
	[super executePUTForMethod:method
				withParameters:[conn dictionaryFromClass]
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block([[BSAPConnection classFromDict:response] convertToModel], nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)resetTokenForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSConnection *updatedModel, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration connectionResetForID:connection.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  BSConnection *newToken = [[BSConnection alloc] initWithConnectionModel:connection
																				withNewToken:[[[BSAPConnection classFromDict:response] convertToModel] apiToken]];
					  
					  if (!error) {
						  block(newToken, nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)resetPasswordForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSConnection *updatedModel, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration connectionPasswordResetForID:connection.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  BSConnection *newPass = [[BSConnection alloc] initWithConnectionModel:connection
																			withNewPassword:[[[BSAPConnection classFromDict:response] convertToModel] password]];
					  
					  if (!error) {
						  block(newPass, nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

@end
