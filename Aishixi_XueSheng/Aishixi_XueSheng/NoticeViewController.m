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
    int  pageNo,pageSize,count;
}
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
   
    [self comeback];
    count = 0;
    pageSize = 5;
    pageNo = 1;
    arr =[NSMutableArray array];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
     [self wangluo];
}

-(void)loadNewData{
    arr =[NSMutableArray array];
    [_tableview reloadData];
    pageNo = 1;
    [self wangluo];
    [_tableview.mj_header endRefreshing];
    self.tableview.mj_footer.hidden = NO;
}
-(void)loadMoreData{
    if (pageNo * pageSize >= count) {
        self.tableview.mj_footer.hidden = YES;
    }else{
        pageNo += 1;
        [self wangluo];
        [_tableview.mj_footer endRefreshing];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)comeback{
    self.title =@"公告";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)wangluo{
     NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/homePageStu/noticeList";
    
    NSString *_pageSize = [NSString stringWithFormat:@"%d",pageSize];
    
    NSString *_pageNo = [NSString stringWithFormat:@"%d",pageNo];
    
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",_pageNo,@"pageNo",_pageSize,@"pageSize", nil];
    
    [WarningBox warningBoxModeIndeterminate:@"正在加载" andView:self.view];
    
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
        
        NSLog(@"9 学生公告列表\n%@",responseObject);
        
       // arr =[[responseObject objectForKey:@"data"] objectForKey:@"noticeList"];
            [arr addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"noticeList"]];
        count = [[[responseObject objectForKey:@"data"] objectForKey:@"count"] intValue];
        //arr=(NSMutableArray *)[[arr reverseObjectEnumerator] allObjects];
        [_tableview reloadData];
            
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
            
            
    } failure:^(NSError *error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
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



-(void)delegate{
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor =[UIColor clearColor];
    //self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    width =[UIScreen mainScreen].bounds.size.width;
    height =[UIScreen mainScreen].bounds.size.height;
   }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return arr.count;
    //return 10;
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
    UIImageView*imageview=[[UIImageView alloc] initWithFrame:CGRectMake(15,20, 15, 20)];
    imageview.image =[UIImage imageNamed:@"发布.png"];
    
    UILabel *titles = [[UILabel alloc]initWithFrame:CGRectMake(40,10,width-175,20)];
    
    titles.font =[UIFont systemFontOfSize:15];
    
    if([arr[indexPath.section]objectForKey:@"noticeTitle"]==NULL){
    titles.text =@"";
    }else{
    titles.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"noticeTitle"]];
    }
    
    UILabel *pushtime = [[UILabel alloc]initWithFrame:CGRectMake(40,30,width-175,20)];
    pushtime.font =[UIFont systemFontOfSize:13];
    pushtime.textColor=[UIColor colorWithHexString:@"AAAAAA"];
    if([arr[indexPath.section]objectForKey:@"createDate"]==NULL){
     pushtime.text =@"";
    }else{
     pushtime.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"createDate"]];
    }
   
//    NSString *ss=[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"pushTime"]];
//    ss=[ss substringToIndex:10];
//    pushtime.text =ss;
    
//    UILabel *ll =[[UILabel alloc]initWithFrame:CGRectMake(width-90,10,50,30)];
//    ll.layer.borderWidth =1;
//    ll.layer.cornerRadius =5;
//    ll.text =@"最新";
    UIImageView*imageview1=[[UIImageView alloc] initWithFrame:CGRectMake(width-90,10,30,33)];
    
    UIImageView*imageview2=[[UIImageView alloc] initWithFrame:CGRectMake(width-50,0,30,30)];
    if([[arr[indexPath.section]objectForKey:@"level"] intValue]==1){
     imageview1.image =[UIImage imageNamed:@"important.png"];
    }else{
     imageview1.image =[UIImage imageNamed:@""];
    }
    
    if([[arr[indexPath.section]objectForKey:@"isRead"] intValue]==1){
        imageview2.image =[UIImage imageNamed:@""];
    }else{
       imageview2.image =[UIImage imageNamed:@"weidu.png"];
    }
    
    
    
    
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

    NoticeInfoViewController *info = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"noticeinfo"];
    
     info.NoticeId =[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"noticeId"]];
    
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
