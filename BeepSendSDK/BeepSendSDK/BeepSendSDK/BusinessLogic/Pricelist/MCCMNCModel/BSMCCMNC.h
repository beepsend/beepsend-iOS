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

- (BSMCCMNC *)initWithMNC:(NSNumber *)mnc
				   andMCC:(NSNumber *)mcc;

@end
