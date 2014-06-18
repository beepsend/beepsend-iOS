//
//  ConnectionsService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSConnectionsService.h"

#import "BSAPIConfiguration.h"

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

- (void)getAllAvailableConnectsionOnCompletion:(void(^)(id response, id error))block {
	[super executeGETForMethod:[BSAPIConfiguration connections]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  block(response, error);
	}];
}

- (void)getConnectionOnCompletion:(void(^)(id response, id error))block {
	[super executeGETForMethod:[BSAPIConfiguration connectionsMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
		
					  block(response, error);
	}];
}

@end
