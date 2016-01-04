//
//  ZLCity.h
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/17.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLCity : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *pinYin;

@property (nonatomic, copy) NSString *pinYinHead;

@property (nonatomic, strong) NSArray *regions;

@end
