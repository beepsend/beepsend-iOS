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

- (void)getAllAvailableConnectsionOnCompletion:(void(^)(NSArray *connections, id error))block {
	[super executeGETForMethod:[BSAPIConfiguration connections]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPConnection *conn in [BSAPConnection arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[conn convertToConnectionModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
	}];
}

- (void)getMeConnectionOnCompletion:(void(^)(BSConnectionModel *connection, id error))block {
	[super executeGETForMethod:[BSAPIConfiguration connectionsMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
		
					  if (!error) {
						  block([[BSAPConnection classFromDict:response] convertToConnectionModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
	}];
}

@end
