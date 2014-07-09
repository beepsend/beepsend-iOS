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

@interface BSNetwork : BSGeneralModel

@property (nonatomic, strong, readonly) NSArray *mccmnc;
@property (nonatomic, strong, readonly) NSString *comment;
@property (nonatomic, strong, readonly) NSNumber *price;
@property (nonatomic, strong, readonly) BSCountry *country;
@property (nonatomic, strong, readonly) NSString *operatorName;

- (BSNetwork *)initNetworkWithMCCMNC:(NSArray *)nMCCMNC
						 withComment:(NSString *)nComment
							   price:(NSNumber *)nPrice
						 fromCountry:(BSCountry *)nCountry
							operator:(NSString *)nOperatorName;

@end
