//
//  NoticeInfoViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "NoticeInfoViewController.h"
#import "Color+Hex.h"
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
    //[self wangluo];
    //[self comeback];
    self.title =@"公告详情";
    
   
    // Do any additional setup after loading the view.
}
-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
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
//        if(nil==[arr objectForKey:@"title"]){
//            s =@"";
//        }else{
//            s =[NSString stringWithFormat:@"%@",[arr objectForKey:@"title"]];
//        }
        s =[NSString stringWithFormat:@"新学期暑期实习公告暑期实习公告暑期实习公告暑期实习公告暑期实习公告"];
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
//        if(nil==[arr objectForKey:@"context"]){
//            ss =@"";
//        }else{
//            ss =[NSString stringWithFormat:@"%@",[arr objectForKey:@"context"]];
//        }
        ss =[NSString stringWithFormat:@"新浪科技讯 北京时间9月19日早间消息，凯基证券本周发布了关于iPhone 8和Apple Watch Series 3预订情况的报告。这两款产品从上周末开始启动预售。凯基证券认为，iPhone X或许影响了iPhone 8的预订销量，而Apple Watch Series 3的需求则强于预期。在这份报告中，凯基证券指出，新推出的iPhone通常会在开放预订的3到6周后发货，但大部分iPhone 8将在不到1到2周，甚至更短时间内发货。原因是什么？全新设计的iPhone X将于11月份开售，预订将会从10月底开始。此前，Lup Ventures分析师吉恩·蒙斯特（Gene Munster）收集了苹果官方网站上各款iPhone 8的配置和发货时间数据。他发现，iPhone 8的发售有些不同于以往。可以看到，即使已经开放预订几天，几款iPhone 8仍然会在开售当天发货，而无需等待。"];
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
        return 80;
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
            UILabel *time= [[UILabel alloc]initWithFrame:CGRectMake(width-250, 40,230, 20)];
            time.textColor =[UIColor colorWithHexString:@"fd8f30"];
            time.font= [UIFont systemFontOfSize:14];
            time.textAlignment = NSTextAlignmentRight;
            
            UILabel *school= [[UILabel alloc]initWithFrame:CGRectMake(width-250, 10,230, 20)];
            school.textColor =[UIColor colorWithHexString:@"fd8f30"];
            school.font= [UIFont systemFontOfSize:14];
            school.textAlignment = NSTextAlignmentRight;
            
//            if(nil==[arr objectForKey:@"pushTime"]){
//                time.text =@"";
//            }else{
//                NSString *ss =[NSString stringWithFormat:@"时间:%@",[arr objectForKey:@"pushTime"]];
//                //NSString *sss = [ss substringToIndex:10];
//                time.text =ss;
//            }
            school.text =@"黑龙江八一农垦大学";
            time.text =@"2017.06.21 17:54:20";
            
            [cell.contentView addSubview:school];
            [cell.contentView addSubview:time];
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
