//
//  BSEstimateCostModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSEstimateCost.h"

@interface BSEstimateCost ()

@property (nonatomic, strong, readwrite) NSArray *recipients;
@property (nonatomic, strong, readwrite) NSNumber *totalCost;

@end

@implementation BSEstimateCost

#pragma mark - Properties

- (NSArray *)recipients
{
	return _recipients ? _recipients : @[];
}

- (NSNumber *)totalCost
{
	return _totalCost ? _totalCost : @0;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Estimate"]) {
		
	}
	return self;
}

- (BSEstimateCost *)initWithRecipients:(NSArray *)recipients totalCost:(NSNumber *)totalCost
{
	if (self = [super initWithID:@"0" andTitle:@"Estimate"]) {
		_recipients = recipients;
		_totalCost = totalCost;
	}
	return self;
}

@end
