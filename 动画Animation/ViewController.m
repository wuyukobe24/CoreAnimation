//
//  ViewController.m
//  动画Animation
//
//  Created by WangXueqi on 17/8/2.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "ViewController.h"
#import "AnimationViewController.h"

#define K_ScreenWidth   CGRectGetWidth([[UIScreen mainScreen] bounds])// 当前屏幕宽
#define K_ScreenHeight  CGRectGetHeight([[UIScreen mainScreen] bounds])// 当前屏幕高
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation ViewController
{

    UIView * view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Core Animation动画";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_ScreenWidth, K_ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

- (NSArray *)dataArray {

    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"旋转和移动",@"移动",@"角度旋转",@"图片旋转(仿膜拜)",@"混合动画",@"嵌套动画",@"视图切换的转场动画", nil];
    }
    return _dataArray;
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AnimationViewController * animation = [[AnimationViewController alloc]init];
    animation.index = [NSString stringWithFormat:@"%zi",indexPath.row];
    animation.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:animation animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
