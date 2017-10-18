//
//  PhoneViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/10/17.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "PhoneViewController.h"
#import "XL_TouWenJian.h"
@interface PhoneViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self navagatio];
    //[self jiekou];
    [self delegate];
    // Do any additional setup after loading the view.
}

-(void)navagatio{
    self.title =@"通讯录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    //    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
    //    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
    //    self.navigationItem.leftBarButtonItem =left;
    
    
    
}


-(void)jiekou{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/attend/mailList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"20 学生通讯录\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    //_table.backgroundColor =[UIColor clearColor];
    self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return arr.count;
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"mycell";
    UITableViewCell *cell=[self.table dequeueReusableCellWithIdentifier:aa];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    //        for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
    //            [suView removeFromSuperview];//移除全部子视图
    //        }

     UILabel *teaname =(UILabel*)[cell viewWithTag:100];
     UILabel *phonenum =(UILabel*)[cell viewWithTag:101];
     teaname.text =[NSString stringWithFormat:@"姓名:%@",@"linzixi"];
     phonenum.text =[NSString stringWithFormat:@"%@",@"13214567896"];
    
    //cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"1");
    
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
