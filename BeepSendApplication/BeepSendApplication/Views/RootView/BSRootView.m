//
//  BSRootView.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 6/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSRootView.h"

@implementation BSRootView

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
		//Labels and text fields for name, email and phone
		_labelIntro = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, kViewDefaultBorderInset, frame.size.width - 2*kViewDefaultBorderInset, frame.size.width - 2*kViewDefaultBorderInset)];
		_labelIntro.backgroundColor = [UIColor clearColor];
		_labelIntro.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelIntro.textColor = [UIColor blackColor];
		_labelIntro.textAlignment = NSTextAlignmentCenter;
		_labelIntro.numberOfLines = 0;
		
		[self addSubview:_labelIntro];
		
		////////////////////////////////////////////////////////////////////////
		//Buttons customer and default connection
		_buttonEnter = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/3, CGRectGetMaxY(_labelIntro.frame)+kSeparatorDefaultSpacing, frame.size.width/3, kTextFieldDefaultHeight)];
		
		_buttonEnter.backgroundColor = [UIColor lightGrayColor];
		_buttonEnter.showsTouchWhenHighlighted = YES;
		_buttonEnter.clipsToBounds = YES;
		[_buttonEnter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonEnter setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		_buttonEnter.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize/1.6];
		
		_buttonEnter.layer.cornerRadius = kDefaultButtonCornerRadius;
		_buttonEnter.layer.borderWidth = kDefaultBorderWidth;
		_buttonEnter.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[self addSubview:_buttonEnter];
    }
    return self;
}

@end
