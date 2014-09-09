//
//  BSCallbacksModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSCallbacks
 @discussion Callback contain delivery report URL, mobile originated SMS URL and method
 */
@interface BSCallbacks : BSGeneralModel

/*! The callback URL that will be used for your Delivery reports.
 */
@property (nonatomic, strong) NSString *DLR;

/*! The callback URL that will be used for your Mobile Originated SMS.
 */
@property (nonatomic, strong) NSString *MO;

/*! What HTTP method that will be used for your callbacks. GET, POST or PUT.
 */
@property (nonatomic, strong) NSString *method;

/*! Create Callbacks Object
 
 @param cMethod - What HTTP method that will be used for your callbacks. GET, POST or PUT
 @param cDlr - The callback URL that will be used for your Delivery reports
 @param cMo - The callback URL that will be used for your Mobile Originated SMS
 
 @return Returns Callbacks object
 */
- (BSCallbacks *)initCallbackWithMethod:(NSString *)cMethod
									dlr:(NSString *)cDlr
									 mo:(NSString *)cMo;

@end
