//
//  BSConversation.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSSender.h"

@interface BSConversation : BSGeneralModel

/*! Unique ID for this conversation. Based on to and from values.
 */
@property (nonatomic, strong, readonly) NSString *conversationID;

/*! Your system phone number.
 */
@property (nonatomic, strong, readonly) NSString *recipient;

/*! The receiving number.
 */
@property (nonatomic, strong, readonly) BSSender *sender;

/*! Last received body from the
 */
@property (nonatomic, strong, readonly) NSString *messageBody;

/*! Unixtime of the last received message.
 */
@property (nonatomic, strong, readonly) NSDate *lastReceivedMessageAt;

/*! A list of sms objects
 */
@property (nonatomic, strong, readonly) NSArray *items;

/*! Create BSConversation object
 
 @param cID - Unique ID for this conversation
 @param cRecipient - Your system phone number
 @param cSender - The receiving number
 @param cMessageBody - Last received body from the
 @param cLastReceivedMessageAt - Unixtime of the last received message
 @param cItems - A list of sms objects
 
 @return Returns BSConversation object
 */
- (BSConversation *)initConversationWithID:(NSString *)cID
								 recipient:(NSString *)cRecipient
									sender:(BSSender *)cSender
							   messageBody:(NSString *)cMessageBody
					 lastReceivedMessageAt:(NSDate *)cLastReceivedMessageAt
									 items:(NSArray *)cItems;

@end
