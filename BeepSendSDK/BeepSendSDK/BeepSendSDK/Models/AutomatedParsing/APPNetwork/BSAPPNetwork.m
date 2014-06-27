//
//  APPNetwork.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPPNetwork.h"

#import "BSAPPMCCMNC.h"

#import "BSNetworkModel.h"

@implementation BSAPPNetwork

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPPMCCMNC class];
	[BSAPPCountry class];
	
	BSAPPNetwork *network = [super classFromDict:dictionary];
	
	network.mccmnc = [BSAPPMCCMNC arrayOfObjectsFromArrayOfDictionaries:network.mccmnc];
	
	return network;
}

- (id)convertToModel
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSAPPMCCMNC *mccmnc in _mccmnc) {
		[mArr addObject:[mccmnc convertToModel]];
	}
	
	return [[BSNetworkModel alloc] initNetworkWithMCCMNC:[NSArray arrayWithArray:mArr] withComment:_comment?_comment:@"" price:_price?_price:@0 fromCountry:[_country convertToModel] operator:_operator?_operator:@""];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPPNetwork classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
