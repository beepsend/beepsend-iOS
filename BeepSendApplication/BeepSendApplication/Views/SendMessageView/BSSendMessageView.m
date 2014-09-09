//
//  BSSendMessageView.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSendMessageView.h"

#import <QuartzCore/QuartzCore.h>

#import "BSInputAccessoryView.h"

@implementation BSSendMessageView

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		////////////////////////////////////////////////////////////////////////
		//Main view
		self.backgroundColor = [UIColor clearColor];
		
		UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:frame
														  byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
																cornerRadii:CGSizeMake(kDefaultButtonCornerRadius, kDefaultButtonCornerRadius)];
		CAShapeLayer *maskLayer = [CAShapeLayer layer];
		maskLayer.frame = frame;
		maskLayer.path = [roundedPath CGPath];
		maskLayer.fillColor = [UIColor darkGrayColor].CGColor;
		maskLayer.lineWidth = kDefaultBorderWidth;
		maskLayer.strokeColor = [[UIColor orangeColor] CGColor];
		
		[self.layer addSublayer:maskLayer];
		
		////////////////////////////////////////////////////////////////////////
		//Setup textField input accessory view
		BSInputAccessoryView *accessoryView = [BSInputAccessoryView inputAccessoryViewWithDoneButton];
		_buttonDone = accessoryView.buttonDone;
		
		////////////////////////////////////////////////////////////////////////
		//Scroll view
		_scrollViewContainer = [[UIScrollView alloc] initWithFrame:frame];
		_scrollViewContainer.backgroundColor = [UIColor clearColor];
		_scrollViewContainer.contentSize = frame.size;
		_scrollViewContainer.clipsToBounds = YES;
		
		[self addSubview:_scrollViewContainer];
		
		////////////////////////////////////////////////////////////////////////
		//Text field sender
		_textFieldFrom = [[BSTextFieldCustomTextInset alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, kViewDefaultBorderInset, frame.size.width - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_textFieldFrom.backgroundColor = [UIColor whiteColor];
		_textFieldFrom.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textFieldFrom.textColor = [UIColor blackColor];
		_textFieldFrom.textAlignment = NSTextAlignmentNatural;
		_textFieldFrom.keyboardAppearance = UIKeyboardAppearanceDark;
		_textFieldFrom.keyboardType = UIKeyboardTypeAlphabet;
		_textFieldFrom.returnKeyType = UIReturnKeyNext;
		_textFieldFrom.clearButtonMode = UITextFieldViewModeWhileEditing;
		_textFieldFrom.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
																			   attributes:@{
																							NSForegroundColorAttributeName:[UIColor lightGrayColor],
																							NSFontAttributeName:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultPlaceholderSize]
																							}];
		
		_textFieldFrom.inputAccessoryView = accessoryView;
		
		_textFieldFrom.layer.borderColor = [UIColor orangeColor].CGColor;
		_textFieldFrom.layer.borderWidth = kDefaultBorderWidth;
		_textFieldFrom.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[_scrollViewContainer addSubview:_textFieldFrom];
		
		////////////////////////////////////////////////////////////////////////
		//Text field recipient
		_textFieldTo = [[BSTextFieldCustomTextInset alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_textFieldFrom.frame) + kSeparatorDefaultSpacing, frame.size.width - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_textFieldTo.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textFieldTo.backgroundColor = [UIColor whiteColor];
		_textFieldTo.textColor = [UIColor blackColor];
		_textFieldTo.textAlignment = NSTextAlignmentNatural;
		_textFieldTo.keyboardAppearance = UIKeyboardAppearanceDark;
		_textFieldTo.keyboardType = UIKeyboardTypeNumberPad;
		_textFieldTo.clearButtonMode = UITextFieldViewModeWhileEditing;
		_textFieldTo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
																			 attributes:@{
																						  NSForegroundColorAttributeName:[UIColor lightGrayColor],
																						  NSFontAttributeName:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultPlaceholderSize]
																						  }];
		
		_textFieldTo.inputAccessoryView = accessoryView;
		
		_textFieldTo.layer.borderColor = [UIColor orangeColor].CGColor;
		_textFieldTo.layer.borderWidth = kDefaultBorderWidth;
		_textFieldTo.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[_scrollViewContainer addSubview:_textFieldTo];
		
		////////////////////////////////////////////////////////////////////////
		//Text view message box
		_textViewMessageBox = [[UITextView alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_textFieldTo.frame) + kSeparatorDefaultSpacing, frame.size.width - kViewDefaultBorderInset*2, kTextViewDefaultHeight)];
		_textViewMessageBox.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textViewMessageBox.backgroundColor = [UIColor whiteColor];
		_textViewMessageBox.textColor = [UIColor blackColor];
		_textViewMessageBox.textAlignment = NSTextAlignmentNatural;
		_textViewMessageBox.keyboardAppearance = UIKeyboardAppearanceDark;
		_textViewMessageBox.keyboardType = UIKeyboardTypeAlphabet;
		_textViewMessageBox.contentInset = UIEdgeInsetsMake(5.0, 5.0, -5.0, -5.0);
		_textViewMessageBox.directionalLockEnabled = YES;
		
		_textViewMessageBox.inputAccessoryView = accessoryView;
		
		_textViewMessageBox.layer.borderColor = [UIColor orangeColor].CGColor;
		_textViewMessageBox.layer.borderWidth = kDefaultBorderWidth;
		_textViewMessageBox.layer.cornerRadius = _textFieldTo.layer.cornerRadius;
		
		[_scrollViewContainer addSubview:_textViewMessageBox];
		
		////////////////////////////////////////////////////////////////////////
		
		_buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, frame.size.height - kViewDefaultBorderInset - kTextFieldDefaultHeight, frame.size.width - 2*kViewDefaultBorderInset, kTextFieldDefaultHeight)];
		_buttonBack.backgroundColor = [UIColor lightGrayColor];
		_buttonBack.showsTouchWhenHighlighted = YES;
		_buttonBack.clipsToBounds = YES;
		_buttonBack.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_buttonBack.titleLabel.textAlignment = NSTextAlignmentCenter;
		[_buttonBack setTitle:NSLocalizedString(@"Back", @"") forState:UIControlStateNormal];
		[_buttonBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonBack setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		
		_buttonBack.layer.cornerRadius = _textFieldTo.layer.cornerRadius;
		_buttonBack.layer.borderWidth = kDefaultBorderWidth;
		_buttonBack.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_buttonBack];
		
		////////////////////////////////////////////////////////////////////////
		//Segmented control message type
		_segmentedControlMessageType = [[UISegmentedControl alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_textViewMessageBox.frame) + kSeparatorDefaultSpacing, frame.size.width - 2*kViewDefaultBorderInset, kTextFieldDefaultHeight)];
		[_segmentedControlMessageType setTintColor:[UIColor orangeColor]];
		
		[_scrollViewContainer addSubview:_segmentedControlMessageType];
		
		////////////////////////////////////////////////////////////////////////
		//Validate SMS button
		_buttonValidateSMS = [[UIButton alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_segmentedControlMessageType.frame) + kSeparatorDefaultSpacing, CGRectGetWidth(_textFieldTo.frame), CGRectGetHeight(_textFieldTo.frame))];
		_buttonValidateSMS.backgroundColor = [UIColor lightGrayColor];
		_buttonValidateSMS.showsTouchWhenHighlighted = YES;
		_buttonValidateSMS.clipsToBounds = YES;
		[_buttonValidateSMS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonValidateSMS setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		_buttonValidateSMS.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		
		_buttonValidateSMS.layer.cornerRadius = _textFieldTo.layer.cornerRadius;
		_buttonValidateSMS.layer.borderWidth = kDefaultBorderWidth;
		_buttonValidateSMS.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_buttonValidateSMS];
		
		////////////////////////////////////////////////////////////////////////
		//Send SMS button
		_buttonSendSMS = [[UIButton alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_buttonValidateSMS.frame) + kSeparatorDefaultSpacing, CGRectGetWidth(_textFieldTo.frame), CGRectGetHeight(_textFieldTo.frame))];
		_buttonSendSMS.backgroundColor = [UIColor lightGrayColor];
		_buttonSendSMS.showsTouchWhenHighlighted = YES;
		_buttonSendSMS.clipsToBounds = YES;
		[_buttonSendSMS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonSendSMS setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		_buttonSendSMS.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		
		_buttonSendSMS.layer.cornerRadius = _textFieldTo.layer.cornerRadius;
		_buttonSendSMS.layer.borderWidth = kDefaultBorderWidth;
		_buttonSendSMS.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_buttonSendSMS];
    }
    return self;
}

@end
