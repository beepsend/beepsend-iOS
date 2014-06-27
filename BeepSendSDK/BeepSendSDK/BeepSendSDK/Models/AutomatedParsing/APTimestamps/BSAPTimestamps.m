//
//  BSAPTimestamps.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPTimestamps.h"

#import "BSTimestampsModel.h"

@implementation BSAPTimestamps

#pragma mark - Inherited methods

- (id)convertToModel
{
	NSDate *whenCallbackWasSent = _dlr_out!=nil && ![_dlr_out isKindOfClass:[NSNull class]] && ![_dlr_out isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_dlr_out doubleValue]]
	:
	nil;
	
	return [[BSTimestampsModel alloc] initReportWithHLRReport:[_hlr convertToModel] andCallbackSentTime:whenCallbackWasSent];
}

@end
