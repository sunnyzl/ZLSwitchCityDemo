//
//  ZLSwitchCityDropDownMenu.m
//  ZLSwitchCityController
//
//  Created by zhaoliang on 15/12/16.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLSwitchCityDropDownMenu.h"
#import "UIView+ZLFrame.h"
#import "UIImage+ZLResizableImage.h"
#import "ZLCommonConst.h"

@interface ZLSwitchCityDropDownMenu () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *containerView;

@property (nonatomic, copy) ZLSwitchCityDropDownMenuDismissMenuHandler dismissHandler;

@end

@implementation ZLSwitchCityDropDownMenu


- (UIImageView *)containerView
{
    if (_containerView == nil)
    {
        _containerView = [[UIImageView alloc] init];
        _containerView.userInteractionEnabled = YES;
        [self addSubview:_containerView];
    }
    return _containerView;
}

+ (instancetype)menu
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.arrowPosition = ZLSwitchCityDropDownMenuArrowPositionCenter;
    }
    return self;
}

- (void)setupDismissMenuHandler:(ZLSwitchCityDropDownMenuDismissMenuHandler)dismissHandler
{
    self.dismissHandler = [dismissHandler copy];
}

- (void)setContent:(UIView *)content
{
    _content = content;
    content.zl_rectX = 10;
    content.zl_rectY = 15;
    //  调整下拉菜单的宽高
    self.containerView.zl_rectWidth = (CGRectGetMaxX(content.frame)) + 10;
    self.containerView.zl_rectHeight = (CGRectGetMaxY(content.frame)) + 10;
    
    //  将内容添加到下拉菜单背景图片上
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

- (void)setArrowPosition:(ZLSwitchCityDropDownMenuArrowPosition)arrowPosition
{
    _arrowPosition = arrowPosition;
    switch (arrowPosition) {
        case ZLSwitchCityDropDownMenuArrowPositionCenter:
        {
            self.containerView.image = [UIImage resizableImageInVerticalWithImageName:ZLSwitchCitySourceName(@"popover_background")];
        }
            break;
        case ZLSwitchCityDropDownMenuArrowPositionLeft:
            self.containerView.image = [UIImage resizableImageWithImageName:ZLSwitchCitySourceName(@"popover_background_left")];
            break;
        case ZLSwitchCityDropDownMenuArrowPositionRight:
            self.containerView.image = [UIImage resizableImageWithImageName:ZLSwitchCitySourceName(@"popover_background_right")];
            break;
            
        default:
            break;
    }
}

- (void)showFrom:(UIView *)from didShow:(void (^)(void))showMenuHandler
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:self];
    self.frame = window.bounds;
    
    CGRect newFrame = [from convertRect:from.bounds toView:nil];
    self.containerView.zl_rectY = CGRectGetMaxY(newFrame);
    switch (self.arrowPosition) {
        case ZLSwitchCityDropDownMenuArrowPositionCenter:
            self.containerView.zl_midX = CGRectGetMidX(newFrame);
            break;
        case ZLSwitchCityDropDownMenuArrowPositionLeft:
            self.containerView.zl_minX = CGRectGetMinX(newFrame);
            break;
        case ZLSwitchCityDropDownMenuArrowPositionRight:
            self.containerView.zl_maxX = CGRectGetMaxX(newFrame);
            break;
        default:
            break;
    }
    if (showMenuHandler) {
        showMenuHandler();
    }
}

- (void)dismiss
{
    if (self.dismissHandler) {
        self.dismissHandler(self);
    }
    [self removeFromSuperview];
}

- (void)dismissWithDismissMenuHandler:(ZLSwitchCityDropDownMenuDismissMenuHandler)dismissHandler
{
    if (dismissHandler) {
        dismissHandler(self);
    }
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint tapPoint = [touch locationInView:self.containerView];
    if (!CGRectContainsPoint(self.containerView.bounds, tapPoint)) {
        [self dismiss];
    }
}


@end
