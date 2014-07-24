//
//  BSUserTypeModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSUserType : BSGeneralModel

/** User type ID.
 */
@property (nonatomic, strong, readonly) NSString *userTypeID;

/** User type title.
 */
@property (nonatomic, strong, readonly) NSString *name;

/** Init User type with ID
 
 @param uID - User type ID
 
 @return Returns UserType object
 */
- (BSUserType *)initUserTypeWithID:(NSString *)uID;

/** Init User type with ID and name
 
 @param uID - User type ID
 @param uName - User type name
 
 @return Returns UserType object
 */
- (BSUserType *)initUserTypeWithID:(NSString *)uID
							  name:(NSString *)uName;

@end
