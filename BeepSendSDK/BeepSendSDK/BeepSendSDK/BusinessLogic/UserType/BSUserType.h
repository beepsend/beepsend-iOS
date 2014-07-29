//
//  BSUserTypeModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSUserType
 @discussion User type presents type that applies to user
 */
@interface BSUserType : BSGeneralModel

/*! User type ID.
 */
@property (nonatomic, strong, readonly) NSString *userTypeID;

/*! User type title.
 */
@property (nonatomic, strong, readonly) NSString *name;

/*! Create User type object
 Used for initializing user type object when only user type id is known
 
 @param uID - User type ID
 
 @return Returns UserType object
 */
- (BSUserType *)initUserTypeWithID:(NSString *)uID;

/*! Create User type object
 Used for initializing user type object with object received from server
 
 @param uID - User type ID
 @param uName - User type title
 
 @return Returns UserType object
 */
- (BSUserType *)initUserTypeWithID:(NSString *)uID
							  name:(NSString *)uName;

@end
