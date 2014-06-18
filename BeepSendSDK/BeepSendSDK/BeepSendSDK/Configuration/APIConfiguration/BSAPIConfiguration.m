//
//  BSAPIConfiguration.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPIConfiguration.h"

@interface BSAPIConfiguration (Private)

+ (NSString *)APIVersion;

@end

@implementation BSAPIConfiguration

#pragma mark - Private methods

+ (NSString *)APIVersion
{
	return @"2";
}

#pragma mark - Class methods

+ (NSString *)baseURL
{
	return [NSString stringWithFormat:@"https://api.beepsend.com/%@/", [BSAPIConfiguration APIVersion]];
}

+ (NSDictionary *)authorizationHeader {
	return @{ @"Authorization" : [NSString stringWithFormat:@"Token %@", APIToken] };
}

+ (NSString *)urlAPIToken {
	return [@"?api_token=" stringByAppendingString:APIToken];
}

#pragma mark -
#pragma mark - Methods

#pragma mark - Customer

+ (NSString *)customer {
	return @"customer/";
}

#pragma mark - Connections

+ (NSString *)connections
{
	return @"connections/";
}

+ (NSString *)connectionsMe
{
	return @"connections/me";
}

+ (NSString *)connectionsWithID:(NSString *)connectionID
{
	return [@"connections/" stringByAppendingString:connectionID];
}

+ (NSString *)connectionResetForID:(NSString *)connectionID
{
	return [NSString stringWithFormat:@"connections/%@/tokenreset", connectionID];
}

+ (NSString *)connectionPasswordResetForID:(NSString *)connectionID
{
	return [NSString stringWithFormat:@"connections/%@/passwordreset", connectionID];
}

#pragma mark - Send SMS

+ (NSString *)sms
{
	return @"sms/";
}

#pragma mark - HLR

+ (NSString *)hlrForNumber:(NSString *)number
{
	return [@"hlr/" stringByAppendingString:number];
}

#pragma mark - Estimate SMS cost

+ (NSString *)smsCostEstimate
{
	return @"sms/costestimate/";
}

@end
