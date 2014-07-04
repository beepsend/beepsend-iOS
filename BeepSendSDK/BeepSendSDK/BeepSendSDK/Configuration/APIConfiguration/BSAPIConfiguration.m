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
	return [NSString stringWithFormat:@"https://api.beepsend.com/%@", [BSAPIConfiguration APIVersion]];
}

+ (NSDictionary *)authorizationHeader {
	return [BSAPIConfiguration authorizationHeaderForToken:APIToken];
}

+ (NSDictionary *)authorizationHeaderForToken:(NSString *)token
{
	return @{ @"Authorization" : [NSString stringWithFormat:@"Token %@", token] };
}

+ (NSString *)urlAPIToken {
	return [@"?api_token=" stringByAppendingString:APIToken];
}

#pragma mark -
#pragma mark - Methods

#pragma mark - Customer

+ (NSString *)customer {
	return @"/customer/";
}

#pragma mark - Connections

+ (NSString *)connections
{
	return @"/connections/";
}

+ (NSString *)connectionsMe
{
	return @"/connections/me";
}

+ (NSString *)connectionsWithID:(NSString *)connectionID
{
	return [@"/connections/" stringByAppendingString:connectionID];
}

+ (NSString *)connectionResetForID:(NSString *)connectionID
{
	return [NSString stringWithFormat:@"/connections/%@/tokenreset", connectionID];
}

+ (NSString *)connectionPasswordResetForID:(NSString *)connectionID
{
	return [NSString stringWithFormat:@"/connections/%@/passwordreset", connectionID];
}

#pragma mark - Pricelist

+ (NSString *)pricelistCurrentWithID:(NSString *)connectionID
{
	return [NSString stringWithFormat:@"/connections/%@/pricelists/current", connectionID];
}

+ (NSString *)pricelistCurrentMe
{
	return @"/connections/me/pricelists/current";
}

+ (NSString *)pricelistAllForID:(NSString *)connectionID
{
	return [NSString stringWithFormat:@"/connections/%@/pricelists/", connectionID];
}

+ (NSString *)pricelistAllMe
{
	return @"/connections/me/pricelists/";
}

+ (NSString *)pricelistCSVForID:(NSString *)connectionID
{
	return [NSString stringWithFormat:@"/pricelists/%@.csv", connectionID];
}

#pragma mark - Users

+ (NSString *)userMe
{
	return @"/users/me";
}

+ (NSString *)updateUserEmail
{
	return @"/users/me/email";
}

+ (NSString *)updateUserPassword
{
	return @"/users/me/password";
}

+ (NSString *)resetPassword
{
	return @"/users/passwordreset";
}

+ (NSString *)setNewPasswordWithHash:(NSString *)hash
{
	return [NSString stringWithFormat:@"/users/password/%@", hash];
}

+ (NSString *)resetTokenMe
{
	return @"/users/me/tokenreset";
}

+ (NSString *)resetTokenForID:(NSString *)userID
{
	return [NSString stringWithFormat:@"/users/%@/tokenreset", userID];
}

#pragma mark - Send SMS

+ (NSString *)sms
{
	return @"/sms/";
}

+ (NSString *)smsForID:(NSString *)connectionID
{
	return [@"/sms/" stringByAppendingString:connectionID];
}

#pragma mark - SMS Lookup

+ (NSString *)smsLookupWithID:(NSString *)smsID
{
	return [@"/sms/" stringByAppendingString:smsID];
}

#pragma mark - HLR

+ (NSString *)hlrForNumber:(NSString *)number
{
	return [@"/hlr/" stringByAppendingString:number];
}

#pragma mark - Validation

+ (NSString *)validateSMS
{
	return @"/sms/validate/";
}

+ (NSString *)validateHLR
{
	return @"/hlr/validate";
}

#pragma mark - Batches

+ (NSString *)batches;
{
	return @"/batches/";
}

+ (NSString *)batchesForID:(NSString *)batchID
{
	return [@"/batches/" stringByAppendingString:batchID];
}

#pragma mark - Analytics

+ (NSString *)analyticsSummary
{
	return @"/analytics/summary/";
}

+ (NSString *)analyticsSummaryMe
{
	return @"/analytics/summary/me";
}

+ (NSString *)analyticsSummaryForID:(NSString *)connectionID
{
	return [@"/analytics/summary/" stringByAppendingString:connectionID];
}

+ (NSString *)analyticsNetwork
{
	return @"/analytics/network/";
}

+ (NSString *)analyticsNetworkMe
{
	return @"/analytics/network/me";
}

+ (NSString *)analyticsNetworkForID:(NSString *)connectionID
{
	return [@"/analytics/network/" stringByAppendingString:connectionID];
}

+ (NSString *)analyticsBatches
{
	return @"/analytics/batches/";
}

+ (NSString *)analyticsBatchesForID:(NSString *)batchID
{
	return [@"/analytics/batches/" stringByAppendingString:batchID];
}

#pragma mark - Contacts

+ (NSString *)contactsForID:(NSString *)contactID
{
	return [@"/contacts/" stringByAppendingString:contactID];
}

+ (NSString *)contacts
{
	return @"/contacts/";
}

#pragma mark - Contact groups

+ (NSString *)contactsGroups
{
	return @"/contacts/groups/";
}

+ (NSString *)contactsGroupsForID:(NSString *)groupID
{
	return [@"/contacts/groups/" stringByAppendingString:groupID];
}

#pragma mark - Search contact groups

+ (NSString *)searchContacts
{
	return @"/search/contacts/";
}

+ (NSString *)searchContactGroups
{
	return @"/search/contact_groups/";
}

#pragma mark - Wallets

+ (NSString *)wallets
{
	return @"/wallets/";
}

+ (NSString *)walletsForID:(NSString *)walletID
{
	return [@"/wallets/" stringByAppendingString:walletID];
}

#pragma mark - Estimate SMS cost

+ (NSString *)smsCostEstimate
{
	return @"/sms/costestimate/";
}

+ (NSString *)smsCostEstimateForID:(NSString *)connectionID
{
	return [@"/sms/costestimate/" stringByAppendingString:connectionID];
}

@end
