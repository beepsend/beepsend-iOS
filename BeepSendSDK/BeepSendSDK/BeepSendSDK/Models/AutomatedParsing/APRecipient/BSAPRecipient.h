//
//  BSAPRecipient.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPRecipient : BSSerializableObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *npi;
@property (nonatomic, strong) NSNumber *ton;

@end
