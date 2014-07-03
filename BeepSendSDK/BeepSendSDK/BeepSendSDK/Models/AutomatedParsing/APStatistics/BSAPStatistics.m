//
//  BSAPStatistics.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPStatistics.h"

#import "BSStatisticsModel.h"

@implementation BSAPStatistics

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSStatisticsModel alloc] initWithDelivered:_delivered mo:_mo expired:_expired unknown:_unknown rejected:_rejected undelivered:_undelivered noDlr:_no_dlr];
}

@end
