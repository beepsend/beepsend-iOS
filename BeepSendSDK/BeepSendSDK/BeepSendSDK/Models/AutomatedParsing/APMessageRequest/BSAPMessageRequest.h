//
//  BSAPMessageRequest.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@class BSMessage;

@interface BSAPMessageRequest : BSSerializableObject

@property (nonatomic, strong) id to;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *batch_id;
@property (nonatomic, strong) NSString *batch_label;
@property (nonatomic, strong) NSString *send_time;
@property (nonatomic, strong) NSString *encoding;
@property (nonatomic, strong) NSString *message_type;
@property (nonatomic, strong) NSString *validity_period;
@property (nonatomic, strong) NSNumber *receive_dlr;
@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong) NSString *udh;
@property (nonatomic, strong) NSString *dcs;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;
+ (NSArray *)arrayOfObjectsFromArrayOfModels:(NSArray *)array;

+ (BSAPMessageRequest *)convertFromMessageRequestModel:(BSMessage *)msgRequest;

@end
