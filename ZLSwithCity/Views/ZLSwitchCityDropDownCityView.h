//
//  ZLSwitchCityDropDownCityView.h
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/17.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZLDidClickChangeCityHandler)(UIButton *button);

@interface ZLSwitchCityDropDownCityView : UIView

@property (nonatomic, strong) NSArray *regions;

+ (instancetype)dropDownCityView;

- (void)setupDidChangeCityHandler:(ZLDidClickChangeCityHandler)handler;

@end
