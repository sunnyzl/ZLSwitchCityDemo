//
//  ZLSwitchCitySearchResultView.h
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/22.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZLDidSelectedCityHandler)(void);

@interface ZLSwitchCitySearchResultView : UIView

@property (nonatomic, copy) NSString *searchText;

- (void)setupDidSelectedCityHandler:(ZLDidSelectedCityHandler)handler;

@end
