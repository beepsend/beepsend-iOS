//
//  BSCountryModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSCountry
 @discussion Country in which network resides in
 */
@interface BSCountry : BSGeneralModel

/*! Name of the country this network resides in.
 */
@property (nonatomic, strong, readonly) NSString *name;

/*! Country calling code.
 */
@property (nonatomic, strong, readonly) NSNumber *callingCode;

/*! Country code (ISO-3166-1).
 */
@property (nonatomic, strong, readonly) NSString *code;

/*! Create Country object
 
 @param cName - Name of the country this network resides in
 @param cCountryCode - Country code (ISO-3166-1)
 @param cCallingCode - Country calling code
 
 @return Returns Country object
 */
- (BSCountry *)initCountryNamed:(NSString *)cName
				withCountryCode:(NSString *)cCountryCode
				 andCallingCode:(NSNumber *)cCallingCode;

@end
