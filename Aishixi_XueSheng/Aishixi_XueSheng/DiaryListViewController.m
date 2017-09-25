//
//  DiaryListViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "DiaryListViewController.h"
#import "Color+Hex.h"
@interface DiaryListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float width;
    NSMutableArray *arr;
    
}

@end

@implementation DiaryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"日记";
    //[self comeback];
    [self delegate];
    //[self wlrequest];
    //[self refrish];
    width =[UIScreen mainScreen].bounds.size.width;
    
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

-(void)wlrequest{
//    [WarningBox warningBoxModeIndeterminate:@"正在加载,请稍后" andView:self.view];
//    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
//    NSString *fangshi =@"/attend/attendanceHistoryList";
//    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",@"1",@"pageNo",@"10",@"pageSize",[def objectForKey:@"officeId"],@"officeId", nil];
//    
//    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
//        
//        [WarningBox warningBoxHide:YES andView:self.view];
//        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
//            arr =[NSMutableArray array];
//            arr=[[responseObject objectForKey:@"data"] objectForKey:@"attendList"];
//            if(arr.count==0){
//                _backimg.hidden= NO;
//                _table.hidden=YES;
//                
//            }else{
//                _backimg.hidden= YES;
//                _table.hidden=NO;
//                [_table reloadData];
//            }
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
//        
//        [WarningBox warningBoxHide:YES andView:self.view];
//        [WarningBox warningBoxModeText:@"网络连接失败！" andView:self.view];
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
    [self wlrequest];
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
    _Img.hidden= YES;
    // _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return arr.count;
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
    
    UIView*shuxian=[[UIView alloc] initWithFrame:CGRectMake(15,5, 1,90)];
    shuxian.backgroundColor =[UIColor colorWithHexString:@"C9D0D6"];
    UIImageView*imageview=[[UIImageView alloc] initWithFrame:CGRectMake(5,5, 20, 20)];
    imageview.image =[UIImage imageNamed:@"时间.png"];
    
    //内部构造
    UIView *backview =[[UIView alloc]initWithFrame:CGRectMake(30,10, width-40, 80)];
    backview.backgroundColor =[UIColor whiteColor];
    backview.layer.cornerRadius =5;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10,15, 180, 20)];
    UIButton *type = [[UIButton alloc]initWithFrame:CGRectMake(backview.frame.size.width-80,35, 60, 20)];
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(10,50, 180, 20)];
    title.font =[UIFont systemFontOfSize:15];
    title.adjustsFontSizeToFitWidth =YES;
    time.font =[UIFont systemFontOfSize:13];
    time.textColor =[UIColor lightGrayColor];
//    type.font =[UIFont systemFontOfSize:15];
//    type.adjustsFontSizeToFitWidth =YES;
//    type.textAlignment =NSTextAlignmentRight;
    [type setTitle:@"私密" forState:UIControlStateNormal];
    [type setImage:[UIImage imageNamed:@"私密.png"] forState:UIControlStateNormal];
    [type setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2,10)];
    [type setTitleEdgeInsets:UIEdgeInsetsMake(0,0, 0, 0)];
    type.titleLabel.font =[UIFont systemFontOfSize:13];
    [type setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
//    if(nil==[arr[indexPath.row]objectForKey:@"className"]){
//        banji.text=@"";
//    }else{
//        banji.text =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"className"]];
//        
//    }
//    if(nil==[arr[indexPath.row]objectForKey:@"classType"]){
//        
//        xueke.text =@"";
//    }else{
//        xueke.text =[NSString stringWithFormat:@"学科:%@",[arr[indexPath.row]objectForKey:@"classType"]];
//        
//    }
//    if(nil==[arr[indexPath.row]objectForKey:@"teacherName"]){
//        
//        jiaoshi.text =@"";
//    }else{
//        NSString *iqoq =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"teacherName"]];
//        iqoq =[iqoq substringToIndex:1];
//        
//        jiaoshi.text =[NSString stringWithFormat:@"任课教师:%@老师",iqoq];
//        
//    }
    
    
    
    title.text=@"日记内容是啥我不知道啊";
    time.text =@"更新时间:2017.11.12";
    
    
    [backview addSubview:title];
    [backview addSubview:type];
    [backview addSubview:time];
    [cell addSubview:shuxian];
    [cell addSubview:imageview];
    [cell addSubview:backview];
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.hidesBottomBarWhenPushed=YES;
//    AttHisInfoViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"atthisinfo"];
//    his.claassID =[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"classId"]];
//    
//    [self.navigationController pushViewController:his animated:YES];
    
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