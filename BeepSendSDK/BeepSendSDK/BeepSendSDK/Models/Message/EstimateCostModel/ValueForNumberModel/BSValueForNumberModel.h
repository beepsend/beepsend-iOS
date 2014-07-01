//
//  BSValueForNumberModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSValueForNumberModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *value;
@property (nonatomic, strong, readonly) NSNumber *cost;

- (BSValueForNumberModel *)initWithValue:(NSString *)value cost:(NSNumber *)cost;

@end
