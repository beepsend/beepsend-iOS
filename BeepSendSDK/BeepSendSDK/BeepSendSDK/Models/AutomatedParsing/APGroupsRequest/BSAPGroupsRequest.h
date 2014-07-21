//
//  BSAPGroupsRequest.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/10/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPGroupsRequest : BSSerializableObject

@property (nonatomic, strong) NSString *since_id;
@property (nonatomic, strong) NSString *max_id;
@property (nonatomic, strong) NSNumber *count;

@end
