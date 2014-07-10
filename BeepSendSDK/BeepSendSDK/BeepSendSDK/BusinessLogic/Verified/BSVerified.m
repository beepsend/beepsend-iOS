//
//  BSVerifiedModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSVerified.h"

@implementation BSVerified

#pragma mark - Properties

- (BOOL)isVerifiedEmail {
	return [_emailVerified boolValue];
}

- (BOOL)isVerifiedPhone {
	return [_phoneVerified boolValue];
}

- (BOOL)isVerifiedTerms {
	return [_termsVerified boolValue];
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular verified"]) {
		
	}
	return self;
}

- (BSVerified *)initUserWithTermsVerified:(NSNumber *)termsVerified
{
	if (self = [super initWithID:@"0" andTitle:@"Verified"]) {
		_termsVerified = termsVerified;
	}
	return self;
}

- (BSVerified *)initUserWithEmailVerified:(NSNumber *)emailVerified
							phoneVerified:(NSNumber *)phoneVerified
							termsVerified:(NSNumber *)termsVerified
{
	if (self = [super initWithID:@"0" andTitle:@"Verified"]) {
		_emailVerified = emailVerified;
		_phoneVerified = phoneVerified;
		_termsVerified = termsVerified;
	}
	return self;
}

@end
