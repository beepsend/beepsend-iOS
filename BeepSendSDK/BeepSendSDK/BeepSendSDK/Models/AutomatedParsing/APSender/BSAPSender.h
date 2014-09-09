//
//  BSAPSender.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPContact.h"

@interface BSAPSender : BSSerializableObject

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) BSAPContact *contact;

@end
