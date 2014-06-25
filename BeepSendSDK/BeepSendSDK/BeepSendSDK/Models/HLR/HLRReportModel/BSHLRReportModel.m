//
//  BSHLRReportModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSHLRReportModel.h"

@interface BSHLRReportModel ()

@property (nonatomic, strong, readwrite) NSDate *hlrReachedAt;
@property (nonatomic, strong, readwrite) NSDate *responseReachedAt;

@end

@implementation BSHLRReportModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular report"]) {
		
	}
	return self;
}

- (BSHLRReportModel *)initReportWithHLRReachedDate:(NSDate *)rDate
							andResponseReachedDate:(NSDate *)sDate
{
	if (self = [super initWithID:@"0" andTitle:@"HLR report"]) {
		_hlrReachedAt = rDate;
		_responseReachedAt = sDate;
	}
	return self;
}

@end
