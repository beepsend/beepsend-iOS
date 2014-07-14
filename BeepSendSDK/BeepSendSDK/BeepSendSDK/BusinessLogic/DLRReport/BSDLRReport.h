//
//  BSDLRReportModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSDLRReport : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *responseStatus;
@property (nonatomic, strong, readonly) NSNumber *responseCode;

- (BSDLRReport *)initReportWithResponseStatus:(NSString *)rStatus
							  andResponseCode:(NSNumber *)rCode;

@end
