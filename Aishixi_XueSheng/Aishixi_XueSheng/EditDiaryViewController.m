//
//  EditDiaryViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "EditDiaryViewController.h"
#import "DiaryListViewController.h"
@interface EditDiaryViewController ()

@end

@implementation EditDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"日记";
    [self initButton:self.btn1];
    [self initButton:self.btn2];
    [self initButton:self.btn3];
    [self navagat];
    // Do any additional setup after loading the view.
}

-(void)navagat{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"我的日记" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)History{
    DiaryListViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DiaryList"];
    [self.navigationController pushViewController:his animated:YES];
    
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

-(void)initButton:(UIButton*)btn{
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0,5)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}




- (IBAction)EditBtn:(id)sender {
}

- (IBAction)Happy:(id)sender {
}

- (IBAction)Common:(id)sender {
}

- (IBAction)Bad:(id)sender {
}

- (IBAction)Switcn:(id)sender {
}

- (IBAction)Publish:(id)sender {
}
@end
