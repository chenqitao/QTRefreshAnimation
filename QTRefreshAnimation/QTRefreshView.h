//
//  QTRefreshView.h
//  QTRefreshAnimation
//
//  Created by chenqitao on 15/10/23.
//  Copyright © 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTRefreshView : UIView
@property (nonatomic, assign) CGFloat     offsetY;
@property (nonatomic, strong) UIImageView *refreshIV; /**< 自定义刷新头像*/
@property (nonatomic, assign) CGFloat      oldoOffsetY;  /**< 记录前一次的位置*/
@end
