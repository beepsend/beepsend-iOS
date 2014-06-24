//
//  BSVerifiedModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSVerifiedModel : BSGeneralModel

@property (nonatomic, assign, readonly, getter = isEmailVerified) BOOL emailVerified;
@property (nonatomic, assign, readonly, getter = isPhoneVerified) BOOL phoneVerified;
@property (nonatomic, assign, readonly, getter = isTermsVerified) BOOL termsVerified;

- (BSVerifiedModel *)initUserWithTermsVerified:(BOOL)termsVerified;
- (BSVerifiedModel *)initUserWithEmailVerified:(BOOL)emailVerified
								 phoneVerified:(BOOL)phoneVerified
								 termsVerified:(BOOL)termsVerified;

@end
