//
//  BSAPEmail.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPEmail.h"

#import "BSEmailModel.h"

@implementation BSAPEmail

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSEmailModel alloc] initEmailWithID:_id atAddress:_email];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPEmail classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

+ (NSArray *)arrayOfModelsFromArrayOfObjects:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[object convertToModel]];
	}
	return [NSArray arrayWithArray:results];
}

+ (BSAPEmail *)convertFromEmailModel:(BSEmailModel *)emailModel
{
	BSAPEmail *email = [[BSAPEmail alloc] init];
	if ([emailModel.objectID isEqualToString:@"-1"]) {
		return email;
	}
	
	email.id = [emailModel.objectID isEqualToString:@"0"] ? nil : emailModel.objectID;
	email.email = emailModel.address;
	
	return email;
}

@end
