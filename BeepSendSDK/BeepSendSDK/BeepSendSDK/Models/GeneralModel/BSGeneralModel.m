//
//  BSGeneralModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSGeneralModel ()

@property (nonatomic, strong, readwrite) NSString *objectID;
@property (nonatomic, strong, readwrite) NSString *title;

@end

@implementation BSGeneralModel

#pragma mark - Properties

- (NSString *)objectID
{
	if ([_objectID isKindOfClass:[NSNumber class]]) {
		return [(NSNumber *)_objectID stringValue];
	}
	else if	([_objectID isKindOfClass:[NSString class]]) {
		return _objectID;
	}
	else {
		return @"-1";
	}
}

#pragma mark - Initialization

- (id)init
{
	if (self = [super init]) {
		_objectID = @"-1";
		_title = @"Irregular object";
	}
	return self;
}

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super init]) {
		_objectID = objectID;
		_title = title;
	}
	return self;
}

#pragma mark - Inherited methods

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@> Object with ID: <%@> has value: <%@>", NSStringFromClass([self class]), _objectID, _title];
}

@end
