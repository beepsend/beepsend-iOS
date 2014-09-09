//
//  BSAPMessageRequest.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPMessageRequest.h"

#import "BSGroup.h"

#import "BSMessage.h"
#import "BSBatch.h"

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
	
	return [[BSMessage alloc] initWithMessage:_message
									 receiver:_to
									   sender:_from
									  batchID:_batch_id
								   batchLabel:_batch_label
									 sendTime:sendDate
								 usedEncoding:_encoding
								  messageType:_message_type
									  validTo:validTo
								   recieveDLR:_receive_dlr
									forGroups:_groups
							   userDataHeader:_udh
						   dataCodingSettings:_dcs];
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

+ (BSAPMessageRequest *)convertFromMessageRequestModel:(BSMessage *)msgRequest
{
	BSAPMessageRequest *request = [[BSAPMessageRequest alloc] init];
	
	request.to = msgRequest.recipient ? msgRequest.recipient : msgRequest.recipients;
	request.message = msgRequest.message;
	request.from = msgRequest.sender;
	request.batch_id = [msgRequest.batch.batchID isEqualToString:@"0"] ? nil : msgRequest.batch.batchID;
	request.batch_label = [msgRequest.batch.label isEqualToString:@""] ? nil : msgRequest.batch.label;
	request.send_time = msgRequest.sendTime ? [NSString stringWithFormat:@"%f", [msgRequest.sendTime timeIntervalSince1970]] : nil;
	request.encoding = [msgRequest.usedEncoding isEqualToString:@""] ? nil : msgRequest.usedEncoding;
	request.message_type = [msgRequest.messageType isEqualToString:@""] ? nil : msgRequest.messageType;
	request.validity_period = msgRequest.validTo ? [NSString stringWithFormat:@"%f", [msgRequest.validTo timeIntervalSince1970]] : nil;
	request.receive_dlr = [NSNumber numberWithInteger:msgRequest.shouldReceiveDeliveryReport];
	
	//If groups array consists of BSGroupModel
	//than convert it to array of strings (group ids)
	NSMutableArray *groupsID = [@[] mutableCopy];
	if (msgRequest.groups && msgRequest.groups.count>0) {
		if ([msgRequest.groups[0] isKindOfClass:[BSGroup class]]) {
			for (BSGroup *group in msgRequest.groups) {
				[groupsID addObject:group.objectID];
			}
		}
		else {
			groupsID = [msgRequest.groups mutableCopy];
		}
	}
	request.groups = groupsID.count>0?[NSArray arrayWithArray:groupsID]:nil;
	
	request.udh = [msgRequest.userDataHeader isEqualToString:@""] ? nil : msgRequest.userDataHeader;
	request.dcs = [msgRequest.dataCodingSettings isEqualToString:@""] ? nil : msgRequest.dataCodingSettings;
	
	return request;
}

@end
