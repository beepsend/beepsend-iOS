//
//  BSMessageRequestModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/30/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSMessageRequestModel.h"

#import "BSGroupModel.h"

@interface BSMessageRequestModel ()

@property (nonatomic, strong, readwrite) id receiver;
@property (nonatomic, strong, readwrite) NSString *message;
@property (nonatomic, strong, readwrite) NSString *sender;
@property (nonatomic, strong, readwrite) NSString *batchID;
@property (nonatomic, strong, readwrite) NSString *batchLabel;
@property (nonatomic, strong, readwrite) NSDate *sendTime;
@property (nonatomic, strong, readwrite) NSString *usedEncoding;
@property (nonatomic, strong, readwrite) NSString *messageType;
@property (nonatomic, strong, readwrite) NSDate *validTo;
@property (nonatomic, strong, readwrite) NSNumber *receiveDeliveryReport;
@property (nonatomic, strong, readwrite) NSArray *groups;

@property (nonatomic, strong, readwrite) NSString *userDataHeader;
@property (nonatomic, strong, readwrite) NSString *dataCodingSettings;

@end

@implementation BSMessageRequestModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Message request"]) {
		
	}
	return self;
}

- (BSMessageRequestModel *)initWithMessage:(NSString *)rMessage
								  receiver:(id)rReceiver
									sender:(NSString *)rSender
								   batchID:(NSString *)rBatchID
								batchLabel:(NSString *)rBatchLabel
								  sendTime:(NSDate *)rSendTime
							  usedEncoding:(NSString *)rEncoding
							   messageType:(NSString *)rType
								   validTo:(NSDate *)rValidTo
								recieveDLR:(NSNumber *)rReceiveDLR
								 forGroups:(NSArray *)rGroups
							userDataHeader:(NSString *)rUDH
						dataCodingSettings:(NSString *)rDCS
{
	if (self = [super initWithID:@"0" andTitle:@"Message request"]) {
		_receiver = rReceiver;
		_message = rMessage;
		_sender = rSender;
		_batchID = rBatchID;
		_batchLabel = rBatchLabel;
		_sendTime = rSendTime;
		_usedEncoding = rEncoding;
		_messageType = rType;
		_validTo = rValidTo;
		_receiveDeliveryReport = rReceiveDLR;
		_groups = rGroups;
		
		_userDataHeader = rUDH;
		_dataCodingSettings = rDCS;
	}
	return self;
}

@end
