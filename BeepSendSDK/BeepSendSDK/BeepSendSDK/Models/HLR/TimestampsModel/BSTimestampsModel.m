//
//  BSTimestampsModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSTimestampsModel.h"

@interface BSTimestampsModel ()

@property (nonatomic, strong, readwrite) BSHLRReportModel *hlr;
@property (nonatomic, strong, readwrite) NSDate *callbackSentAt;

@end

@implementation BSTimestampsModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular timestamp"]) {
		
	}
	return self;
}

- (BSTimestampsModel *)initReportWithHLRReport:(BSHLRReportModel *)hlrReport
						  andCallbackSentTime:(NSDate *)sDate
{
	if (self = [super initWithID:@"0" andTitle:@"Timestamp"]) {
		_hlr = hlrReport;
		_callbackSentAt = sDate;
	}
	return self;
}

@end
