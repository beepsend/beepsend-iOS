//
//  BSEmailModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSEmail.h"

@interface BSEmail ()

@property (nonatomic, strong, readwrite) NSString *address;
@property (nonatomic, strong, readwrite) NSString *emailID;

@end

@implementation BSEmail

#pragma mark - Properties

- (NSString *)address
{
	return [BSHelper isNilOrEmpty:_address] ? @"" : _address;
}

- (NSString *)emailID
{
	return [BSHelper isNilOrEmpty:_emailID] ? @"0" : [_emailID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_emailID stringValue] : _emailID;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular email"]) {
		_emailID = @"-1";
	}
	return self;
}

- (BSEmail *)initEmailWithID:(NSString *)eID atAddress:(NSString *)address
{
	if (self = [super initWithID:eID andTitle:address]) {
		_emailID = eID;
		_address = address;
	}
	return self;
}

- (BSEmail *)initEmailWithAddress:(NSString *)address
{
	if (self = [super initWithID:@"0" andTitle:address]) {
		_emailID = @"0";
		_address = address;
	}
	return self;
}

@end
