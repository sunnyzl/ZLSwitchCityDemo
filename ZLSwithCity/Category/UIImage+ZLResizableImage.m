//
//  UIImage+ZLResizableImage.m
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/16.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "UIImage+ZLResizableImage.h"

@implementation UIImage (ZLResizableImage)

+ (UIImage *)resizableImageWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5) resizingMode:UIImageResizingModeStretch];
}

+ (UIImage *)resizableImageInVerticalWithImageName:(NSString *)imageName
{
   UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, 0, image.size.height * 0.5, 0) resizingMode:UIImageResizingModeStretch];
}

@end
