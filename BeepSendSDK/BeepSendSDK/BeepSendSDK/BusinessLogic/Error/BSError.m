//
//  BSError.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSError.h"

@implementation BSError

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Error"]) {
		_code = @0;
		_errorDescription = @"";
	}
	return self;
}

- (BSError *)initWithCode:(NSNumber *)code andDescription:(NSString *)desc
{
	if (self = [super initWithID:@"0" andTitle:@"Error"]) {
		_code = code;
		_errorDescription = desc;
	}
	return self;
}

@end
