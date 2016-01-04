//
//  ZLSwitchCityDropDownCitySubCell.m
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/22.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLSwitchCityDropDownCitySubCell.h"
#import "UIImage+ZLResizableImage.h"
#import "ZLCommonConst.h"

@implementation ZLSwitchCityDropDownCitySubCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"sub";
    ZLSwitchCityDropDownCitySubCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZLSwitchCityDropDownCitySubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [UIImage resizableImageWithImageName:ZLSwitchCitySourceName(@"bg_dropdown_rightpart")];
        self.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] init];
        selectedBg.image = [UIImage resizableImageWithImageName:ZLSwitchCitySourceName(@"bg_dropdown_right_selected")];
        self.selectedBackgroundView = selectedBg;
    }
    return self;
}

@end
