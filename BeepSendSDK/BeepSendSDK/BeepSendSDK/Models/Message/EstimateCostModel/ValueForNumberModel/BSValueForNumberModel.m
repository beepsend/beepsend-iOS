//
//  BSValueForNumberModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSValueForNumberModel.h"

@interface BSValueForNumberModel ()

@property (nonatomic, strong, readwrite) NSString *value;
@property (nonatomic, strong, readwrite) NSNumber *cost;

@end

@implementation BSValueForNumberModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Value"]) {
		
	}
	return self;
}

- (BSValueForNumberModel *)initWithValue:(NSString *)value cost:(NSNumber *)cost
{
	if (self = [super initWithID:@"0" andTitle:@"Value"]) {
		_value = value;
		_cost = cost;
	}
	return self;
}

@end
