//
//  BSUserTypeModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSUserTypeModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *name;

- (BSUserTypeModel *)initUserTypeWithID:(NSString *)uID
								   name:(NSString *)uName;

@end
