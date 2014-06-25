//
//  BSAPHLRReport.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPHLRReport : BSSerializableObject

@property (nonatomic, strong) NSString *delivered;
@property (nonatomic, strong) NSString *in;

@end
