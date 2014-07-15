//
//  ConnectionsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSConnection.h"

@interface BSConnectionsService : BSBaseService

- (void)getAllAvailableConnectsionOnCompletion:(void(^)(NSArray *connections, id error))block;
- (void)getMeConnectionOnCompletion:(void(^)(BSConnection *connection, id error))block;

- (void)updateConnection:(BSConnection *)connection
		 withCallbackDLR:(NSString *)calbackDLR
			  callbackMO:(NSString *)callbackMO
		  callbackMethod:(NSString *)callbackMethod
				systemID:(NSString *)systemID
				   label:(NSString *)label
			 description:(NSString *)description
	 withCompletionBlock:(void(^)(BSConnection *connection, id error))block;

- (void)resetTokenForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSConnection *updatedModel, id error))block;

- (void)resetPasswordForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSConnection *updatedModel, id error))block;

@end
