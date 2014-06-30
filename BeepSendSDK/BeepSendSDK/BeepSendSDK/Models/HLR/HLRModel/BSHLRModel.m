//
//  BSHLRModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSHLRModel.h"

@interface BSHLRModel ()

@property (nonatomic, strong, readwrite) BSTimestampsModel *timestamps;
@property (nonatomic, strong, readwrite) BSDLRReportModel *dlrReport;
@property (nonatomic, strong, readwrite) BSMCCMNCModel *mccmnc;
@property (nonatomic, strong, readwrite) NSString *imsi;//The IMSI of the handset if available. First five characters and then zeroes.
@property (nonatomic, strong, readwrite) NSNumber *ported;//true if the number seems to be ported, false if not.
@property (nonatomic, strong, readwrite) NSNumber *roaming;//true if the number is roaming, false if not.
@property (nonatomic, strong, readwrite) BSMCCMNCModel *prefix;

@end

@implementation BSHLRModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular HLR"]) {
		
	}
	return self;
}

- (BSHLRModel *)initHLRWithID:(NSString *)hlrID
					timestamp:(BSTimestampsModel *)hlrTimestamp
					dlrReport:(BSDLRReportModel *)hlrDlrReport
					   mccmnc:(BSMCCMNCModel *)hlrMccMnc
						 imsi:(NSString *)hlrImsi
					   prefix:(BSMCCMNCModel *)hlrPrefix
					   potred:(NSNumber *)isPorted
					inRoaming:(NSNumber *)isInRoaming
{
	if (self = [super initWithID:hlrID andTitle:@"HLR"]) {
		_timestamps = hlrTimestamp;
		_dlrReport = hlrDlrReport;
		_mccmnc = hlrMccMnc;
		_imsi = hlrImsi;
		_prefix = hlrPrefix;
		_ported = isPorted;
		_roaming = isInRoaming;
	}
	return self;
}

@end
