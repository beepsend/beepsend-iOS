//
//  BSMCCMNCModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSMCCMNC
 @discussion MCC MNC is model that contains two properties: MCC and MNC.
 */
@interface BSMCCMNC : BSGeneralModel

/*! Mobile Network Code.
 */
@property (nonatomic, strong, readonly) NSNumber *mnc;

/*! Mobile Country Code.
 */
@property (nonatomic, strong, readonly) NSNumber *mcc;

/*! Create MCCMNC object
 
 @param mnc - Mobile network code
 @param mcc - Mobile country code
 
 @return Returns MCCMNC object
 */
- (BSMCCMNC *)initWithMNC:(NSNumber *)mnc
				   andMCC:(NSNumber *)mcc;

@end
