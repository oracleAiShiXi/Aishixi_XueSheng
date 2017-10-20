//
//  SetViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "SetViewController.h"
#import "ChangePassViewController.h"
@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navagatio];
    // Do any additional setup after loading the view.
}

-(void)navagatio{
    self.title =@"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    //    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
    //    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
    //    self.navigationItem.leftBarButtonItem =left;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
}

-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)ChangePass:(id)sender {
    ChangePassViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ChangePass"];
    [self.navigationController pushViewController:his animated:YES];
    
}

- (IBAction)Exit:(id)sender {
}
@end
