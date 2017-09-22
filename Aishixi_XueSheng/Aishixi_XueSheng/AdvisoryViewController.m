//
//  AdvisoryViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "AdvisoryViewController.h"
#import "AdvisoryInfoViewController.h"
#import "EditAdvisoryViewController.h"
@interface AdvisoryViewController ()
{
    float width;
    float height;
    NSMutableArray *arr;
}
@end

@implementation AdvisoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self delegate];
    // [self wangluo];
    self.title =@"咨询";
    //[self comeback];
    [self navagat];
    
    // Do any additional setup after loading the view.
}
-(void)navagat{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"写咨询" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)History{
    EditAdvisoryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EditAdvisory"];
    [self.navigationController pushViewController:his animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)comeback{
//    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
//    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
//    [self.navigationItem setLeftBarButtonItem:left];
//}
//-(void)fanhui{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//-(void)wangluo{
//    //    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
//    //    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
//    //    NSString *fangshi =@"/userInfo/pushList";
//    //    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",[def objectForKey:@"officeId"],@"officeId", nil];
//    //    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
//    //
//    //
//    //        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
//    //            [WarningBox warningBoxHide:YES andView:self.view];
//    //            arr =[NSMutableArray array];
//    //            arr =[[responseObject objectForKey:@"data"] objectForKey:@"pushInfoList"];
//    //            if(arr.count==0){
//    //                _Img.hidden =NO;
//    //                _table.hidden=YES;
//    //            }else{
//    //                _Img.hidden =YES;
//    //                _table.hidden =NO;
//    //                [_table reloadData];
//    //            }
//    //
//    //
//    //        }
//    //        else if ([[responseObject objectForKey:@"code"]isEqual:@"9999"]){
//    //            //账号在其他手机登录，请重新登录。
//    //            [XL_wangluo sigejiu:self];
//    //        }
//    //        else{
//    //            [WarningBox warningBoxHide:YES andView:self.view];
//    //            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
//    //        }
//    //    } failure:^(NSError *error) {
//    //        [WarningBox warningBoxHide:YES andView:self.view];
//    //        [WarningBox warningBoxModeText:@"网络连接错误" andView:self.view];
//    //
//    //    }];
//    
//    
//}
//-(void)refrish{
//    //NSLog(@"setupRefresh -- 下拉刷新");
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
//    [self.tableview addSubview:refreshControl];
//    
//}
//- (void)refreshClick:(UIRefreshControl *)refreshControl {
//    
//    [refreshControl beginRefreshing];
//    
//    // NSLog(@"refreshClick: -- 刷新触发");
//    // 此处添加刷新tableView数据的代码
//    [self wangluo];
//    [refreshControl endRefreshing];
//    //[self.table reloadData];// 刷新tableView即可
//}
//
//
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
    return 85;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"mycell";
    UITableViewCell *cell=[self.tableview dequeueReusableCellWithIdentifier:aa];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
//        for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
//            [suView removeFromSuperview];//移除全部子视图
//        }
   
    UIView *backview =(UIView*)[cell viewWithTag:100];
//    UIImageView*img =(UIImageView*)[cell viewWithTag:105];
//    UILabel *teaname =(UILabel*)[cell viewWithTag:101];
//    UILabel *concent =(UILabel*)[cell viewWithTag:102];
//    UILabel *time =(UILabel*)[cell viewWithTag:103];
//    UILabel *type =(UILabel*)[cell viewWithTag:104];
    
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
    AdvisoryInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdvisoryInfo"];
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
