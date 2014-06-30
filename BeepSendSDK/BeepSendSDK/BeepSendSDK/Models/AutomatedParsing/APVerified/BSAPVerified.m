//
//  BSAPVerified.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPVerified.h"

#import "BSVerifiedModel.h"

@implementation BSAPVerified

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSVerifiedModel alloc] initUserWithEmailVerified:_email?_email:nil phoneVerified:_phone?_phone:nil termsVerified:_terms?_terms:nil];
}

@end
