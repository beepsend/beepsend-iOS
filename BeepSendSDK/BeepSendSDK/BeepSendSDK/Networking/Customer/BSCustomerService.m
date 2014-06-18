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

- (void)getCustomerOnCompletion:(void(^)(BSCustomerModel *customer, id error))block {
	[super executeGETForMethod:[BSAPIConfiguration customer]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  BSAPCAccountManager *accManager;
					  BSAPCPriceListSchedule *priceList;
					  BSAPCustomer *customer = [BSAPCustomer classFromDict:response];
					  
					  BSLog(@"%@", customer);
					  
					  block(response, error);
				  }];
}

@end
