//
//  APCCallback.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPCCallback : BSSerializableObject

@property (nonatomic, strong) NSString *dlr;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *mo;

@end
