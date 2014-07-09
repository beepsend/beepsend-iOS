//
//  APPricelist.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPPricelist.h"

#import "BSAPPNetwork.h"
#import "BSAPPMCCMNC.h"

#import "BSPricelist.h"

@implementation BSAPPricelist

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPPNetwork class];
	
	BSAPPricelist *pricelist = [super classFromDict:dictionary];
	
	pricelist.networks = [BSAPPNetwork arrayOfObjectsFromArrayOfDictionaries:pricelist.networks];
	
	return pricelist;
}

- (id)convertToModel
{
	NSMutableArray *mNetworks = [@[] mutableCopy];
	for (BSAPPNetwork *network in _networks) {
		[mNetworks addObject:[network convertToModel]];
	}
	
	NSDate *dateOfSave =
	_timestamp!=nil && ![_timestamp isKindOfClass:[NSNull class]] && ![_timestamp isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_timestamp doubleValue]]
	:
	nil;
	
	NSDate *dateOfFirstViewed =
	_first_viewed!=nil && ![_first_viewed isKindOfClass:[NSNull class]] && ![_first_viewed isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_first_viewed doubleValue]]
	:
	nil;
	
	return [[BSPricelist alloc] initPricelistWithID:_id networks:[NSArray arrayWithArray:mNetworks] networkCount:_networks_count timeOfSave:dateOfSave active:_active timeOfFirstView:dateOfFirstViewed];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPPricelist classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
