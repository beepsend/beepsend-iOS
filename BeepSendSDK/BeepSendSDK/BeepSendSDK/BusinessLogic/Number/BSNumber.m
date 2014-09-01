//
//  BSNumber.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSNumber.h"

@interface BSNumber ()

@property (nonatomic, strong, readwrite) BSConnection *connection;
@property (nonatomic, strong, readwrite) BSCountry *country;
@property (nonatomic, strong, readwrite) NSString *numberID;
@property (nonatomic, strong, readwrite) NSNumber *recipientNumber;

@end

@implementation BSNumber

#pragma mark - Properties

- (NSString *)numberID
{
	return [BSHelper isNilOrEmpty:_numberID] ? @"0" : [_numberID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_numberID stringValue] : _numberID;
}

- (NSNumber *)recipientNumber
{
	return _recipientNumber ? _recipientNumber : @0;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular number"]) {
		
	}
	return self;
}

- (BSNumber *)initWithID:(NSString *)nID
				 country:(BSCountry *)nCountry
			  connection:(BSConnection *)nConnection
	  andRecipientNumber:(NSNumber *)nNumber
{
	if (self = [super initWithID:@"0" andTitle:@"Number"]) {
		
		_numberID = nID;
		_recipientNumber = nNumber;
		_country = nCountry;
		_connection = nConnection;
		
	}
	return self;
}

@end
