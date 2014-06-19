//
//  BSUserModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSUserModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *userName;
@property (nonatomic, strong, readonly) NSString *userEmail;

- (BSUserModel *)initUserWithID:(NSString *)uID
						   name:(NSString *)uName
						  email:(NSString *)uEmail;

@end
