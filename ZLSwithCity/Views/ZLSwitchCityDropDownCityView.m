//
//  ZLSwitchCityDropDownCityView.m
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/17.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLSwitchCityDropDownCityView.h"
#import "ZLSwitchCitySearchView.h"
#import "ZLCommonConst.h"
#import "ZLCity.h"
#import "MJExtension.h"
#import "ZLRegion.h"
#import "ZLSwitchCityDropDownCityMainCell.h"
#import "ZLSwitchCityDropDownCitySubCell.h"

@interface ZLSwitchCityDropDownCityView () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (weak, nonatomic) IBOutlet UITableView *subTableView;

@property (nonatomic, assign) NSInteger selectedMainRow;

@property (nonatomic, copy) ZLDidClickChangeCityHandler handler;
@property (weak, nonatomic) IBOutlet UIButton *changeCityButton;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrayImageView;

@end

@implementation ZLSwitchCityDropDownCityView

+ (instancetype)dropDownCityView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZLSwitchCityDropDownCityView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [_changeCityButton setImage:[UIImage imageNamed:ZLSwitchCitySourceName(@"btn_changeCity")] forState:UIControlStateNormal];
    [_changeCityButton setImage:[UIImage imageNamed:ZLSwitchCitySourceName(@"btn_changeCity_selected")] forState:UIControlStateHighlighted];
    _rightArrayImageView.image = [UIImage imageNamed:ZLSwitchCitySourceName(@"icon_cell_rightArrow")];
}

- (IBAction)changeCity:(UIButton *)button
{
    if (self.handler) {
        self.handler(button);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return self.regions.count;
    } else {
        ZLRegion *region = self.regions[self.selectedMainRow];
        return region.subregions.count;
    }
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) {
        cell = [ZLSwitchCityDropDownCityMainCell cellWithTableView:tableView];
        ZLRegion *region = self.regions[indexPath.row];
        cell.textLabel.text = region.name;
        if (region.subregions.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell = [ZLSwitchCityDropDownCitySubCell cellWithTableView:tableView];
        ZLRegion *region = self.regions[self.selectedMainRow];
        cell.textLabel.text = region.subregions[indexPath.row];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        ZLRegion *region = self.regions[indexPath.row];
        if (indexPath.row == 0) {
            [NS_NOTIFICATION_CENTER postNotificationName:ZLRegionDidChangeNotification object:nil userInfo:@{ZLSelectRegion : region}];
        }
        // 被点击的数据
        self.selectedMainRow = indexPath.row;
        // 刷新右边的数据
        [self.subTableView reloadData];
    } else {
        ZLRegion *region = self.regions[self.selectedMainRow];
        [NS_NOTIFICATION_CENTER postNotificationName:ZLRegionDidChangeNotification object:nil userInfo:@{ZLSelectRegion : region, ZLSelectSubregionName : region.subregions[indexPath.row]}];
    }
}

- (void)setupDidChangeCityHandler:(ZLDidClickChangeCityHandler)handler
{
    self.handler = [handler copy];
}

@end
