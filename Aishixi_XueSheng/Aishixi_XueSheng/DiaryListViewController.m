//
//  DiaryListViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "DiaryListViewController.h"
#import "DiaryInfoViewController.h"
#import "XL_TouWenJian.h"
@interface DiaryListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float width;
    NSMutableArray *arr;
     int  pageNo,pageSize,count;
}

@end

@implementation DiaryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    [self comeback];
    [self delegate];
    count = 0;
    pageSize = 5;
    pageNo = 1;
    arr =[NSMutableArray array];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    [self wlrequest];
   
    width =[UIScreen mainScreen].bounds.size.width;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadNewData{
    arr =[NSMutableArray array];
    [_tableview reloadData];
    pageNo = 1;
    [self wlrequest];
    [_tableview.mj_header endRefreshing];
    self.tableview.mj_footer.hidden = NO;
}
-(void)loadMoreData{
    if (pageNo * pageSize >= count) {
        self.tableview.mj_footer.hidden = YES;
    }else{
        pageNo += 1;
        [self wlrequest];
        [_tableview.mj_footer endRefreshing];
    }
}

-(void)comeback{
    self.title =@"我的日记";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    

    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)wlrequest{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/diary/internshipList";
    
    NSString *_pageSize = [NSString stringWithFormat:@"%d",pageSize];
    
    NSString *_pageNo = [NSString stringWithFormat:@"%d",pageNo];
    
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",_pageNo,@"pageNo",_pageSize,@"pageSize",nil];
    
     [WarningBox warningBoxModeIndeterminate:@"正在加载" andView:self.view];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            
        NSLog(@"16 学生日记列表\n%@",responseObject);
       
       //arr=[[responseObject objectForKey:@"data"] objectForKey:@"internshipList"];
       [arr addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"internshipList"]];
            
            
        count = [[[responseObject objectForKey:@"data"] objectForKey:@"count"] intValue];
        [_tableview reloadData];
       
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        
        NSLog(@"%@",error);
    }];
    
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
    
    return arr.count;

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
    UIButton *type = [[UIButton alloc]initWithFrame:CGRectMake(backview.frame.size.width-80,35, 50, 20)];
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(10,50, 180, 20)];
    title.font =[UIFont systemFontOfSize:15];
    title.adjustsFontSizeToFitWidth =YES;
    time.font =[UIFont systemFontOfSize:13];
    time.textColor =[UIColor lightGrayColor];
//    type.font =[UIFont systemFontOfSize:15];
//    type.adjustsFontSizeToFitWidth =YES;
//    type.textAlignment =NSTextAlignmentRight;
    
    if([[arr[indexPath.row]objectForKey:@"quesionChapter"] intValue]==1){
       [type setTitle:@"公开" forState:UIControlStateNormal];
       [type setImage:[UIImage imageNamed:@"公开.png"] forState:UIControlStateNormal];
        [type setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2,10)];
        [type setTitleEdgeInsets:UIEdgeInsetsMake(0,0, 0, 0)];
       [type setTitleColor:[UIColor colorWithHexString:@"0FE5C9"] forState:UIControlStateNormal];
    }else{
        [type setTitle:@"私密" forState:UIControlStateNormal];
        [type setImage:[UIImage imageNamed:@"私密.png"] forState:UIControlStateNormal];
        [type setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2,10)];
        [type setTitleEdgeInsets:UIEdgeInsetsMake(0,0, 0, 0)];
        [type setTitleColor:[UIColor colorWithHexString:@"9165F6"] forState:UIControlStateNormal];
    }
    
    
    type.titleLabel.font =[UIFont systemFontOfSize:13];
    
    
    if(nil==[arr[indexPath.row]objectForKey:@"content"]){
        title.text=@"";
    }else{
        title.text =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"content"]];
        
    }
    if(nil==[arr[indexPath.row]objectForKey:@"cretateTime"]){
        
        time.text =@"";
    }else{
        time.text =[NSString stringWithFormat:@"%@",[arr[indexPath.row]objectForKey:@"cretateTime"]];
        
    }


    
    
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
//
    DiaryInfoViewController *info = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DiaryInfo"];
    info.InternshipId =[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"internshipId"]];
    
    [self.navigationController pushViewController:info animated:YES];
    
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    CGFloat rotationAngleDegrees = 0;
//    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
//    CGPoint offsetPositioning = CGPointMake(-200, -20);
//    CATransform3D transform = CATransform3DIdentity;
//    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
//    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
//    
//    
//    UIView *card = [cell contentView];
//    card.layer.transform = transform;
//    card.layer.opacity = 0.8;
//    
//    
//    
//    [UIView animateWithDuration:1.0f animations:^{
//        card.layer.transform = CATransform3DIdentity;
//        card.layer.opacity = 1;
//    }];
//    
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
