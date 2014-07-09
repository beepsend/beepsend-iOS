//
//  BSCountryModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSCountry : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *callingCode;
@property (nonatomic, strong, readonly) NSString *code;

- (BSCountry *)initCountryNamed:(NSString *)cName
				withCountryCode:(NSString *)cCountryCode
				 andCallingCode:(NSNumber *)cCallingCode;

@end
