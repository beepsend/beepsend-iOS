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

/*!
 @class BSNetwork
 @discussion Network model shows which networks are covered by specific pricelist.
 */
@interface BSNetwork : BSGeneralModel

/*! MCC and MNC of the network.
 */
@property (nonatomic, strong, readonly) NSArray *mccmnc;

/*! (Optional) Specific details about this network.
 */
@property (nonatomic, strong, readonly) NSString *comment;

/*! Price of sending to this network in Euro (€)
 */
@property (nonatomic, strong, readonly) NSNumber *price;

/*! Country this network resides in.
 */
@property (nonatomic, strong, readonly) BSCountry *country;

/*! Operator name.
 */
@property (nonatomic, strong, readonly) NSString *operatorName;

/*! Create Network object
 
 @param nMCCMNC - MCC and MNC of the network
 @param nComment - Specific details about this network
 @param nPrice - Price of sending to this network in Euro (€)
 @param nCountry - Country this network resides in
 @param nOperatorName - Operator name
 
 @return Returns Network object
 */
- (BSNetwork *)initNetworkWithMCCMNC:(NSArray *)nMCCMNC
						 withComment:(NSString *)nComment
							   price:(NSNumber *)nPrice
						 fromCountry:(BSCountry *)nCountry
							operator:(NSString *)nOperatorName;

@end
