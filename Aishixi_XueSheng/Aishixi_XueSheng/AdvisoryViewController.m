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
#import "XL_TouWenJian.h"
@interface AdvisoryViewController ()
{
    float width;
    float height;
    NSMutableArray *arr;
    int  pageNo,pageSize,count;
}
@end

@implementation AdvisoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self delegate];
    self.title =@"咨询";
    //[self comeback];
    [self navagat];
    
    
    count = 0;
    pageSize = 5;
    pageNo = 1;
    arr =[NSMutableArray array];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self jiekou];
    
    // Do any additional setup after loading the view.
}
-(void)loadNewData{
    arr =[NSMutableArray array];
    [_tableview reloadData];
    pageNo = 1;
    [self jiekou];
    [_tableview.mj_header endRefreshing];
    self.tableview.mj_footer.hidden = NO;
}
-(void)loadMoreData{
    if (pageNo * pageSize >= count) {
        self.tableview.mj_footer.hidden = YES;
    }else{
        pageNo += 1;
        [self jiekou];
        [_tableview.mj_footer endRefreshing];
    }
}

-(void)navagat{
    self.title =@"咨询";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    //    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
    //    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
    //    self.navigationItem.leftBarButtonItem =left;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"写消息" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
    [self.navigationItem setRightBarButtonItem:right];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)History{
    EditAdvisoryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EditAdvisory"];
    [self.navigationController pushViewController:his animated:YES];
    
}
-(void)jiekou{
     NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/consult/consulList";
    
    
    NSString *_pageSize = [NSString stringWithFormat:@"%d",pageSize];
    
    NSString *_pageNo = [NSString stringWithFormat:@"%d",pageNo];
    
    NSLog(@"%@-----%@",_pageNo,_pageSize);
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",_pageNo,@"pageNo",_pageSize,@"pageSize", nil];
    
    [WarningBox warningBoxModeIndeterminate:@"正在加载" andView:self.view];
    
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
        
        NSLog(@"12 学生咨询列表\n%@",responseObject);
       // arr =[NSMutableArray array];
        //arr=[[responseObject objectForKey:@"data"] objectForKey:@"consulList"];
        
            [arr addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"consulList"]];
            
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
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UILabel *concent =(UILabel*)[cell viewWithTag:102];
    UILabel *time =(UILabel*)[cell viewWithTag:103];
    UILabel *type =(UILabel*)[cell viewWithTag:104];
    
    
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//    rotation.m34 = 1.0/ -600;
//    
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
   
        
        if(NULL==[arr[indexPath.section]objectForKey:@"consulTitle"]||[arr[indexPath.section]objectForKey:@"consulTitle"]==nil){
            concent.text=@"";
        }else{
            concent.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"consulTitle"]];
            
        }
   
    
    
    if(NULL==[arr[indexPath.section]objectForKey:@"createDate"]){
        time.text=@"";
    }else{
        time.text =[NSString stringWithFormat:@"%@",[arr[indexPath.section]objectForKey:@"createDate"]];
        
    }
    if([[arr[indexPath.section]objectForKey:@"status"] intValue]==1){
        type.text=@"已回复";
        type.textColor =[UIColor colorWithHexString:@"8A5BF7"];
    }else{
        type.text=@"未回复";
        type.textColor =[UIColor colorWithHexString:@"EF00FF"];
        
    }
    
    
    
    
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
    his.ConsulId =[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"consulId"]];
    his.status =[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"status"]];
    [self.navigationController pushViewController:his animated:YES];
    
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (arr.count>0) {
//        //设置x和y的初始值为0.1；
//        //cell.alpha=0.5;
//        cell.layer.transform = CATransform3DMakeScale(0.97, 0.97, 1);
//        //x和y的最终值为1
//        [UIView animateWithDuration:1 animations:^{
//            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//            //cell.alpha=1;
//        }];
//    }
//}


//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section % 2 != 0) {
//        cell.transform = CGAffineTransformTranslate(cell.transform, width/2, 0);
//        
//    }else{
//        cell.transform = CGAffineTransformTranslate(cell.transform, -width/2, 0);
//    }
//    cell.alpha = 0.0;
//    
//    [UIView animateWithDuration:0.7 animations:^{
//        
//        cell.transform = CGAffineTransformIdentity;
//        
//        cell.alpha = 1.0;
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//}
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (20.0*M_PI)/180, 0.0, 0.7, 0.4);
//    rotation.m34 = 1.0/ -600;
//    
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.2];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat rotationAngleDegrees = 0;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(-200, -20);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
    
    
    UIView *card = [cell contentView];
    card.layer.transform = transform;
    card.layer.opacity = 0.8;
    
    
    
    [UIView animateWithDuration:1.0f animations:^{
        card.layer.transform = CATransform3DIdentity;
        card.layer.opacity = 1;
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
