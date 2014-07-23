//
//  BSCountryModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSCountry : BSGeneralModel

/** Name of the country this network resides in.
 */
@property (nonatomic, strong, readonly) NSString *name;

/** Country calling code.
 */
@property (nonatomic, strong, readonly) NSNumber *callingCode;

/** Country code (ISO-3166-1).
 */
@property (nonatomic, strong, readonly) NSString *code;

- (BSCountry *)initCountryNamed:(NSString *)cName
				withCountryCode:(NSString *)cCountryCode
				 andCallingCode:(NSNumber *)cCallingCode;

@end
