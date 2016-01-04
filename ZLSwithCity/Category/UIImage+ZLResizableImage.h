//
//  UIImage+ZLResizableImage.h
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/16.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZLResizableImage)

+ (UIImage *)resizableImageWithImageName:(NSString *)imageName;

+ (UIImage *)resizableImageInVerticalWithImageName:(NSString *)imageName;

@end
