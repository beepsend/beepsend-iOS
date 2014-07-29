//
//  BSHLRModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSDLRReport;
@class BSMCCMNC;
@class BSTimestamps;

/*!
 @class BSHLR
 @discussion HLR is received when performing HLR request with appropriate connection
 */
@interface BSHLR : BSGeneralModel

/*! HLR ID.
 */
@property (nonatomic, strong, readonly) NSString *hlrID;

/*! Timestamps.
 */
@property (nonatomic, strong, readonly) BSTimestamps *timestamps;

/*! DLR.
 */
@property (nonatomic, strong, readonly) BSDLRReport *dlrReport;

/*! Mobile Country Code and Mobile Network Code for the handset.
 */
@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;

/*! The IMSI of the handset if available. First five characters and then zeroes.
 */
@property (nonatomic, strong, readonly) NSString *imsi;

/*! true if the number seems to be ported, false if not.
 */
@property (nonatomic, strong, readonly) NSNumber *ported;

/*! true if the number is roaming, false if not.
 */
@property (nonatomic, strong, readonly) NSNumber *roaming;

/*! Mobile Country Code and Mobile Network Code assigned to msisdn prefix.
 */
@property (nonatomic, strong, readonly) BSMCCMNC *prefix;

/*! Phone number is received when performing HLR validation.
 */
@property (nonatomic, strong, readonly) NSString *phoneNumber;

/*! Errors.
 */
@property (nonatomic, strong, readonly) NSArray *errors;

/*! Create HLR object
 
 @param hlrID - HLR ID
 @param hlrTimestamp - Timestamps
 @param hlrDlrReport - DLR
 @param hlrMccMnc - Mobile Country Code and Mobile Network Code for the handset
 @param hlrImsi - The IMSI of the handset if available
 @param hlrPrefix - Mobile Country Code and Mobile Network Code assigned to msisdn prefix
 @param isPorted - true if the number seems to be ported, false if not
 @param isInRoaming - true if the number is roaming, false if not
 @param errors - Errors
 
 @return Returns HLR object
 */
- (BSHLR *)initHLRWithID:(NSString *)hlrID
			   timestamp:(BSTimestamps *)hlrTimestamp
			   dlrReport:(BSDLRReport *)hlrDlrReport
				  mccmnc:(BSMCCMNC *)hlrMccMnc
					imsi:(NSString *)hlrImsi
				  prefix:(BSMCCMNC *)hlrPrefix
				  potred:(NSNumber *)isPorted
			   inRoaming:(NSNumber *)isInRoaming
			  withErrors:(NSArray *)errors;

/*! Create HLR object 
 Used when HLR request return errors or when performing HLR validation
 
 @param phoneNumber - Phone number
 @param errors - Errors
 
 @return Returns HLR object
 */
- (BSHLR *)initHLRWithNumber:(NSString *)phoneNumber
				   andErrors:(NSArray *)errors;

@end
