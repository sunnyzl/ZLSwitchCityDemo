//
//  ZLCity.m
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/17.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLCity.h"
#import "MJExtension.h"
#import "ZLRegion.h"

@implementation ZLCity

- (NSDictionary *)objectClassInArray
{
    return @{@"regions" : [ZLRegion class]};
}

@end
