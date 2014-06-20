//
//  BSCallbacksModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSCallbacksModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *DLR;
@property (nonatomic, strong, readonly) NSString *MO;
@property (nonatomic, strong, readonly) NSString *method;

- (BSCallbacksModel *)initCallbackWithMethod:(NSString *)cMethod
										 dlr:(NSString *)cDlr
										  mo:(NSString *)cMo;

@end
