//
//  BSAnalyticsBatchModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAnalyticsBatchModel.h"

@interface BSAnalyticsBatchModel ()

@property (nonatomic, strong, readwrite) NSString *label;
@property (nonatomic, strong, readwrite) NSNumber *total;
@property (nonatomic, strong, readwrite) BSStatisticsModel *statistic;

@end

@implementation BSAnalyticsBatchModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular analytics batch"]) {
		
	}
	return self;
}

- (BSAnalyticsBatchModel *)initWithID:(NSString *)abID label:(NSString *)abLabel total:(NSNumber *)abTotal statistics:(BSStatisticsModel *)abStats
{
	if (self = [super initWithID:abID andTitle:abLabel]) {
		_label = abLabel;
		_total = abTotal;
		_statistic = abStats;
	}
	return self;
}

@end
