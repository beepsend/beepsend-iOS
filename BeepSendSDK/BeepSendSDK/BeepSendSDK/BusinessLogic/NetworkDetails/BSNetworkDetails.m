//
//  BSNetworkDetailsModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSNetworkDetails.h"

@interface BSNetworkDetails ()

@property (nonatomic, strong, readwrite) BSMCCMNC *mccmnc;
@property (nonatomic, strong, readwrite) BSStatistics *statistics;
@property (nonatomic, strong, readwrite) NSNumber *total;

@end


@implementation BSNetworkDetails

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Network details"]) {
		
	}
	return self;
}

- (BSNetworkDetails *)initWithMCCMNC:(BSMCCMNC *)nMccmnc statistics:(BSStatistics *)nStatistics total:(NSNumber *)nTotal
{
	if (self = [super initWithID:@"0" andTitle:@"Network details"]) {
		_mccmnc = nMccmnc;
		_statistics = nStatistics;
		_total = nTotal;
	}
	return self;
}

@end
