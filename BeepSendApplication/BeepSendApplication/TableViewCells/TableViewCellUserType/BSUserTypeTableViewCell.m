//
//  BSUserTypeTableViewCell.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUserTypeTableViewCell.h"

@implementation BSUserTypeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.textLabel.textAlignment = NSTextAlignmentJustified|NSTextAlignmentCenter;
		self.textLabel.textColor = [UIColor blackColor];
		self.textLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize/2.0];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
