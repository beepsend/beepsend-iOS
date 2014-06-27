//
//  BSAPHLRReport.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPHLRReport.h"

#import "BSHLRReportModel.h"

@implementation BSAPHLRReport

#pragma mark - Inherited methods

- (id)convertToModel
{
	NSDate *dateOfDeliverResponse =
	_delivered!=nil && ![_delivered isKindOfClass:[NSNull class]] && ![_delivered isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_delivered doubleValue]]
	:
	nil;
	
	NSDate *dateOfInHLR =
	_in!=nil && ![_in isKindOfClass:[NSNull class]] && ![_in isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_in doubleValue]]
	:
	nil;
	
	return [[BSHLRReportModel alloc] initReportWithHLRReachedDate:dateOfInHLR andResponseReachedDate:dateOfDeliverResponse];
}

@end
