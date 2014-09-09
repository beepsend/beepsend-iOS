//
//  BSStructs.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#ifndef BeepSendSDK_BSStructs_h
#define BeepSendSDK_BSStructs_h

/*!
 @typedef BSConnectionType
 @abstract Connection type can be SMS and HLR.
 @constant BSConnectionTypeSMS Tells that connection can send SMS messages.
 @constant BSConnectionTypeHLR Tells that connection can perform HLR requests.
 */
typedef enum {
	BSConnectionTypeSMS = 1,
	BSConnectionTypeHLR = 2
} BSConnectionType;

#endif
