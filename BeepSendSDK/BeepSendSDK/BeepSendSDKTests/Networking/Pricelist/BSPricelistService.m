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
#import "BSAPPNetwork.h"

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

- (void)getPricelistAsCSVForConnection:(BSConnection *)connection onCompletion:(void(^)(NSString *pricelist, NSArray *errors))block
{
	NSString *csvString = @"mcc;mnc;operator;price240;;Default;0.08240;01;\"TeliaSonera Mobile Networks AB Sweden (TeliaSonera Mobile Networks)\";0.068";
	block(csvString, nil);
}

- (void)getPricelistDiffForConnection:(BSConnection *)connection withPricelist1:(BSPricelist *)pricelist1 andPricelist2:(BSPricelist *)pricelist2 onCompletion:(void(^)(BSNetwork *diff, NSArray *error))block
{

	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPPNetwork *pricelist in [BSAPPNetwork arrayOfObjectsFromArrayOfDictionaries:@[@{@"country":@{@"name":@"Zimbabwe",@"prefix":@263,@"code":@"ZW"},@"operator":@"Telecel Zimbabwe (PVT) Ltd (TELECEL)",@"mccmnc":@[@{@"mnc":@"03",@"mcc":@"648"}],@"comment":@"",@"price":@0.006,@"old_price":@0.022,@"diff":@"price"}]]) {
		[mArr addObject:[pricelist convertToModel]];
	}
						  
	if (mArr.count>0) {
		block(mArr[0], nil);
	}
	else {
		block(nil, nil);
	}
}

- (void)getPricelistDiffAsCSVForConnection:(BSConnection *)connection withPricelist1:(BSPricelist *)pricelist1 andPricelist2:(BSPricelist *)pricelist2 onCompletion:(void(^)(NSString *diff, NSArray *error))block
{
	NSString *csvString = @"mcc;mnc;operator;price;price_diff;diff240;;Default;0.08;0.011;price240;01;\"TeliaSonera Mobile Networks AB Sweden (TeliaSonera Mobile Networks)\";;0;removed";
	block(csvString, nil);
}

@end
