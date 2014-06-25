//
//  BSTimestampsModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSHLRReportModel.h"

@interface BSTimestampsModel : BSGeneralModel

@property (nonatomic, strong, readonly) BSHLRReportModel *hlr;
@property (nonatomic, strong, readonly) NSDate *callbackSentAt;

- (BSTimestampsModel *)initReportWithHLRReport:(BSHLRReportModel *)hlrReport
						   andCallbackSentTime:(NSDate *)sDate;

@end
