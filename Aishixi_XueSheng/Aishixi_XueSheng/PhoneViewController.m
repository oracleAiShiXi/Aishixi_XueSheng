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
{
     NSMutableArray *arr;
    int  pageNo,pageSize,count;
}
@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self navagatio];
    [self jiekou];
    [self delegate];
    
    count = 0;
    pageSize = 5;
    pageNo = 1;
    arr =[NSMutableArray array];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // Do any additional setup after loading the view.
}

-(void)loadNewData{
    arr =[NSMutableArray array];
    [_table reloadData];
    pageNo = 1;
    [self jiekou];
    [_table.mj_header endRefreshing];
    self.table.mj_footer.hidden = NO;
}
-(void)loadMoreData{
    if (pageNo * pageSize >= count) {
        self.table.mj_footer.hidden = YES;
    }else{
        pageNo += 1;
        [self jiekou];
        [_table.mj_footer endRefreshing];
    }
}

-(void)navagatio{
    self.title =@"通讯录";
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



-(void)jiekou{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/attend/mailList";
    
    NSString *_pageSize = [NSString stringWithFormat:@"%d",pageSize];
    
    NSString *_pageNo = [NSString stringWithFormat:@"%d",pageNo];
    
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",_pageNo,@"pageNo",_pageSize,@"pageSize",nil];
    [WarningBox warningBoxModeIndeterminate:@"正在加载" andView:self.view];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        NSLog(@"20 学生通讯录\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
           NSLog(@"20 学生通讯录\n%@",responseObject);
           
           //arr=[[responseObject objectForKey:@"data"] objectForKey:@"mailList"];
            [arr addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"mailList"]];
            count = [[[responseObject objectForKey:@"data"] objectForKey:@"count"] intValue];
           [_table reloadData];
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
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
    //_table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return arr.count;
    //return 10;
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
     teaname.text =[NSString stringWithFormat:@"姓名:%@",[arr[indexPath.section]objectForKey:@"nick"]];
     phonenum.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"mobilePhone"]];
    
    //cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   NSString*ss = [NSString stringWithFormat:@"确定要联系%@吗？",[arr[indexPath.section]objectForKey:@"nick"] ];
   // NSLog(@"%@",ss);
    //调用打电话方法
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:ss preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *ss = [NSString stringWithFormat:@"tel://%@",[arr[indexPath.section]objectForKey:@"mobilePhone"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ss]];
        
    }];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:^{
    }];
    
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
