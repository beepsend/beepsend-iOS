//
//  BSEstimateCostModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSEstimateCostModel.h"

@interface BSEstimateCostModel ()

@property (nonatomic, strong, readwrite) NSArray *recipients;
@property (nonatomic, strong, readwrite) NSNumber *totalCost;

@end

@implementation BSEstimateCostModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Estimate"]) {
		
	}
	return self;
}

- (BSEstimateCostModel *)initWithRecipients:(NSArray *)recipients totalCost:(NSNumber *)totalCost
{
	if (self = [super initWithID:@"0" andTitle:@"Estimate"]) {
		_recipients = recipients;
		_totalCost = totalCost;
	}
	return self;
}

@end
