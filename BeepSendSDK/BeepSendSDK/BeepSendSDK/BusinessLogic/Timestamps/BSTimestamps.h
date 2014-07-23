//
//  BSTimestampsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSHLRReport;

@interface BSTimestamps : BSGeneralModel

/** HLR timestamps
 */
@property (nonatomic, strong, readonly) BSHLRReport *hlr;

/** When callback was sent.
 */
@property (nonatomic, strong, readonly) NSDate *callbackSentAt;

- (BSTimestamps *)initReportWithHLRReport:(BSHLRReport *)hlrReport
					  andCallbackSentTime:(NSDate *)sDate;

@end
