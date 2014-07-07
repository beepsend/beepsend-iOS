//
//  BSAccumulatedStatisticsModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/2/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAccumulatedStatisticsModel.h"

@interface BSAccumulatedStatisticsModel ()

@property (nonatomic, strong, readwrite) NSString *account;
@property (nonatomic, strong, readwrite) NSNumber *count;
@property (nonatomic, strong, readwrite) NSNumber *price;

@end

@implementation BSAccumulatedStatisticsModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular accumulated statistics"]) {
		
	}
	return self;
}

- (BSAccumulatedStatisticsModel *)initWithAccount:(NSString *)account count:(NSNumber *)count price:(NSNumber *)price
{
	if (self = [super initWithID:@"0" andTitle:@"Accumulated statistics"]) {
		_account = account;
		_count = count;
		_price = price;
	}
	return self;
}

@end
