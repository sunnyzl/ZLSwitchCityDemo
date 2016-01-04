//
//  ZLSwitchCityDropDownMenu.h
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/16.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZLSwitchCityDropDownMenuArrowPosition) {
    ZLSwitchCityDropDownMenuArrowPositionCenter,
    ZLSwitchCityDropDownMenuArrowPositionLeft,
    ZLSwitchCityDropDownMenuArrowPositionRight
};

typedef void(^ZLSwitchCityDropDownMenuShowMenuHandler)(void);

@class ZLSwitchCityDropDownMenu;

typedef void(^ZLSwitchCityDropDownMenuDismissMenuHandler)(ZLSwitchCityDropDownMenu *dropDownMenu);

@interface ZLSwitchCityDropDownMenu : UIView
/**
 *  下拉菜单内容的控制器
 */
@property (strong, nonatomic) UIViewController *contentController;
/**
 *  下拉菜单的内容
 */
@property (strong, nonatomic) UIView *content;
/**
 *  设置下拉菜单箭头对应处
 */
@property (nonatomic, assign) ZLSwitchCityDropDownMenuArrowPosition arrowPosition;

+ (instancetype)menu;

/**
 *  显示下拉菜单
 */
- (void)showFrom:(UIView *)from didShow:(ZLSwitchCityDropDownMenuShowMenuHandler)showMenuHandler;

/**
 *  销毁下拉菜单
 */
- (void)dismiss;

- (void)dismissWithDismissMenuHandler:(ZLSwitchCityDropDownMenuDismissMenuHandler)dismissHandler;

- (void)setupDismissMenuHandler:(ZLSwitchCityDropDownMenuDismissMenuHandler)dismissHandler;


@end
