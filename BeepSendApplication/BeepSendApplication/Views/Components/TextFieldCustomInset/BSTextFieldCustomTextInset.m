//
//  BSTextFieldCustomTextInset.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 6/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSTextFieldCustomTextInset.h"

@implementation BSTextFieldCustomTextInset

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Overridden methods

- (CGRect)textRectForBounds:(CGRect)bounds
{
	return CGRectInset(bounds, 10, 5);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
	return CGRectInset(bounds, 10, 5);
}

@end
