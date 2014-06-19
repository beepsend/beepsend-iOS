//
//  BSCallbacksModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSCallbacksModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *callbackDLR;
@property (nonatomic, strong, readonly) NSString *callbackMO;
@property (nonatomic, strong, readonly) NSString *callbackMethod;

- (BSCallbacksModel *)initCallbackWithMethod:(NSString *)cMethod
										 dlr:(NSString *)cDlr
										  mo:(NSString *)cMo;

@end
