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

@interface BSHLR : BSGeneralModel

/** Timestamps
 */
@property (nonatomic, strong, readonly) BSTimestamps *timestamps;

/** DLR
 */
@property (nonatomic, strong, readonly) BSDLRReport *dlrReport;

/** Mobile Country Code for the handset.
	Mobile Network Code for the handset.
 */
@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;

/** The IMSI of the handset if available. First five characters and then zeroes.
 */
@property (nonatomic, strong, readonly) NSString *imsi;

/** true if the number seems to be ported, false if not.
 */
@property (nonatomic, strong, readonly) NSNumber *ported;

/** true if the number is roaming, false if not.
 */
@property (nonatomic, strong, readonly) NSNumber *roaming;

/** Mobile Country Code assigned to msisdn prefix.
	Mobile Network Code assigned to msisdn prefix.
 */
@property (nonatomic, strong, readonly) BSMCCMNC *prefix;

/** Response for HLR validation
 */
@property (nonatomic, strong, readonly) NSString *phoneNumber;
@property (nonatomic, strong, readonly) NSArray *errors;

/** Init HLR with ID, timestamp, dlr, mccmnc, imsi, prefix, ported, roaming, errors
 
 @param hlrID - HLR ID
 @param hlrTimestamp - Timestamp
 @param hlrDlrReport - DLR
 @param hlrMccMnc - MCCMNC
 @param hlrImsi - IMSI
 @param hlrPrefix - HLR Prefix
 @param isPorted - Ported
 @param isInRoaming - Roaming
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

/** Init HLR with phone number, errors
 
 @param phoneNumber - Phone number
 @param errors - Errors
 
 @return Returns HLR object
 */
- (BSHLR *)initHLRWithNumber:(NSString *)phoneNumber andErrors:(NSArray *)errors;

@end
