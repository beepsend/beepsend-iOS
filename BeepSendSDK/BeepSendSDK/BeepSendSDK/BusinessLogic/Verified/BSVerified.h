//
//  BSVerifiedModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSVerified : BSGeneralModel

@property (nonatomic, assign, readonly, getter = isVerifiedPhone) BOOL verifiedPhone;
@property (nonatomic, assign, readonly, getter = isVerifiedPhone) BOOL verifiedEmail;
@property (nonatomic, assign, readonly, getter = isVerifiedPhone) BOOL verifiedTerms;

@property (nonatomic, strong, readonly) NSNumber *emailVerified;
@property (nonatomic, strong, readonly) NSNumber *phoneVerified;
@property (nonatomic, strong) NSNumber *termsVerified;

- (BSVerified *)initUserWithTermsVerified:(NSNumber *)termsVerified;
- (BSVerified *)initUserWithEmailVerified:(NSNumber *)emailVerified
							phoneVerified:(NSNumber *)phoneVerified
							termsVerified:(NSNumber *)termsVerified;

@end
