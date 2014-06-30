//
//  BSAPVerified.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPVerified : BSSerializableObject

@property (nonatomic, strong) NSNumber *email;
@property (nonatomic, strong) NSNumber *phone;
@property (nonatomic, strong) NSNumber *terms;

@end
