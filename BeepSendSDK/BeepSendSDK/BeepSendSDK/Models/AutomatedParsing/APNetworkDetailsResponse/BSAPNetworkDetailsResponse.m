//
//  BSAPNetworkDetailsResponse.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPNetworkDetailsResponse.h"

#import "BSNetworkDetails.h"

@implementation BSAPNetworkDetailsResponse

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPPMCCMNC class];
	[BSAPStatistics class];
	
	BSAPNetworkDetailsResponse *networkDetails = [super classFromDict:dictionary];
	return networkDetails;
}

- (id)convertToModel
{
	return [[BSNetworkDetails alloc] initWithMCCMNC:[_mccmnc convertToModel]
											  statistics:[_statistics convertToModel]
												   total:_total];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPNetworkDetailsResponse classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
