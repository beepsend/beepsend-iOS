//
//  BSSender.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSender.h"

@interface BSSender ()

@property (nonatomic, strong, readwrite) NSString *receivingNumber;
@property (nonatomic, strong, readwrite) BSContact *correspondingContact;

@end

@implementation BSSender

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular sender"]) {

	}
	return self;
}

- (BSSender *)initWithNumber:(NSString *)number andContact:(BSContact *)contact
{
	if (self = [super initWithID:@"0" andTitle:@"ID User type"]) {
		_receivingNumber = number;
		_correspondingContact = contact;
	}
	return self;
}

@end
