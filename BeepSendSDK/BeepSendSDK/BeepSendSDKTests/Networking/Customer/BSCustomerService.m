//
//  BSCustomer.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/16/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCustomerService.h"

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

- (void)getCustomerOnCompletion:(void(^)(BSCustomer *customer, NSArray *errors))block {
	
	NSDictionary *cust = @{ @"id" : @1 ,
							@"phone" : @"46406007500" ,
							@"name" : @"Beepsend AB" ,
							@"address" : @"Gustav Adolfs Torg 12" ,
							@"city" : @"Malmö" ,
							@"post_box" : @"21139" ,
							@"country" : @"Sweden" ,
							@"vat" : @"" ,
							@"email" : @"beepsend@beepsend.se" ,
							@"invoice_type" : @"pre-pay" ,
							@"account_manager" : @{ @"name" : @"Account Manager" ,
													@"email" : @"account.manager@beepsend.se" } ,
							@"pricelist_type" : @1,
							@"pricelist_delimiter" : [NSNull null],
							@"pricelist_schedule" : @{ @"id" : @1,
													   @"name" : @"Immediately" } ,
							@"pricelist_fields": @[] };
	
	BSAPCustomer *customer = [BSAPCustomer classFromDict:cust];
	
	block([customer convertToModel], nil);
}

@end
