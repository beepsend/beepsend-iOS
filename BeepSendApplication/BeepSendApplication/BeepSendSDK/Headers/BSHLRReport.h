//
//  BSHLRReportModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSHLRReport
 @discussion HLR report contains times when HLR reached BeepSend and
 when HLR response reached BeepSend.
 */
@interface BSHLRReport : BSGeneralModel

/*! When the HLR reached Beepsend.
 */
@property (nonatomic, strong, readonly) NSDate *hlrReachedAt;

/*! When HLR response reached Beepsend.
 */
@property (nonatomic, strong, readonly) NSDate *responseReachedAt;

/*! Create HLR Report object
 
 @param rDate - When the HLR reached Beepsend
 @param sDate - When HLR response reached Beepsend
 
 @return Returns HLR Report object
 */
- (BSHLRReport *)initReportWithHLRReachedDate:(NSDate *)rDate
					   andResponseReachedDate:(NSDate *)sDate;

@end

