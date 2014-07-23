//
//  BSAPEmail.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPEmail.h"

#import "BSEmail.h"

@implementation BSAPEmail

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSEmail alloc] initEmailWithID:_id atAddress:_email];
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

+ (BSAPEmail *)convertFromEmailModel:(BSEmail *)emailModel
{
	BSAPEmail *email = [[BSAPEmail alloc] init];
	if ([emailModel.emailID isEqualToString:@"-1"]) {
		return email;
	}
	
	email.id = [emailModel.emailID isEqualToString:@"0"] ? nil : emailModel.emailID;
	email.email = [emailModel.address isEqualToString:@""] ? nil : emailModel.address;
	
	return email;
}

@end
