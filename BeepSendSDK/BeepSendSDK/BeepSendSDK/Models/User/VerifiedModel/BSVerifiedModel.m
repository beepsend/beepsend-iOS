//
//  BSVerifiedModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSVerifiedModel.h"

@interface BSVerifiedModel ()

@property (nonatomic, assign, readwrite, getter = isEmailVerified) BOOL emailVerified;
@property (nonatomic, assign, readwrite, getter = isPhoneVerified) BOOL phoneVerified;
@property (nonatomic, assign, readwrite, getter = isTermsVerified) BOOL termsVerified;

@end

@implementation BSVerifiedModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular verified"]) {
		
	}
	return self;
}

- (BSVerifiedModel *)initUserWithEmailVerified:(BOOL)emailVerified
								 phoneVerified:(BOOL)phoneVerified
								 termsVerified:(BOOL)termsVerified
{
	if (self = [super initWithID:@"0" andTitle:@"Verified"]) {
		_emailVerified = emailVerified;
		_phoneVerified = phoneVerified;
		_termsVerified = termsVerified;
	}
	return self;
}

@end
