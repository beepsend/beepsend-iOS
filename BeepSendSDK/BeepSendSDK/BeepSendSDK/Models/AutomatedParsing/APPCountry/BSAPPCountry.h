//
//  APPCountry.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPPCountry : BSSerializableObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *code;

@end
