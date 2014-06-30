//
//  BSAPMessageRequest.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPMessageRequest.h"

#import "BSMessageRequestModel.h"

@implementation BSAPMessageRequest

#pragma mark - Inherited methods

- (id)convertToModel
{
	NSDate *sendDate =
	_send_time!=nil && ![_send_time isKindOfClass:[NSNull class]] && ![_send_time isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_send_time doubleValue]]
	:
	nil;
	
	NSDate *validTo =
	_validity_period!=nil && ![_validity_period isKindOfClass:[NSNull class]] && ![_validity_period isEqual:[NSNull null]]
	?
	[NSDate dateWithTimeIntervalSince1970:[_validity_period doubleValue]]
	:
	nil;
	
	return [[BSMessageRequestModel alloc] initWithMessage:_message
												 receiver:_to
												   sender:_from
												  batchID:_batch_id
											   batchLabel:_batch_label
												 sendTime:sendDate
											 usedEncoding:_encoding
											  messageType:_message_type
												  validTo:validTo
											   recieveDLR:_receive_dlr
												forGroups:_groups];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPMessageRequest classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

+ (NSArray *)arrayOfObjectsFromArrayOfModels:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id model in array) {
		[results addObject:[BSAPMessageRequest convertFromMessageRequestModel:model]];
	}
	return [NSArray arrayWithArray:results];
}

+ (BSAPMessageRequest *)convertFromMessageRequestModel:(BSMessageRequestModel *)msgRequest
{
	BSAPMessageRequest *request = [[BSAPMessageRequest alloc] init];
	
	request.to = msgRequest.receiver;
	request.message = msgRequest.message;
	request.from = msgRequest.sender;
	request.batch_id = msgRequest.batchID;
	request.batch_label = msgRequest.batchLabel;
	request.send_time = msgRequest.sendTime?[NSString stringWithFormat:@"%f", [msgRequest.sendTime timeIntervalSince1970]]:nil;
	request.encoding = msgRequest.usedEncoding;
	request.message_type = msgRequest.messageType;
	request.validity_period = msgRequest.validTo?[NSString stringWithFormat:@"%f", [msgRequest.validTo timeIntervalSince1970]]:nil;
	request.receive_dlr = msgRequest.receiveDeliveryReport;
	request.groups = msgRequest.groups;
	
	return request;
}

@end
