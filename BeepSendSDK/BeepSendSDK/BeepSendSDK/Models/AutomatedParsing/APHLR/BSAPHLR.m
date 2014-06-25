//
//  BSAPHLR.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPHLR.h"

@implementation BSAPHLR

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPTimestamps class];
	[BSAPHLRReport class];
	[BSAPDLRReport class];
	[BSAPPMCCMNC class];
	
	BSAPHLR *hlr = [super classFromDict:dictionary];
	
	return hlr;
}

#pragma mark - Public methods

- (BSHLRModel *)convertToHLRModel
{
	NSDate *dateOfDeliverResponse = _timestamps.hlr.delivered!=nil && ![_timestamps.hlr.delivered isKindOfClass:[NSNull class]] && ![_timestamps.hlr.delivered isEqual:[NSNull null]] ? [NSDate dateWithTimeIntervalSince1970:[_timestamps.hlr.delivered doubleValue]] : nil;
	NSDate *dateOfInHLR = _timestamps.hlr.in!=nil && ![_timestamps.hlr.in isKindOfClass:[NSNull class]] && ![_timestamps.hlr.in isEqual:[NSNull null]] ? [NSDate dateWithTimeIntervalSince1970:[_timestamps.hlr.in doubleValue]] : nil;
	BSHLRReportModel *hlrReport = [[BSHLRReportModel alloc] initReportWithHLRReachedDate:dateOfInHLR andResponseReachedDate:dateOfDeliverResponse];
	
	NSDate *whenCallbackWasSent = _timestamps.dlr_out!=nil && ![_timestamps.dlr_out isKindOfClass:[NSNull class]] && ![_timestamps.dlr_out isEqual:[NSNull null]] ? [NSDate dateWithTimeIntervalSince1970:[_timestamps.dlr_out doubleValue]] : nil;
	
	BSTimestampsModel *timestamp = [[BSTimestampsModel alloc] initReportWithHLRReport:hlrReport andCallbackSentTime:whenCallbackWasSent];
	
	BSDLRReportModel *dlrReport = [[BSDLRReportModel alloc] initReportWithResponseStatus:_dlr.status andResponseCode:_dlr.error];
	
	BSMCCMNCModel *mccmnc = [[BSMCCMNCModel alloc] initWithMNC:_mccmnc.mnc andMCC:_mccmnc.mcc];
	
	BSMCCMNCModel *prefix = [[BSMCCMNCModel alloc] initWithMNC:_prefix.mnc andMCC:_prefix.mcc];
	
	BSHLRModel *hlr = [[BSHLRModel alloc] initHLRWithID:_id
											  timestamp:timestamp
											  dlrReport:dlrReport
												 mccmnc:mccmnc
												   imsi:_imsi
												 prefix:prefix
												 potred:_ported.boolValue
											  inRoaming:_roaming.boolValue];
	
	return hlr;
}

@end
