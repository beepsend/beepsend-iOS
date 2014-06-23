//
//  APPricelist.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPPNetwork.h"

@interface BSAPPricelist : BSSerializableObject

@property (nonatomic, strong) NSArray *networks;
@property (nonatomic, strong) NSNumber *networks_count;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSNumber *active;
@property (nonatomic, strong) NSString *first_viewed;

@end
