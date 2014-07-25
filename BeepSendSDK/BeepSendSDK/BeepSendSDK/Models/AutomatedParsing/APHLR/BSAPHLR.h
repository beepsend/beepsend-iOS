//
//  BSAPHLR.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPPMCCMNC.h"
#import "BSAPDLRReport.h"
#import "BSAPTimestamps.h"

@interface BSAPHLR : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) BSAPTimestamps *timestamps;
@property (nonatomic, strong) BSAPDLRReport *dlr;
@property (nonatomic, strong) BSAPPMCCMNC *mccmnc;
@property (nonatomic, strong) NSString *imsi;
@property (nonatomic, strong) NSNumber *ported;
@property (nonatomic, strong) NSNumber *roaming;
@property (nonatomic, strong) BSAPPMCCMNC *prefix;
@property (nonatomic, strong) NSString *msisdn;
@property (nonatomic, strong) NSArray *errors;

@end
