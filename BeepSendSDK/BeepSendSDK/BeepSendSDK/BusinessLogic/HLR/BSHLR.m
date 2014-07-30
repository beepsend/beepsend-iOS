//
//  BSHLRModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSHLR.h"

@interface BSHLR ()

@property (nonatomic, strong, readwrite) NSString *hlrID;
@property (nonatomic, strong, readwrite) BSTimestamps *timestamps;
@property (nonatomic, strong, readwrite) BSDLRReport *dlrReport;
@property (nonatomic, strong, readwrite) BSMCCMNC *mccmnc;
@property (nonatomic, strong, readwrite) NSString *imsi;//The IMSI of the handset if available. First five characters and then zeroes.
@property (nonatomic, strong, readwrite) NSNumber *ported;//true if the number seems to be ported, false if not.
@property (nonatomic, strong, readwrite) NSNumber *roaming;//true if the number is roaming, false if not.
@property (nonatomic, strong, readwrite) BSMCCMNC *prefix;

@property (nonatomic, strong, readwrite) NSString *phoneNumber;
@property (nonatomic, strong, readwrite) NSArray *errors;

@end

@implementation BSHLR

#pragma mark - Properties

- (NSString *)hlrID
{
	return [BSHelper isNilOrEmpty:_hlrID] ? @"0" : [_hlrID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_hlrID stringValue] : _hlrID;
}

- (NSString *)imsi
{
	return [BSHelper isNilOrEmpty:_imsi] ? @"" : _imsi;
}

- (NSNumber *)ported
{
	return _ported ? _ported : @NO;
}

- (NSNumber *)roaming
{
	return _roaming ? _roaming : @NO;
}

- (NSString *)phoneNumber
{
	return [BSHelper isNilOrEmpty:_phoneNumber] ? @"" : _phoneNumber;
}

- (NSArray *)errors
{
	return _errors ? _errors : @[];
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular HLR"]) {
		
	}
	return self;
}

- (BSHLR *)initHLRWithID:(NSString *)hlrID
			   timestamp:(BSTimestamps *)hlrTimestamp
			   dlrReport:(BSDLRReport *)hlrDlrReport
				  mccmnc:(BSMCCMNC *)hlrMccMnc
					imsi:(NSString *)hlrImsi
				  prefix:(BSMCCMNC *)hlrPrefix
				  potred:(NSNumber *)isPorted
			   inRoaming:(NSNumber *)isInRoaming
			  withErrors:(NSArray *)errors
{
	if (self = [super initWithID:hlrID andTitle:@"HLR"]) {
		_hlrID = hlrID;
		_timestamps = hlrTimestamp;
		_dlrReport = hlrDlrReport;
		_mccmnc = hlrMccMnc;
		_imsi = hlrImsi;
		_prefix = hlrPrefix;
		_ported = isPorted;
		_roaming = isInRoaming;
		_errors = errors;
	}
	return self;
}

- (BSHLR *)initHLRWithNumber:(NSString *)phoneNumber andErrors:(NSArray *)errors
{
	if (self = [super initWithID:@"0" andTitle:@"HLR"]) {
		_phoneNumber = phoneNumber;
		_errors = errors;
	}
	return self;
}

@end
