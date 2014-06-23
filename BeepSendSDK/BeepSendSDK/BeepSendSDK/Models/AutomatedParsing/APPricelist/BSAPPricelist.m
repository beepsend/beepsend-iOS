//
//  APPricelist.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPPricelist.h"

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
