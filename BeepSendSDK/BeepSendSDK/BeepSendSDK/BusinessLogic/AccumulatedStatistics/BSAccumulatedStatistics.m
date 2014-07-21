//
//  BSAccumulatedStatisticsModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAccumulatedStatistics.h"

@interface BSAccumulatedStatistics ()

@property (nonatomic, strong, readwrite) NSString *account;
@property (nonatomic, strong, readwrite) NSNumber *count;
@property (nonatomic, strong, readwrite) NSNumber *price;

@end

@implementation BSAccumulatedStatistics

#pragma mark - Properties

- (NSString *)account
{
	return [BSHelper isNilOrEmpty:_account] ? @"" : _account;
}

- (NSNumber *)count
{
	return _count ? _count : @0;
}

- (NSNumber *)price
{
	return _price ? _price : @0;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular accumulated statistics"]) {
		
	}
	return self;
}

- (BSAccumulatedStatistics *)initWithAccount:(NSString *)account count:(NSNumber *)count price:(NSNumber *)price
{
	if (self = [super initWithID:@"0" andTitle:@"Accumulated statistics"]) {
		_account = account;
		_count = count;
		_price = price;
	}
	return self;
}

@end
