//
//  BSAPMessage.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPMessage.h"

@implementation BSAPMessage

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPBatch class];
	
	BSAPMessage *message = [super classFromDict:dictionary];
	
	return message;
}


#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPMessage classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

- (BSMessageModel *)convertToMessageModel
{
	
	BSBatchModel *batch = [[BSBatchModel alloc] initBatchWithID:_batch.id
														  label:_batch.label
												 dateOfCreation:nil
												  dateOfLastUse:nil];
	
	BSMessageModel *message = [[BSMessageModel alloc] initMessageWithID:_id
																  batch:batch
															 recipients:_to
																 sender:_from
																 errors:[_errors isKindOfClass:[NSArray class]]?_errors:nil
														recipientGroups:_groups];
	
	return message;
}

@end
