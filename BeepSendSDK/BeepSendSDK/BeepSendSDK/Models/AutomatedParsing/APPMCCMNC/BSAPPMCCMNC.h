//
//  BSAPPMCCMNC.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPPMCCMNC : BSSerializableObject

@property (nonatomic, strong) NSNumber *mcc;
@property (nonatomic, strong) NSNumber *mnc;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
