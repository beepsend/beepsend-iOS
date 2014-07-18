//
//  BSSendMessageView.h
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSTextFieldCustomTextInset.h"

@interface BSSendMessageView : UIView

@property (nonatomic, strong) UIScrollView *scrollViewContainer;

@property (nonatomic, strong) BSTextFieldCustomTextInset *textFieldFrom;
@property (nonatomic, strong) BSTextFieldCustomTextInset *textFieldTo;
@property (nonatomic, strong) UITextView *textViewMessageBox;
@property (nonatomic, strong) UIButton *buttonCheckDestinationNumber;

@property (nonatomic, weak) UIButton *buttonDone;

@property (nonatomic, strong) UIButton *buttonBack;
@property (nonatomic, strong) UISegmentedControl *segmentedControlMessageType;

@end
