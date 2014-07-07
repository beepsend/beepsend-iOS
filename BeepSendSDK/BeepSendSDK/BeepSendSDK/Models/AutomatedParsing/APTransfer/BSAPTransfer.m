//
//  BSAPTransfer.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPTransfer.h"

#import "BSTransferModel.h"

@implementation BSAPTransfer

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPWallet class];
	
	BSAPTransfer *transfer = [super classFromDict:dictionary];
	return transfer;
}

- (id)convertToModel
{
	return [[BSTransferModel alloc] initTransferWithSourceWallet:[_source_wallet convertToModel] destinationWallet:[_target_wallet convertToModel] withAmount:_amount];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPTransfer classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
