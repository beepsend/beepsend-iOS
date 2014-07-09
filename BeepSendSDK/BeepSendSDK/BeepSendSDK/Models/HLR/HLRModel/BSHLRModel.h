//
//  BSHLRModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSDLRReportModel.h"
#import "BSMCCMNC.h"
#import "BSTimestampsModel.h"

@interface BSHLRModel : BSGeneralModel

@property (nonatomic, strong, readonly) BSTimestampsModel *timestamps;
@property (nonatomic, strong, readonly) BSDLRReportModel *dlrReport;
@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;
@property (nonatomic, strong, readonly) NSString *imsi;//The IMSI of the handset if available. First five characters and then zeroes.
@property (nonatomic, strong, readonly) NSNumber *ported;//true if the number seems to be ported, false if not.
@property (nonatomic, strong, readonly) NSNumber *roaming;//true if the number is roaming, false if not.
@property (nonatomic, strong, readonly) BSMCCMNC *prefix;

- (BSHLRModel *)initHLRWithID:(NSString *)hlrID
					timestamp:(BSTimestampsModel *)hlrTimestamp
					dlrReport:(BSDLRReportModel *)hlrDlrReport
					   mccmnc:(BSMCCMNC *)hlrMccMnc
						 imsi:(NSString *)hlrImsi
					   prefix:(BSMCCMNC *)hlrPrefix
					   potred:(NSNumber *)isPorted
					inRoaming:(NSNumber *)isInRoaming;

@end
