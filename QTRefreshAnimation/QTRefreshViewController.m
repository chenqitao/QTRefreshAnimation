//
//  QTRefreshViewController.m
//  QTRefreshAnimation
//
//  Created by chenqitao on 15/10/23.
//  Copyright © 2015年 陈齐涛. All rights reserved.
//

#import "QTRefreshViewController.h"
#import "QTRefreshView.h"

@interface QTRefreshViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView       *myTableView;
    QTRefreshView   *refreshHeadView;
    CGFloat           oldOffsetY;    /**< 记录上一次的偏移量*/
}
@end

@implementation QTRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"fun";
#pragma mark -- tableview
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    [self initHeadView];

    
}

- (void)initHeadView {
#pragma mark 创建刷新动画view,如果高度为0的话不会执行draw rect绘制方法
    refreshHeadView =[[QTRefreshView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)];
    [refreshHeadView refreshSuccessWithBlock:^{
        NSLog(@"刷新成功");
    }];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i =1; i<7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [imageArr addObject:image];
    }
    [refreshHeadView addRefreshAnimationWithImageArray:imageArr];
    [self.view addSubview:refreshHeadView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"哇，好屌";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y+64;
    refreshHeadView.offsetY = offsetY;
   
    //异步执行，setNeedsDisplay会调用自动调用drawRect方法
    [refreshHeadView setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
