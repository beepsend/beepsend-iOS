//
//  TRZSerialazibleObject.h
//  Tripzzy
//
//  Created by Nikola Mitic on 6/17/14.
//  Copyright (c) 2014 HTEC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTSerializableObject : NSObject

/**
 * Method that should be called for converting. Override this method if you want to change
 * whole logic that does the pasing. It returns dictionary containing property values from
 * class called upon on.
 *
 **/
-(NSDictionary *)dictionaryFromClass;


/**
 * Method that does actual conversion. You should override this method if you want custom
 * custom parsing for subclasses.
 *
 **/
- (id)dictFromClass;

/**
 * Class method that creates a class, or array of classes, from the given dictionary,
 * or array of dictionaries.
 *
 **/
+ (id)classFromDict:(NSDictionary *)dictionary;

@end
