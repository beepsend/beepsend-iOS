//
//  BSAnalyticsBatchModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAnalyticsBatch.h"

#import "BSStatistics.h"

@interface BSAnalyticsBatch ()

@property (nonatomic, strong, readwrite) NSString *label;
@property (nonatomic, strong, readwrite) NSNumber *total;
@property (nonatomic, strong, readwrite) BSStatistics *statistic;

@end

@implementation BSAnalyticsBatch

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular analytics batch"]) {
		
	}
	return self;
}

- (BSAnalyticsBatch *)initWithID:(NSString *)abID label:(NSString *)abLabel total:(NSNumber *)abTotal statistics:(BSStatistics *)abStats
{
	if (self = [super initWithID:abID andTitle:abLabel]) {
		_label = abLabel;
		_total = abTotal;
		_statistic = abStats;
	}
	return self;
}

@end
