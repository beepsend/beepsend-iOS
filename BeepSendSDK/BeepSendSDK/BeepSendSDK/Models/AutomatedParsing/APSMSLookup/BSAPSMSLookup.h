//
//  BSAPSMSLookup.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPBatch.h"
#import "BSAPConnection.h"
#import "BSAPDLRReport.h"
#import "BSAPRecipient.h"
#import "BSAPPMCCMNC.h"
#import "BSAPTimestamps.h"

@interface BSAPSMSLookup : BSSerializableObject

@property (nonatomic, strong) BSAPBatch *batch;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) BSAPConnection *connection;
@property (nonatomic, strong) NSNumber *data_coding;
@property (nonatomic, strong) BSAPDLRReport *dlr;
@property (nonatomic, strong) BSAPRecipient *from;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) BSAPPMCCMNC *mccmnc;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) BSAPTimestamps *timestamps;
@property (nonatomic, strong) BSAPRecipient *to;
@property (nonatomic, strong) NSString *validity_period;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
