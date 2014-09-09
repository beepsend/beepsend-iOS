//
//  BSContactsView.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSContactsView.h"

@implementation BSContactsView

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
		//Back button
		_buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, kViewDefaultBorderInset, frame.size.width/2.0 - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_buttonBack.backgroundColor = [UIColor lightGrayColor];
		_buttonBack.showsTouchWhenHighlighted = YES;
		_buttonBack.clipsToBounds = YES;
		_buttonBack.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_buttonBack.titleLabel.textAlignment = NSTextAlignmentCenter;
		[_buttonBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonBack setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		
		_buttonBack.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		_buttonBack.layer.borderWidth = kDefaultBorderWidth;
		_buttonBack.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[self addSubview:_buttonBack];
		
		////////////////////////////////////////////////////////////////////////
		//Add button
		_buttonAddContact = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2.0 + kViewDefaultBorderInset, kViewDefaultBorderInset, frame.size.width/2.0 - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_buttonAddContact.backgroundColor = [UIColor lightGrayColor];
		_buttonAddContact.showsTouchWhenHighlighted = YES;
		_buttonAddContact.clipsToBounds = YES;
		_buttonAddContact.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_buttonAddContact.titleLabel.textAlignment = NSTextAlignmentCenter;
		[_buttonAddContact setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonAddContact setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		
		_buttonAddContact.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		_buttonAddContact.layer.borderWidth = kDefaultBorderWidth;
		_buttonAddContact.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[self addSubview:_buttonAddContact];
		
		////////////////////////////////////////////////////////////////////////
		//User types table view
		_tableViewContacts = [[UITableView alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_buttonBack.frame) + kSeparatorDefaultSpacing, frame.size.width - 2*kViewDefaultBorderInset, frame.size.height - CGRectGetHeight(_buttonAddContact.frame) - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing)];
		[_tableViewContacts setBackgroundColor:[UIColor whiteColor]];
		[_tableViewContacts setSeparatorColor:[UIColor darkGrayColor]];
		[_tableViewContacts setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[_tableViewContacts setRowHeight:kTextFieldDefaultHeight];
		[_tableViewContacts setShowsHorizontalScrollIndicator:NO];
		[_tableViewContacts setShowsVerticalScrollIndicator:YES];
		
		_tableViewContacts.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		_tableViewContacts.layer.borderWidth = kDefaultBorderWidth;
		_tableViewContacts.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[self addSubview:_tableViewContacts];
    }
    return self;
}

@end
