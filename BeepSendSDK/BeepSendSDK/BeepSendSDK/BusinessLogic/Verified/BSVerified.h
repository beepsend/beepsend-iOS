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

@property (nonatomic, assign, readonly, getter = isVerifiedPhone) BOOL verifiedPhone;
@property (nonatomic, assign, readonly, getter = isVerifiedEmail) BOOL verifiedEmail;
@property (nonatomic, assign, readonly, getter = isVerifiedTerms) BOOL verifiedTerms;

- (BSVerified *)initUserWithTermsVerified:(NSNumber *)termsVerified;
- (BSVerified *)initUserWithEmailVerified:(NSNumber *)emailVerified
							phoneVerified:(NSNumber *)phoneVerified
							termsVerified:(NSNumber *)termsVerified;

@end
