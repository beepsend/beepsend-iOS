//
//  BSAPTwoWayBatch.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPTwoWayBatch : BSSerializableObject

@property (nonatomic, strong) NSString *mt_sms_id;
@property (nonatomic, strong) NSString *mt_body;
@property (nonatomic, strong) NSString *mo_sms_id;
@property (nonatomic, strong) NSString *mo_body;
@property (nonatomic, strong) NSString *dlr_stst;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
