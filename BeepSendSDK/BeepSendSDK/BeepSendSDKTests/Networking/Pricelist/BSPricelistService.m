//
//  BSPricelistService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/20/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSPricelistService.h"

#import "BSAPIConfiguration.h"

#import "BSAPPricelist.h"

@implementation BSPricelistService

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

- (void)getCurrentPricelistsForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSPricelist *pricelist, NSArray *errors))block
{
	BSPricelist *pricelist = [[BSAPPricelist classFromDict:@{@"id":[NSNull null],@"batch_label":@"My custom name for my batch",@"to":@"502040",@"from":@"lolboll",@"errors":[NSNull null]}] convertToModel];
	block(pricelist, nil);
}

- (void)getCurrentPricelistsForMeWithCompletionBlock:(void(^)(BSPricelist *pricelist, NSArray *errors))block
{
	BSPricelist *pricelist = [[BSAPPricelist classFromDict:@{@"id":[NSNull null],@"batch_label":@"My custom name for my batch",@"to":@"502040",@"from":@"lolboll",@"errors":[NSNull null]}] convertToModel];
	block(pricelist, nil);
}

- (void)getPricelistsForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *pricelists, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPPricelist *pricelist in [BSAPPricelist arrayOfObjectsFromArrayOfDictionaries:@[@{@"networks_count":@980,@"id":@280290,@"timestamp":@1386085000,@"active":@YES,@"first_viewed":@1386228799},@{@"networks_count":@980,@"id":@280290,@"timestamp":@1386085000,@"active":@YES,@"first_viewed":@1386228799},@{@"networks_count":@980,@"id":@280290,@"timestamp":@1386085000,@"active":@YES,@"first_viewed":@1386228799}]]) {
		[mArr addObject:[pricelist convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

- (void)getPriceListsForMeWithCompletionBlock:(void(^)(NSArray *pricelists, NSArray *errors))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPPricelist *pricelist in [BSAPPricelist arrayOfObjectsFromArrayOfDictionaries:@[@{@"networks_count":@980,@"id":@280290,@"timestamp":@1386085000,@"active":@YES,@"first_viewed":@1386228799},@{@"networks_count":@980,@"id":@280290,@"timestamp":@1386085000,@"active":@YES,@"first_viewed":@1386228799},@{@"networks_count":@980,@"id":@280290,@"timestamp":@1386085000,@"active":@YES,@"first_viewed":@1386228799}]]) {
		[mArr addObject:[pricelist convertToModel]];
	}
	block([NSArray arrayWithArray:mArr], nil);
}

@end
