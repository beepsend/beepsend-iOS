//
//  BSValueForNumberModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSValueForNumber.h"

@interface BSValueForNumber ()

@property (nonatomic, strong, readwrite) NSString *value;
@property (nonatomic, strong, readwrite) NSNumber *cost;

@end

@implementation BSValueForNumber

#pragma mark - Properties

- (NSString *)value
{
	return [BSHelper isNilOrEmpty:_value] ? @"" : _value;
}

- (NSNumber *)cost
{
	return _cost ? _cost : @0;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Value"]) {
		
	}
	return self;
}

- (BSValueForNumber *)initWithValue:(NSString *)value cost:(NSNumber *)cost
{
	if (self = [super initWithID:@"0" andTitle:@"Value"]) {
		_value = value;
		_cost = cost;
	}
	return self;
}

@end
