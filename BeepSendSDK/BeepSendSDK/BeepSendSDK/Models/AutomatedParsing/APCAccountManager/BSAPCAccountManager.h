//
//  BSAPCAccountManager.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/18/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "HTSerializableObject.h"

@interface BSAPCAccountManager : HTSerializableObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;

@end
