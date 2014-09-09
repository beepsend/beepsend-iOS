//
//  BSNetworkModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSNetwork.h"

@interface BSNetwork ()

@property (nonatomic, strong, readwrite) NSArray *mccmnc;
@property (nonatomic, strong, readwrite) NSString *comment;
@property (nonatomic, strong, readwrite) NSNumber *price;
@property (nonatomic, strong, readwrite) BSCountry *country;
@property (nonatomic, strong, readwrite) NSString *operatorName;
@property (nonatomic, strong, readwrite) NSNumber *oldPrice;
@property (nonatomic, strong, readwrite) NSString *difference;

@end

@implementation BSNetwork

#pragma mark - Properties

- (NSArray *)mccmnc
{
	return _mccmnc ? _mccmnc : @[];
}

- (NSString *)comment
{
	return [BSHelper isNilOrEmpty:_comment] ? @"" : _comment;
}

- (NSNumber *)price
{
	return _price ? _price : @0;
}

- (NSString *)operatorName
{
	return [BSHelper isNilOrEmpty:_operatorName] ? @"" : _operatorName;
}

- (NSNumber *)oldPrice
{
	return _oldPrice ? _oldPrice : @0;
}

- (NSString *)difference
{
	return [BSHelper isNilOrEmpty:_difference] ? @"" : _difference;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular network"]) {
		
	}
	return self;
}

- (BSNetwork *)initNetworkWithMCCMNC:(NSArray *)nMCCMNC
						 withComment:(NSString *)nComment
							   price:(NSNumber *)nPrice
						 fromCountry:(BSCountry *)nCountry
							operator:(NSString *)nOperatorName
							oldPrice:(NSNumber *)nOldPrice
						  difference:(NSString *)nDifference
{
	if (self = [super initWithID:@"0" andTitle:nOperatorName]) {
		_mccmnc = nMCCMNC;
		_comment = nComment;
		_price = nPrice;
		_country = nCountry;
		_operatorName = nOperatorName;
		_oldPrice = nOldPrice;
		_difference = nDifference;
	}
	return self;
}

@end
