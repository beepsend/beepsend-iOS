//
//  BSAPNumber.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPConnection.h"
#import "BSAPPCountry.h"

@interface BSAPNumber : BSSerializableObject

@property (nonatomic, strong) BSAPConnection *connection;
@property (nonatomic, strong) BSAPPCountry *country;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSNumber *number;

@end
