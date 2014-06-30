//
//  BSAccountManagerModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSAccountManagerModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *accountManagerName;
@property (nonatomic, strong, readonly) NSString *accountManagerEmail;

- (BSAccountManagerModel *)initAccountManagerWithName:(NSString *)amName
											 andEmail:(NSString *)amEmail;

@end
