//
//  APPricelist.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPPricelist.h"

@implementation BSAPPricelist

#pragma mark - Properties

- (NSArray *)networks
{
	return _networks;
}

- (NSNumber *)networks_count
{
	return _networks_count;
}

- (NSString *)id
{
	return _id;
}

- (NSString *)timestamp
{
	if (_timestamp == nil || [_timestamp isEqual:[NSNull null]] || [_timestamp isKindOfClass:[NSNull class]]) {
		return [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
	}
	else {
		return _timestamp;
	}
}

- (NSNumber *)active
{
	return _active;
}

- (NSString *)first_viewed
{
	if (_first_viewed == nil || [_first_viewed isEqual:[NSNull null]] || [_first_viewed isKindOfClass:[NSNull class]]) {
		return [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
	}
	else {
		return _first_viewed;
	}
}

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

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPPricelist classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

- (BSPricelistModel *)convertToPricelistModel
{
	NSMutableArray *mNetworks = [@[] mutableCopy];
	for (BSAPPNetwork *network in _networks) {
		BSCountryModel *country = [[BSCountryModel alloc] initCountryNamed:network.country.name
														   withCountryCode:network.country.code
															andCallingCode:network.country.prefix];
		
		NSMutableArray *mMCCMNC = [@[] mutableCopy];
		for (BSAPPMCCMNC *mccmnc in network.mccmnc) {
			BSMCCMNCModel *mmm = [[BSMCCMNCModel alloc] initWithMNC:mccmnc.mnc
															 andMCC:mccmnc.mcc];
			
			[mMCCMNC addObject:mmm];
		}
		
		BSNetworkModel *networkModel =
		[[BSNetworkModel alloc] initNetworkWithMCCMNC:[NSArray arrayWithArray:mMCCMNC]
										  withComment:network.comment
												price:network.price
										  fromCountry:country
											 operator:network.operator];
		
		[mNetworks addObject:networkModel];
	}
	
	NSNumber *networksCount = _networks_count ? _networks_count : [NSNumber numberWithInteger:_networks.count];
	
	double ts = [self.timestamp doubleValue];
	NSDate *dateOfSave = [NSDate dateWithTimeIntervalSince1970:ts];
	double fv = [self.first_viewed doubleValue];
	NSDate *dateOfFirstViewed = [NSDate dateWithTimeIntervalSince1970:fv];
	
	BSPricelistModel *pricelistModel =
	[[BSPricelistModel alloc] initPricelistWithID:_id
										 networks:[NSArray arrayWithArray:mNetworks]
									 networkCount:networksCount
									   timeOfSave:dateOfSave
										   active:_active
								  timeOfFirstView:dateOfFirstViewed];
	
	return pricelistModel;
}

@end
