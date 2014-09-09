//
//  BSNetworkModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSMCCMNC.h"
#import "BSCountry.h"

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

/*! Old price of sending to this network in Euro (€).
 */
@property (nonatomic, strong, readonly) NSNumber *oldPrice;

/*! Type of differece between revisions, possible values 'price', 'new' or 'removed'
 */
@property (nonatomic, strong, readonly) NSString *difference;

/*! Create Network object
 
 @param nMCCMNC - MCC and MNC of the network
 @param nComment - Specific details about this network
 @param nPrice - Price of sending to this network in Euro (€)
 @param nCountry - Country this network resides in
 @param nOperatorName - Operator name
 @param nOldPrice - Old price of sending to this network
 @param nDifference - Type of differece between revisions
 
 @return Returns Network object
 */
- (BSNetwork *)initNetworkWithMCCMNC:(NSArray *)nMCCMNC
						 withComment:(NSString *)nComment
							   price:(NSNumber *)nPrice
						 fromCountry:(BSCountry *)nCountry
							operator:(NSString *)nOperatorName
							oldPrice:(NSNumber *)nOldPrice
						  difference:(NSString *)nDifference;

@end
