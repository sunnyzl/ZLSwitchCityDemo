//
//  ZLSwitchCitySearchResultView.m
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/22.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLSwitchCitySearchResultView.h"
#import "ZLCity.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "ZLCommonConst.h"


@interface ZLSwitchCitySearchResultView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *results;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy) ZLDidSelectedCityHandler handler;

@end

@implementation ZLSwitchCitySearchResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return self;
}

- (void)setupDidSelectedCityHandler:(ZLDidSelectedCityHandler)handler
{
    self.handler = [handler copy];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText copy];
    searchText = searchText.lowercaseString;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@", searchText, searchText, searchText];
    self.results = [[ZLCity objectArrayWithFilename:ZLSwitchCitySourceName(@"plists/cities.plist")] filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *cellID = @"searchResult";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    ZLCity *city = self.results[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZLCity *city = self.results[indexPath.row];
    // 发出通知
    [NS_NOTIFICATION_CENTER postNotificationName:ZLCityDidChangeNotification object:nil userInfo:@{ZLSelectCityName : city.name}];
    if (self.handler) {
        self.handler();
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%ld个搜索结果", self.results.count];
}

@end
