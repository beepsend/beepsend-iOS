//
//  BSAPSMSLookup.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPSMSLookup.h"

@implementation BSAPSMSLookup

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPBatch class];
	[BSAPConnection class];
	[BSAPDLRReport class];
	[BSAPRecipient class];
	[BSAPPMCCMNC class];
	[BSAPTimestamps class];

	BSAPSMSLookup *messageLookup = [super classFromDict:dictionary];
	
	return messageLookup;
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPSMSLookup classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

- (BSLookupModel *)convertToLookupModel
{
	BSBatchModel *bModel = [_batch convertToBatchModel];
	BSConnectionModel *cModel = [_connection convertToConnectionModel];
	
	BSDLRReportModel *report = [[BSDLRReportModel alloc] initReportWithResponseStatus:_dlr.status andResponseCode:_dlr.error];

	BSRecipientModel *sender = [[BSRecipientModel alloc] initRecipientWithNumber:_from.address numberType:_from.ton planIndex:_from.npi];
	
	BSMCCMNCModel *mccmnc = [[BSMCCMNCModel alloc] initWithMNC:_mccmnc.mnc andMCC:_mccmnc.mcc];
	
	NSDate *dateOfDeliverResponse = _timestamps.hlr.delivered!=nil && ![_timestamps.hlr.delivered isKindOfClass:[NSNull class]] && ![_timestamps.hlr.delivered isEqual:[NSNull null]] ? [NSDate dateWithTimeIntervalSince1970:[_timestamps.hlr.delivered doubleValue]] : nil;
	NSDate *dateOfInHLR = _timestamps.hlr.in!=nil && ![_timestamps.hlr.in isKindOfClass:[NSNull class]] && ![_timestamps.hlr.in isEqual:[NSNull null]] ? [NSDate dateWithTimeIntervalSince1970:[_timestamps.hlr.in doubleValue]] : nil;
	BSHLRReportModel *hlrReport = [[BSHLRReportModel alloc] initReportWithHLRReachedDate:dateOfInHLR andResponseReachedDate:dateOfDeliverResponse];
	
	NSDate *whenCallbackWasSent = _timestamps.dlr_out!=nil && ![_timestamps.dlr_out isKindOfClass:[NSNull class]] && ![_timestamps.dlr_out isEqual:[NSNull null]] ? [NSDate dateWithTimeIntervalSince1970:[_timestamps.dlr_out doubleValue]] : nil;
	
	BSTimestampsModel *timestamp = [[BSTimestampsModel alloc] initReportWithHLRReport:hlrReport andCallbackSentTime:whenCallbackWasSent];
	
	
	BSRecipientModel *recipient = [[BSRecipientModel alloc] initRecipientWithNumber:_to.address numberType:_to.ton planIndex:_to.npi];
	
	NSDateFormatter *smppFormatter = [[NSDateFormatter alloc] init];
	[smppFormatter setDateFormat:dateFormatForSMPPStandard];
	NSDate *validTo = [smppFormatter dateFromString:_validity_period];
	
	BSLookupModel *lookup = [[BSLookupModel alloc] initLookupWithID:_id
															  batch:bModel
															message:_body
													 usedConnection:cModel
														 dataCoding:_data_coding
													 deliveryReport:report
															 sender:sender
															 mccmnc:mccmnc
															  price:_price
														  timestamp:timestamp
														  recipient:recipient
															  valid:validTo];
	
	return lookup;
}

@end
