//
//  QTRefreshView.h
//  QTRefreshAnimation
//
//  Created by chenqitao on 15/10/23.
//  Copyright © 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^RefreshBlock)();

@interface QTRefreshView : UIView
@property (nonatomic, assign) CGFloat      offsetY;          /**< 记录Y的偏移*/
@property (nonatomic, strong) UIImageView  *refreshIV;       /**< 自定义刷新头像*/
@property (nonatomic, assign) CGFloat      oldoOffsetY;      /**< 记录前一次的位置*/
@property (nonatomic, assign) BOOL         isrefresh;        /**< 是否刷新*/
@property (nonatomic, assign) BOOL         isstartAnimation; /**< 是否开始动画*/
@property (nonatomic, copy)   RefreshBlock refreshBlock;     /**< 下拉一定距离触发刷新*/
@property (nonatomic, strong) NSArray      *imageArray;      /**< 储存动画图片的数组*/


/*
 添加一个刷新成功回调方法
 */
- (void)refreshSuccessWithBlock:(RefreshBlock)successBlock;
/*
 设置刷新时的动画
 */
- (void)addRefreshAnimationWithImageArray:(NSArray *)imageArray;

@end
