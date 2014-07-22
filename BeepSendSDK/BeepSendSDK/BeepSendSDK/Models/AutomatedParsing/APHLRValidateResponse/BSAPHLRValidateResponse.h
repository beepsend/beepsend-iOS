//
//  BSAPHLRValidateResponse.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPHLRValidateResponse : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *msisdn;
@property (nonatomic, strong) NSArray *errors;

@end
