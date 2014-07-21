//
//  BSAccountManagerModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSAccountManager : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *email;

- (BSAccountManager *)initAccountManagerWithName:(NSString *)amName
										andEmail:(NSString *)amEmail;

@end
