//
//  BSVerifiedModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSVerified : BSGeneralModel

/** If the users email address is verified or not.
 */
@property (nonatomic, strong, readonly) NSNumber *emailVerified;

/** If the users phone number has been verified.
 */
@property (nonatomic, strong, readonly) NSNumber *phoneVerified;

/** True if the user has agreed to the terms & conditions.
 */
@property (nonatomic, strong) NSNumber *termsVerified;

/** Read only property of type BOOL
	If the users phone number has been verified.
 */
@property (nonatomic, assign, readonly, getter = isVerifiedPhone) BOOL verifiedPhone;

/** Read only property of type BOOL
	If the users email address is verified or not.
 */
@property (nonatomic, assign, readonly, getter = isVerifiedEmail) BOOL verifiedEmail;

/** Read only property of type BOOL
	True if the user has agreed to the terms & conditions.
 */
@property (nonatomic, assign, readonly, getter = isVerifiedTerms) BOOL verifiedTerms;

/** Init Verified with Terms verified
 
 @param termsVerified - Is terms verified
 
 @return Returns Verified object
 */
- (BSVerified *)initUserWithTermsVerified:(NSNumber *)termsVerified;

/** Init Verified with Terms verified
 
 @param emailVerified - Is email verified
 @param phoneVerified - Is phone verified
 @param termsVerified - Is terms verified
 
 @return Returns Verified object
 */
- (BSVerified *)initUserWithEmailVerified:(NSNumber *)emailVerified
							phoneVerified:(NSNumber *)phoneVerified
							termsVerified:(NSNumber *)termsVerified;

@end
