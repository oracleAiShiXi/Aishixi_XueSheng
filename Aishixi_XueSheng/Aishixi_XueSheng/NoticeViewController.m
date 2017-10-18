//
//  NoticeViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeInfoViewController.h"
#import "XL_TouWenJian.h"
@interface NoticeViewController ()
{
    float width;
    float height;
    NSMutableArray *arr;
}
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
   // [self wangluo];
    self.title =@"公告";
    //[self comeback];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)wangluo{
     NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/homePageStu/noticeList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",@"1",@"pageNo",@"5",@"pageSize", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"9 学生公告列表\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
//    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
//    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
//    NSString *fangshi =@"/userInfo/pushList";
//    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",[def objectForKey:@"officeId"],@"officeId", nil];
//    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
//        
//        
//        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
//            [WarningBox warningBoxHide:YES andView:self.view];
//            arr =[NSMutableArray array];
//            arr =[[responseObject objectForKey:@"data"] objectForKey:@"pushInfoList"];
//            if(arr.count==0){
//                _Img.hidden =NO;
//                _table.hidden=YES;
//            }else{
//                _Img.hidden =YES;
//                _table.hidden =NO;
//                [_table reloadData];
//            }
//            
//            
//        }
//        else if ([[responseObject objectForKey:@"code"]isEqual:@"9999"]){
//            //账号在其他手机登录，请重新登录。
//            [XL_wangluo sigejiu:self];
//        }
//        else{
//            [WarningBox warningBoxHide:YES andView:self.view];
//            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
//        }
//    } failure:^(NSError *error) {
//        [WarningBox warningBoxHide:YES andView:self.view];
//        [WarningBox warningBoxModeText:@"网络连接错误" andView:self.view];
//        
//    }];
    
    
}
-(void)refrish{
    //NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self.tableview addSubview:refreshControl];
    
}
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    
    [refreshControl beginRefreshing];
    
    // NSLog(@"refreshClick: -- 刷新触发");
    // 此处添加刷新tableView数据的代码
    [self wangluo];
    [refreshControl endRefreshing];
    //[self.table reloadData];// 刷新tableView即可
}


-(void)delegate{
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor =[UIColor clearColor];
    //self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    width =[UIScreen mainScreen].bounds.size.width;
    height =[UIScreen mainScreen].bounds.size.height;
    _tableview.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return arr.count;
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"heheda";
    UITableViewCell *cell=[self.tableview dequeueReusableCellWithIdentifier:aa];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    //    for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
    //        [suView removeFromSuperview];//移除全部子视图
    //    }
    
    UIView*backview=[[UIView alloc] initWithFrame:CGRectMake(0,10,width-20,55)];
    backview.backgroundColor =[UIColor whiteColor];
    UIImageView*imageview=[[UIImageView alloc] initWithFrame:CGRectMake(15,15, 30, 30)];
    imageview.image =[UIImage imageNamed:@"01.png"];
    
    UILabel *titles = [[UILabel alloc]initWithFrame:CGRectMake(55,10,width-175,20)];
    
    titles.font =[UIFont systemFontOfSize:15];
    
   // titles.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"title"]];
    titles.text =[NSString stringWithFormat:@"新学期暑期实习公告"];
    UILabel *pushtime = [[UILabel alloc]initWithFrame:CGRectMake(55,30,width-175,20)];
    pushtime.font =[UIFont systemFontOfSize:15];
    pushtime.text =[NSString stringWithFormat:@"2017.06.21 17:54:20"];
//    NSString *ss=[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"pushTime"]];
//    ss=[ss substringToIndex:10];
//    pushtime.text =ss;
    
//    UILabel *ll =[[UILabel alloc]initWithFrame:CGRectMake(width-90,10,50,30)];
//    ll.layer.borderWidth =1;
//    ll.layer.cornerRadius =5;
//    ll.text =@"最新";
    UIImageView*imageview1=[[UIImageView alloc] initWithFrame:CGRectMake(width-90,10,40,30)];
    imageview1.image =[UIImage imageNamed:@"important.png"];
    UIImageView*imageview2=[[UIImageView alloc] initWithFrame:CGRectMake(width-50,0,30,30)];
    imageview2.image =[UIImage imageNamed:@"weidu.png"];
    //    UIImageView*imageview1=[[UIImageView alloc] initWithFrame:CGRectMake(width-50,35,20,20)];
    //    if([[arr[indexPath.section]objectForKey:@"state"] intValue]==1){
    //      imageview1.image =[UIImage imageNamed:@"新消息提示-2.png"];
    //    }else{
    //      imageview1.image =[UIImage imageNamed:@""];
    //    }
    
    
    
    
    [backview addSubview:imageview];
    [backview addSubview:titles];
    [backview addSubview:pushtime];
    [backview addSubview:imageview1];
    [backview addSubview:imageview2];
    [cell addSubview:backview];
  
    
    backview.layer.cornerRadius =5;
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    self.hidesBottomBarWhenPushed=YES;
//    NoticeInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
//                                   instantiateViewControllerWithIdentifier:@"noteinfo"];
//    his.pushId =[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"id"]];
//    [self.navigationController pushViewController:his animated:YES];
    NoticeInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"noticeinfo"];
    [self.navigationController pushViewController:his animated:YES];
    
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
