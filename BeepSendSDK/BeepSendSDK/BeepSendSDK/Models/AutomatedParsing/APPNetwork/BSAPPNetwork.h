//
//  APPNetwork.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPPMCCMNC.h"
#import "BSAPPCountry.h"

@interface BSAPPNetwork : BSSerializableObject

@property (nonatomic, strong) NSArray *mccmnc;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) BSAPPCountry *country;
@property (nonatomic, strong) NSString *operator;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
