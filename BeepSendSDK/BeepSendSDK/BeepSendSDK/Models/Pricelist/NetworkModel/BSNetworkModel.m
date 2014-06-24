//
//  BSNetworkModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSNetworkModel.h"

@interface BSNetworkModel ()

@property (nonatomic, strong, readwrite) NSArray *mccmnc;
@property (nonatomic, strong, readwrite) NSString *comment;
@property (nonatomic, strong, readwrite) NSNumber *price;
@property (nonatomic, strong, readwrite) BSCountryModel *country;
@property (nonatomic, strong, readwrite) NSString *operatorName;

@end

@implementation BSNetworkModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular network"]) {
		
	}
	return self;
}

- (BSNetworkModel *)initNetworkWithMCCMNC:(NSArray *)nMCCMNC
							  withComment:(NSString *)nComment
									price:(NSNumber *)nPrice
							  fromCountry:(BSCountryModel *)nCountry
								 operator:(NSString *)nOperatorName
{
	if (self = [super initWithID:@"0" andTitle:nOperatorName]) {
		_mccmnc = nMCCMNC;
		_comment = nComment;
		_price = nPrice;
		_country = nCountry;
		_operatorName = nOperatorName;
	}
	return self;
}

@end