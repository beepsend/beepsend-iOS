//
//  BSConversation.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSConversation.h"

@interface BSConversation ()

@property (nonatomic, strong, readwrite) NSString *id;
@property (nonatomic, strong, readwrite) NSString *to;
@property (nonatomic, strong, readwrite) BSSender *from;
@property (nonatomic, strong, readwrite) NSString *body;
@property (nonatomic, strong, readwrite) NSString *timestamp;
@property (nonatomic, strong, readwrite) NSArray *items;

@end

@implementation BSConversation

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular conversation"]) {
		
	}
	return self;
}

- (BSConversation *)initConversationWithID:(NSString *)cID
								 recipient:(NSString *)cRecipient
									sender:(BSSender *)cSender
							   messageBody:(NSString *)cMessageBody
					 lastReceivedMessageAt:(NSDate *)cLastReceivedMessageAt
									 items:(NSArray *)cItems
{
	if (self = [super initWithID:cID andTitle:@"Conversation"]) {
		_conversationID = cID;
		_recipient = cRecipient;
		_sender = cSender;
		_messageBody = cMessageBody;
		_lastReceivedMessageAt = cLastReceivedMessageAt;
		_items = cItems;
	}
	return self;
}

@end
