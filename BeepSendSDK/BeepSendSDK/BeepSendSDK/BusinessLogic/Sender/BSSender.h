//
//  BSSender.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSContact.h"

@interface BSSender : BSGeneralModel

/*! The receiving number.
 */
@property (nonatomic, strong, readonly) NSString *receivingNumber;

/*! Matching contact, if any.
 */
@property (nonatomic, strong, readonly) BSContact *correspondingContact;

/*! Create BSSender object
 
 @param number - The receiving number
 @param contact - Matching contact, if any
 
 @return Returns BSSender object
 */
- (BSSender *)initWithNumber:(NSString *)number andContact:(BSContact *)contact;

@end
