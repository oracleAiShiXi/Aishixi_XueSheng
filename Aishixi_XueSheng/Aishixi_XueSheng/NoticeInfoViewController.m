//
//  NoticeInfoViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "NoticeInfoViewController.h"
#import "XL_TouWenJian.h"
@interface NoticeInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float width;
    float height;
    UILabel *messa;
    UILabel *titt;
    NSDictionary*arr;
}

@end

@implementation NoticeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    [self wangluo];
    [self comeback];
  
    
   
    // Do any additional setup after loading the view.
}
-(void)comeback{
    self.title =@"公告详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
-(void)wangluo{
     arr =[[NSDictionary alloc]init];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/homePageStu/noticeInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",_NoticeId,@"noticeId",nil];
    //NSLog(@"%@",Rucan);
    [WarningBox warningBoxModeIndeterminate:@"正在加载" andView:self.view];
    
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
        
       // NSLog(@"10 学生公告详情\n%@",responseObject);

        arr =[responseObject objectForKey:@"data"];
        [_tableview reloadData];
        
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
        //NSLog(@"%@",error);
    }];
    
    
//    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
//    //通知的状态还不知道有几个
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    NSString *fangshi =@"/userInfo/pushInfo";
//    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_pushId,@"pushId",@"1",@"state",[def objectForKey:@"officeId"],@"officeId", nil];
//    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
//        
//        [WarningBox warningBoxHide:YES andView:self.view];
//        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
//            
//            arr =[responseObject objectForKey:@"data"];
//            [_table reloadData];
//        }
//        else if ([[responseObject objectForKey:@"code"]isEqual:@"9999"]){
//            //账号在其他手机登录，请重新登录。
//            [XL_wangluo sigejiu:self];
//        }
//        else{
//            [WarningBox warningBoxHide:YES andView:self.view];
//            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
//        }
//        
//    } failure:^(NSError *error) {
//        [WarningBox warningBoxHide:YES andView:self.view];
//        [WarningBox warningBoxModeText:@"网络连接错误" andView:self.view];
//        
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
    _tableview.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0){
        NSString* s=[[NSString alloc] init];
        if(nil==[arr objectForKey:@"noticeTitle"]){
            s =@"";
        }else{
            s =[NSString stringWithFormat:@"%@",[arr objectForKey:@"noticeTitle"]];
        }
        
        titt=[[UILabel alloc] init];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        titt.textAlignment =NSTextAlignmentLeft;
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]initWithString:s attributes:@{NSFontAttributeName: font}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-40, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        
        
        titt.text=s;
        [titt setFrame:CGRectMake(35,20,width-40, rect.size.height)];
        return titt.frame.size.height+15>40? titt.frame.size.height+15:40;
        
    }
    else if (indexPath.row==1){
        NSString* ss=[[NSString alloc] init];
        if(nil==[arr objectForKey:@"noticeContext"]){
            ss =@"";
        }else{
            ss =[NSString stringWithFormat:@"%@",[arr objectForKey:@"noticeContext"]];
        }

        messa=[[UILabel alloc] init];
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-40, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        
        messa.text=ss;
        [messa setFrame:CGRectMake(20,10, rect.size.width, rect.size.height)];
        
        return messa.frame.size.height+15>40? messa.frame.size.height+55:40;
    }
    else{
        return 90;
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
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
    
    if(indexPath.section==0){
        if (indexPath.row==0){
            UIView *sdid = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 5, 20)];
            sdid.backgroundColor = [UIColor colorWithHexString:@"EF00FF"];
            [cell.contentView addSubview:sdid];
            
            titt.numberOfLines=0;
            titt.font=[UIFont fontWithName:@"Arial" size:20];
            titt.textColor=[UIColor colorWithHexString:@"323232"];
            [cell.contentView addSubview:titt];
           
        }
        else if (indexPath.row==1){
            messa.numberOfLines=0;
            messa.font= [UIFont systemFontOfSize:14];
            messa.textColor=[UIColor colorWithHexString:@"323232"];
            [cell.contentView addSubview:messa];
            
        }
        else{
            UILabel *name= [[UILabel alloc]initWithFrame:CGRectMake(width-250, 10,230, 20)];
            name.textColor =[UIColor colorWithHexString:@"908C8C"];
            name.font= [UIFont systemFontOfSize:14];
            name.textAlignment = NSTextAlignmentRight;
            
            
            UILabel *school= [[UILabel alloc]initWithFrame:CGRectMake(width-250, 35,230, 20)];
            
            school.textColor =[UIColor colorWithHexString:@"908C8C"];
            school.font= [UIFont systemFontOfSize:14];
            school.textAlignment = NSTextAlignmentRight;
            
            UILabel *time= [[UILabel alloc]initWithFrame:CGRectMake(width-250, 60,230, 20)];
            time.textColor =[UIColor colorWithHexString:@"908C8C"];
            time.font= [UIFont systemFontOfSize:14];
            time.textAlignment = NSTextAlignmentRight;
            
            
            if(nil==[arr objectForKey:@"noticeOrgName"]){
                school.text =@"";
            }else{
                school.text=[NSString stringWithFormat:@"%@",[arr objectForKey:@"noticeOrgName"]];
            }
            if(nil==[arr objectForKey:@"publicUserName"]){
                name.text =@"";
            }else{
                name.text=[NSString stringWithFormat:@"%@",[arr objectForKey:@"publicUserName"]];
            }
            
            if(nil==[arr objectForKey:@"createDate"]){
                time.text =@"";
            }else{
                time.text=[NSString stringWithFormat:@"%@",[arr objectForKey:@"createDate"]];
            }
            
            [cell.contentView addSubview:school];
            [cell.contentView addSubview:time];
            [cell.contentView addSubview:name];
        }
        
    }
    

    
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
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
