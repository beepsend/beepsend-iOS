//
//  BSAPDLRReport.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPDLRReport : BSSerializableObject

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *error;

@end
