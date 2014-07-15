//
//  BSTimestampsModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSTimestamps.h"

#import "BSHLRReport.h"

@interface BSTimestamps ()

@property (nonatomic, strong, readwrite) BSHLRReport *hlr;
@property (nonatomic, strong, readwrite) NSDate *callbackSentAt;

@end

@implementation BSTimestamps

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular timestamp"]) {
		
	}
	return self;
}

- (BSTimestamps *)initReportWithHLRReport:(BSHLRReport *)hlrReport
					  andCallbackSentTime:(NSDate *)sDate
{
	if (self = [super initWithID:@"0" andTitle:@"Timestamp"]) {
		_hlr = hlrReport;
		_callbackSentAt = sDate;
	}
	return self;
}

@end
