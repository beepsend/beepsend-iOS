//
//  BSTimestampsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSHLRReport.h"

/*!
 @class BSTimestamps
 @discussion Timestamps model contains times when HLR reached BeepSend, 
 when HLR response reached BeepSend and when callback was sent.
 */
@interface BSTimestamps : BSGeneralModel

/*! HLR timestamps.
 */
@property (nonatomic, strong, readonly) BSHLRReport *hlr;

/*! When callback was sent.
 */
@property (nonatomic, strong, readonly) NSDate *callbackSentAt;

/*! Create Timestamp object
 
 @param hlrReport - HLR timestamps
 @param sDate - When callback was sent
 
 @return Returns Timestamp object
 */
- (BSTimestamps *)initReportWithHLRReport:(BSHLRReport *)hlrReport
					  andCallbackSentTime:(NSDate *)sDate;

@end
