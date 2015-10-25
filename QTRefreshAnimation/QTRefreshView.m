//
//  QTRefreshView.m
//  QTRefreshAnimation
//
//  Created by chenqitao on 15/10/23.
//  Copyright © 2015年 陈齐涛. All rights reserved.
//

#import "QTRefreshView.h"
#define RefreshImageSize  60

@implementation QTRefreshView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];

    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    _isrefresh = NO;
    _isstartAnimation = NO;
    self.backgroundColor = [UIColor clearColor];
    _refreshIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-RefreshImageSize/2, -RefreshImageSize, RefreshImageSize, RefreshImageSize)];

    _refreshIV.image = _imageArray?[_imageArray firstObject]:[UIImage imageNamed:@"refresh"];
    [self addSubview:_refreshIV];
}

#pragma mark 画图
- (void)drawRect:(CGRect)rect {
    
    CGRect frame = _refreshIV.frame;
    frame.origin.y -= (_offsetY -_oldoOffsetY )/1.8;
    _refreshIV.frame = frame;
    _oldoOffsetY = _offsetY;
    
    [self refreshWithOffset:_offsetY];
    [self startAnimationByOffset:_offsetY];
    // 创建一个贝塞尔曲线句柄
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 初始化该path到一个初始点
    [path moveToPoint:CGPointMake(0, 0)];
//    // 添加一条直线，从初始点到该函数指定的坐标点
//    [path addLineToPoint:CGPointMake(0, 0)];
    // 画二元曲线，一般和moveToPoint配合使用
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width, 0) controlPoint:CGPointMake(self.frame.size.width/2,- _offsetY*1.2)];
//    // 添加一条直线，从初始点到该函数指定的坐标点
//    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    // 关闭该path
    [path closePath];
    // 创建描边（Quartz）上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 将此path添加到Quartz上下文中
    CGContextAddPath(context, path.CGPath);
    // 设置本身颜色
    [[UIColor redColor] set];
    // 设置填充的路径
    CGContextFillPath(context);
}

#pragma mark --判断是否是刷新的距离
- (void)refreshWithOffset:(CGFloat)offset {
    
    _refreshIV.hidden = offset<=-RefreshImageSize?NO:YES;
    
    if (offset<-(RefreshImageSize+64)) {
        if (!_isrefresh) {
            _isrefresh = YES;
            if (_refreshBlock) {
                _refreshBlock();
            }
         }
    }
    else {
        _isrefresh = NO;
    }
}

#pragma mark --设置刷新时的动画
- (void)addRefreshAnimationWithImageArray:(NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = imageArray;
    }
}

#pragma mark --开始动画
- (void)startAnimationByOffset:(CGFloat)offset {
    if ( offset <-RefreshImageSize+10) {
        if (!_isstartAnimation) {
            _isstartAnimation = YES;
            _refreshIV.animationImages = _imageArray;
            _refreshIV.animationDuration = 0.25;
            _refreshIV.animationRepeatCount = 100;
            [_refreshIV startAnimating];
        }
    }
    else {
        _isstartAnimation = NO;
        [_refreshIV stopAnimating];
    }

}

#pragma mark --刷新成功所调用方法
- (void)refreshSuccessWithBlock:(RefreshBlock)successBlock {
    _refreshBlock = successBlock;
}

#pragma mark --因为我加了这一层view在tableview的上面，所以要把触摸时间给tableview
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    else {
        for (UIView *view in self.superview.subviews) {
            if ([view isKindOfClass:[UITableView class]]) {
                return view;
            }
        }
    }
    return nil;
}


@end
