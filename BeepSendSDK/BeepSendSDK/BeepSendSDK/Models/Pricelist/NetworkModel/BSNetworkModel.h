//
//  BSNetworkModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSMCCMNCModel.h"
#import "BSCountryModel.h"

@interface BSNetworkModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSArray *mccmnc;
@property (nonatomic, strong, readonly) NSString *comment;
@property (nonatomic, strong, readonly) NSNumber *price;
@property (nonatomic, strong, readonly) BSCountryModel *country;
@property (nonatomic, strong, readonly) NSString *operatorName;

- (BSNetworkModel *)initNetworkWithMCCMNC:(NSArray *)nMCCMNC
							  withComment:(NSString *)nComment
									price:(NSNumber *)nPrice
							  fromCountry:(BSCountryModel *)nCountry
								 operator:(NSString *)nOperatorName;

@end
