//
//  BSAPContactsRequests.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPContactsRequests : BSSerializableObject

@property (nonatomic, strong) NSString *group;
@property (nonatomic, strong) NSString *since_id;
@property (nonatomic, strong) NSString *max_id;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *offset;
@property (nonatomic, strong) NSString *sort;

@end
