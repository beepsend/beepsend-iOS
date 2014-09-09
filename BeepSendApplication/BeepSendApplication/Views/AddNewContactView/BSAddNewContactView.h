//
//  BSAddNewContactView.h
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSTextFieldCustomTextInset.h"

@interface BSAddNewContactView : UIView

@property (nonatomic, strong) UIScrollView *scrollViewContainer;

@property (nonatomic, strong) BSTextFieldCustomTextInset *textFieldFirstName;
@property (nonatomic, strong) BSTextFieldCustomTextInset *textFieldLastName;
@property (nonatomic, strong) BSTextFieldCustomTextInset *textFieldPhoneNumber;
@property (nonatomic, strong) UIButton *buttonAddToGroup;

@property (nonatomic, strong) UIButton *buttonCancel;
@property (nonatomic, strong) UIButton *buttonAdd;

@property (nonatomic, weak) UIButton *buttonDone;

@end
