//
//  BSCustomer.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/16/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCustomerService.h"

#import "BSAPIConfiguration.h"

#import "BSAPCustomer.h"

@implementation BSCustomerService

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

- (void)getCustomerOnCompletion:(void(^)(BSCustomer *customer, id error))block {
	[super executeGETForMethod:[BSAPIConfiguration customer]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  block([[BSAPCustomer classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
					  
				  }];
}

@end
