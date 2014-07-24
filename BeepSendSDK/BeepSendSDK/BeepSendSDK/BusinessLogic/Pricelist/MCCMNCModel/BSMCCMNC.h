//
//  BSMCCMNCModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSMCCMNC : BSGeneralModel

/** MNC of the network.
 */
@property (nonatomic, strong, readonly) NSNumber *mnc;

/** MCC of the network.
 */
@property (nonatomic, strong, readonly) NSNumber *mcc;

/** Init MCCMNC with mcc and mnc
 
 @param mnc - Mobile network code
 @param mcc - Mobile country code
 
 @return Returns MCCMNC object
 */
- (BSMCCMNC *)initWithMNC:(NSNumber *)mnc
				   andMCC:(NSNumber *)mcc;

@end
