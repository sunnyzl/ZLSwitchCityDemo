//
//  ViewController.m
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/16.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ViewController.h"
#import "ZLSwitchCityDropDownMenu.h"
#import "UIView+ZLFrame.h"
#import "ZLSwitchCityDropDownCityView.h"
#import "ZLSwitchCitySearchView.h"
#import "Masonry.h"
#import "ZLCommonConst.h"
#import "ZLCity.h"
#import "MJExtension.h"
#import "ZLRegion.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *selectedCityName;

@property (nonatomic, copy) NSString *selectedRegionName;

@property (nonatomic, weak) ZLSwitchCityDropDownMenu *menu;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UILabel *regionLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NS_NOTIFICATION_CENTER addObserver:self selector:@selector(cityDidChanged:) name:ZLCityDidChangeNotification object:nil];
    [NS_NOTIFICATION_CENTER addObserver:self selector:@selector(regionDidChanged:) name:ZLRegionDidChangeNotification object:nil];
}

- (void)dealloc
{
    [NS_NOTIFICATION_CENTER removeObserver:self];
}

- (void)cityDidChanged:(NSNotification *)notification
{
    self.selectedCityName = notification.userInfo[ZLSelectCityName];
    self.cityLabel.text = [NSString stringWithFormat:@"城市：%@ - 全部", self.selectedCityName];
    self.regionLabel.text = [NSString stringWithFormat:@"区域：全部"];
}

- (void)regionDidChanged:(NSNotification *)notification
{
    ZLRegion *region = notification.userInfo[ZLSelectRegion];
    NSString *subregionName = notification.userInfo[ZLSelectSubregionName];
    
    if (subregionName == nil || [subregionName isEqualToString:@"全部"]) {
        self.selectedRegionName = region.name;
        self.regionLabel.text = [NSString stringWithFormat:@"区域：全部"];
    } else {
        self.selectedRegionName = subregionName;
        self.regionLabel.text = [NSString stringWithFormat:@"区域：%@", subregionName];
    }
    
    if ([self.selectedRegionName isEqualToString:@"全部"]) {
        self.selectedRegionName = nil;
    }
    self.cityLabel.text = [NSString stringWithFormat:@"城市：%@ - %@", self.selectedCityName, region.name];
    
    [self.menu dismiss];
}

- (IBAction)buttonDidClick:(UIButton *)sender {
    ZLSwitchCityDropDownMenu *menu = [ZLSwitchCityDropDownMenu menu];
    ZLSwitchCityDropDownCityView *cityView = [ZLSwitchCityDropDownCityView dropDownCityView];
    menu.arrowPosition = ZLSwitchCityDropDownMenuArrowPositionRight;
    //  若需要修改弹出框大小，请按下面两行代码操作
    cityView.zl_rectWidth = 200;
    cityView.zl_rectHeight = 200;
    ZLCity *city = [[[ZLCity objectArrayWithFilename:ZLSwitchCitySourceName(@"plists/cities.plist")] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@", self.selectedCityName]] firstObject];
    cityView.regions = city.regions;
    menu.content = cityView;
    [menu showFrom:sender didShow:nil];
    [cityView setupDidChangeCityHandler:^(UIButton *button) {
        [menu dismiss];
        [[ZLSwitchCitySearchView searchView] show];
    }];
    self.menu = menu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
