//
//  BSGeneralModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@implementation BSGeneralModel

#pragma mark - Initialization

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	if (self = [super init]) {
		_objectID = @0;
		_title = @"Initial Object";
	}
	return self;
}

#pragma mark - Inherited methods

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@> Object with ID: <%@> has value: <%@>", NSStringFromClass([self class]), _objectID, _title];
}

@end
