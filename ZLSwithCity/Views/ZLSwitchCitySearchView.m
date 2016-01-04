//
//  ZLSwitchCitySearchView.m
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/21.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLSwitchCitySearchView.h"
#import "Masonry.h"
#import "UIImage+ZLResizableImage.h"
#import "MJExtension.h"
#import "ZLCityGroups.h"
#import "ZLSwitchCitySearchResultView.h"
#import "ZLCommonConst.h"

static const NSTimeInterval animationDuration = 0.3f;
static const CGFloat alertBgViewScale = 0.7;

@interface ZLSwitchCitySearchView () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, weak) UIView *topNavView;
@property (nonatomic, weak) UIView *alertBgView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton *coverButton;
@property (nonatomic, strong) NSArray *cityGroup;
@property (nonatomic, weak) ZLSwitchCitySearchResultView *searchResult;

@end

@implementation ZLSwitchCitySearchView


+ (instancetype)searchView
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
    }
    return self;
}

- (void)viewConfig
{
    self.cityGroup = [ZLCityGroups objectArrayWithFilename:ZLSwitchCitySourceName(@"plists/cityGroups.plist")];
    
    [self setupAlertBgView];
    [self setupTopView];
    [self setupContentView];
}

- (void)show
{
    [self createBackgroundView];
    [self animationIn];
}

- (void)dismiss
{
    [self animationOut];
}

- (void)createBackgroundView
{
    
    // adding some styles to background view (behind table alert)
    self.frame = [[UIScreen mainScreen] bounds];
    self.opaque = NO;
    // adding it as subview of app's UIWindow
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    
}

- (void)animationIn
{
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.alpha = 1.0;;
        
    }completion:^(BOOL finished) {
    }];
}

- (void)animationOut
{
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.f];
        self.alpha = 0.f;;
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setupAlertBgView
{
    UIView *alertBgView = ({
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self).multipliedBy(alertBgViewScale);
        }];
        view.layer.cornerRadius = 10.f;
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    self.alertBgView = alertBgView;
}

- (void)setupTopView
{
    UIView *topNavView = ({
        UIView *view = [[UIView alloc] init];
        [self.alertBgView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.alertBgView);
            make.height.mas_equalTo(44);
        }];
        view;
    });
    self.topNavView = topNavView;
    
    UIImageView *topBackImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        [topNavView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(topNavView);
        }];
        imageView;
    });
    topBackImageView.image = [UIImage imageNamed:ZLSwitchCitySourceName(@"bg_navigationBar_normal")];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [topNavView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topNavView);
        make.width.height.equalTo(@30);
        make.left.equalTo(@8);
    }];
    [cancelButton setImage:[UIImage imageNamed:ZLSwitchCitySourceName(@"btn_navigation_close")] forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:ZLSwitchCitySourceName(@"btn_navigation_close_hl")] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancelButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [topNavView addSubview:titleLabel];
    titleLabel.text = @"切换城市";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topNavView);
    }];
}

- (void)setupContentView
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [self.alertBgView addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertBgView).offset(15);
        make.right.equalTo(self.alertBgView).offset(-15);
        make.top.equalTo(self.topNavView.mas_bottom).offset(15);
        make.height.equalTo(@35);
    }];
    searchBar.delegate = self;
    searchBar.backgroundImage = [UIImage resizableImageWithImageName:ZLSwitchCitySourceName(@"bg_login_textfield")];
    searchBar.placeholder = @"请输入城市名或拼音";
    searchBar.tintColor = UIColorWithRGBA(32, 191, 179, 1.f);
    self.searchBar = searchBar;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.alertBgView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.alertBgView);
        make.top.equalTo(searchBar.mas_bottom).offset(15);
    }];
    tableView.sectionIndexColor = UIColorWithRGBA(32, 191, 179, 1.f);
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    
    UIButton *coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alertBgView addSubview:coverButton];
    [coverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableView);
    }];
    coverButton.backgroundColor = [UIColor blackColor];
    coverButton.alpha = 0.f;
    [coverButton addTarget:self action:@selector(coverButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.coverButton = coverButton;
    
    ZLSwitchCitySearchResultView *searchResult = [[ZLSwitchCitySearchResultView alloc] init];
    [self.alertBgView addSubview:searchResult];
    [searchResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(coverButton);
    }];
    searchResult.hidden = YES;
    [searchResult setupDidSelectedCityHandler:^{
        [self dismiss];
    }];
    self.searchResult = searchResult;
    
}

- (void)coverButtonDidClick:(UIButton *)button {
    [self.searchBar resignFirstResponder];
}

- (void)cancelButtonDidClick:(UIButton *)button {
    [self dismiss];
}

#pragma mark - searchBar delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [UIView animateWithDuration:animationDuration animations:^{
        [self.topNavView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.alertBgView).offset(-self.topNavView.bounds.size.height);
        }];
        self.coverButton.alpha = 0.5f;
        [self layoutIfNeeded];
    }];
    [searchBar setBackgroundImage:[UIImage resizableImageWithImageName:ZLSwitchCitySourceName(@"bg_login_textfield_hl")]];
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [UIView animateWithDuration:animationDuration animations:^{
        [self.topNavView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.alertBgView);
        }];
        self.coverButton.alpha = 0.f;
        [self layoutIfNeeded];
    }];
    [searchBar setBackgroundImage:[UIImage resizableImageWithImageName:ZLSwitchCitySourceName(@"bg_login_textfield")]];
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
    self.searchResult.hidden = YES;
    searchBar.text = nil;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        self.searchResult.hidden = NO;
        self.searchResult.searchText = searchText;
    } else {
        self.searchResult.hidden = YES;
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroup.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZLCityGroups *cityGroups = self.cityGroup[section];
    return cityGroups.cities.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *cellID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    ZLCityGroups *cityGoups = self.cityGroup[indexPath.section];
    cell.textLabel.text = cityGoups.cities[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZLCityGroups *cityGroup = self.cityGroup[indexPath.section];
    // 发出通知
    [NS_NOTIFICATION_CENTER postNotificationName:ZLCityDidChangeNotification object:nil userInfo:@{ZLSelectCityName : cityGroup.cities[indexPath.row]}];
    [self dismiss];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZLCityGroups *cityGroups = self.cityGroup[section];
    return cityGroups.title;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.cityGroup valueForKey:@"title"];
}

@end
