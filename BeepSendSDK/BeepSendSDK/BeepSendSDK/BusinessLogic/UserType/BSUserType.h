//
//  BSUserTypeModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSUserType : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *userTypeID;
@property (nonatomic, strong, readonly) NSString *name;

- (BSUserType *)initUserTypeWithID:(NSString *)uID;
- (BSUserType *)initUserTypeWithID:(NSString *)uID
							  name:(NSString *)uName;

@end
