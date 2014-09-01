//
//  BSCountryModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCountry.h"

@interface BSCountry ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSNumber *callingCode;
@property (nonatomic, strong, readwrite) NSString *code;

@end

@implementation BSCountry

#pragma mark - Properties

- (NSString *)name
{
	return [BSHelper isNilOrEmpty:_name] ? @"" : _name;
}

- (NSNumber *)callingCode
{
	return _callingCode ? _callingCode : @0;
}

- (NSString *)code
{
	return [BSHelper isNilOrEmpty:_code] ? @"" : _code;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular country"]) {
		
	}
	return self;
}

- (BSCountry *)initCountryWithID:(NSString *)cID
						   named:(NSString *)cName
				 withCountryCode:(NSString *)cCountryCode
				  andCallingCode:(NSNumber *)cCallingCode
{
	if (self = [super initWithID:cID?cID:@"0" andTitle:cName]) {
		_name = cName;
		_callingCode = cCallingCode;
		_code = cCountryCode;
	}
	return self;
}

@end
