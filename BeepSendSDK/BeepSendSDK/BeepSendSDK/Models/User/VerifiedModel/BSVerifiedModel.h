//
//  BSVerifiedModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSVerifiedModel : BSGeneralModel

@property (nonatomic, assign, readonly) NSNumber *emailVerified;
@property (nonatomic, assign, readonly) NSNumber *phoneVerified;
@property (nonatomic, assign, readonly) NSNumber *termsVerified;

- (BSVerifiedModel *)initUserWithTermsVerified:(NSNumber *)termsVerified;
- (BSVerifiedModel *)initUserWithEmailVerified:(NSNumber *)emailVerified
								 phoneVerified:(NSNumber *)phoneVerified
								 termsVerified:(NSNumber *)termsVerified;

@end
