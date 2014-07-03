//
//  BSAPNetworkDetailsRequest.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPNetworkDetailsRequest : BSSerializableObject

@property (nonatomic, strong) NSString *from_date;
@property (nonatomic, strong) NSString *to_date;
@property (nonatomic, strong) NSNumber *MCC;
@property (nonatomic, strong) NSNumber *MNC;

@end
