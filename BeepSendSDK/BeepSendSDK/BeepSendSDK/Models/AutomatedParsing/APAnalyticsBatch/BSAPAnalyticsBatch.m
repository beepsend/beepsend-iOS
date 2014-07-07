//
//  BSAPAnalyticsBatch.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPAnalyticsBatch.h"

#import "BSAnalyticsBatchModel.h"

@implementation BSAPAnalyticsBatch

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPStatistics class];
	
	BSAPAnalyticsBatch *batchDetails = [super classFromDict:dictionary];
	return batchDetails;
}

- (id)convertToModel
{
	return [[BSAnalyticsBatchModel alloc] initWithID:_id label:_label total:_total statistics:[_statistics convertToModel]];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPAnalyticsBatch classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
