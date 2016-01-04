//
//  UIView+ZLFrame.h
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZLFrame)

/**  控件的x轴坐标*/
@property (nonatomic, assign) CGFloat zl_rectX;
/**  控件的y轴坐标*/
@property (nonatomic, assign) CGFloat zl_rectY;
/**  控件的宽度width*/
@property (nonatomic, assign) CGFloat zl_rectWidth;
/**  控件的高度height*/
@property (nonatomic, assign) CGFloat zl_rectHeight;
/**  控件中心点的x轴坐标*/
@property (nonatomic, assign) CGFloat zl_centerX;
/**  控件中心点的y轴坐标*/
@property (nonatomic, assign) CGFloat zl_centerY;
/**  控件的坐标origin*/
@property (nonatomic, assign) CGPoint zl_origin;
/**  控件的大小size*/
@property (nonatomic, assign) CGSize zl_size;

@property (nonatomic, assign) CGFloat zl_maxX;

@property (nonatomic, assign) CGFloat zl_midX;

@property (nonatomic, assign) CGFloat zl_minX;

@property (nonatomic, assign) CGFloat zl_maxY;

@property (nonatomic, assign) CGFloat zl_midY;

@property (nonatomic, assign) CGFloat zl_minY;

@end
