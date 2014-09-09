//
//  BSAPTimestamps.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPHLRReport.h"

@interface BSAPTimestamps : BSSerializableObject

@property (nonatomic, strong) NSString *dlr_out;
@property (nonatomic, strong) BSAPHLRReport *hlr;
@property (nonatomic, strong) BSAPHLRReport *sms;

@end
