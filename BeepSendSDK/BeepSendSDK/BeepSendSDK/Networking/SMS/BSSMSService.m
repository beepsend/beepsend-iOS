//
//  BSSMSService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSMSService.h"

#import "BSAPIConfiguration.h"

@implementation BSSMSService

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

- (void)sendMessage:(NSString *)message
			 sender:(NSString *)sender
		   receiver:(NSString *)receiver
	 withCompletion:(void (^)(id response, id error))block {
	
	[super executePOSTForMethod:[BSAPIConfiguration sms]
				 withParameters:@{ @"message" : message , @"from" : sender , @"to" : receiver }
				   onCompletion:^(id response, id error) {
					  
					  block(response, error);
				   }];
}

@end
