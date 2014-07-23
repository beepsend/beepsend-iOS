//
//  BSNetworkModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSMCCMNC;
@class BSCountry;

@interface BSNetwork : BSGeneralModel

/** MCC MNC of the network.
 */
@property (nonatomic, strong, readonly) NSArray *mccmnc;

/** (Optional) Specific details about this network.
 */
@property (nonatomic, strong, readonly) NSString *comment;

/** Price of sending to this network in Euro (€)
 */
@property (nonatomic, strong, readonly) NSNumber *price;

/** Country this network resides in.
 */
@property (nonatomic, strong, readonly) BSCountry *country;

/** Operator name.
 */
@property (nonatomic, strong, readonly) NSString *operatorName;

- (BSNetwork *)initNetworkWithMCCMNC:(NSArray *)nMCCMNC
						 withComment:(NSString *)nComment
							   price:(NSNumber *)nPrice
						 fromCountry:(BSCountry *)nCountry
							operator:(NSString *)nOperatorName;

@end
