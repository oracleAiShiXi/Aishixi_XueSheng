//
//  MainViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/10/12.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "MainViewController.h"
#import "AttendanceViewController.h"
#import "NoticeViewController.h"
#import "AppraiseViewController.h"
#import "AdvisoryViewController.h"
#import "EditDiaryViewController.h"
#import "MySelfTableViewController.h"
#import "SetViewController.h"
#import "PhoneViewController.h"
#import "ImgInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "XL_TouWenJian.h"
#import "TextFlowView.h"
#import "NoticeInfoViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate,UIViewControllerPreviewingDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSMutableArray *notelist;//公告arr
    NSMutableArray *carolist;//轮播arr
    NSString *attendanceinfo;//考勤时间
    NSMutableArray*titles;//图片title
    NSMutableArray*imagesURLStrings;//图片路径
    CLLocationManager*_locationManager;
    NSString*jing;
    NSString*wei;
    NSString*address;
    NSString*content;//求助信息
     NSString *filepath;
    UIImagePickerController  *Imgpicker;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = false;
    _table.delegate =self;
    _table.dataSource =self;
    
   

    
    [self navagatio];
    
    [self initializeLocationService];
    [self jiekou];
   
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
 
}

-(void)navagatio{
    self.title =@"i实习";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
 
    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
    self.navigationItem.leftBarButtonItem =left;
    
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"通讯录.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Phonenum:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = right;

}

-(void)Home:(UIButton *)button{
    [self jiekou];
   
}


-(void)Phonenum:(UIButton *)button{
    PhoneViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"phone"];
    [self.navigationController pushViewController:his animated:YES];
}



-(void)jiekou{
    notelist =[[NSMutableArray alloc]init];
    carolist =[[NSMutableArray alloc]init];
    titles =[[NSMutableArray alloc]init];
    imagesURLStrings =[[NSMutableArray alloc]init];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/homePageStu/homePage";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId", nil];
    [WarningBox warningBoxModeIndeterminate:@"正在加载" andView:self.view];
    
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
        
        
        //NSLog(@"6、学生首页\n%@",responseObject);
        carolist =[[responseObject objectForKey:@"data"] objectForKey:@"carouselList"];
        notelist =[[responseObject objectForKey:@"data"] objectForKey:@"noticeList"];
        
        
        if(NULL==[[responseObject objectForKey:@"data"] objectForKey:@"attendanceInfo"]){
            attendanceinfo =@"暂无考勤信息";
        }else{
           attendanceinfo =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"attendanceInfo"]];
           // attendanceinfo =@"暂无考勤信息暂无考勤信息暂无考勤信息暂无考勤信息";
        }
        
        
        for (int i=0; i<carolist.count; i++) {
            [titles addObject:[carolist[i]objectForKey:@"title"]];
            NSString*ssss =[NSString stringWithFormat:@"%@%@%@",Scheme,QianWaiWangIP,[carolist[i]objectForKey:@"url"]];
            [imagesURLStrings addObject:ssss];
        }
            //NSLog(@"-----------------%@%@",titles,imagesURLStrings);
        
        [_table reloadData];
        
        
    }else{
        [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
        
    }
     
     
    } failure:^(NSError *error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
        //NSLog(@"%@",error);
    }];

}


-(void)SOSjiekou{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
   
    
    NSString * Method = @"/classManagement/sos/seekHelp";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",jing,@"longitude",wei,@"latitude",address,@"address",content,@"context", nil];
   // NSLog(@"-----%@",Rucan);
   //NSLog(@"%@",content);
    
    [WarningBox warningBoxModeIndeterminate:@"正在上报" andView:self.view];
 
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
        [WarningBox warningBoxModeText:@"求助成功" andView:self.view];
            [self sendsms];
       // NSLog(@"14 学生sos\n%@",responseObject);
            
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
            
    } failure:^(NSError *error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
       // NSLog(@"%@",error);
    }];


}
//摇一摇调用的紧急求助接口
-(void)SOSSSSjiekou{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
   
    
    NSString * Method = @"/classManagement/sos/seekHelp";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",jing,@"longitude",wei,@"latitude",address,@"address",content,@"context", nil];
    //NSLog(@"-----%@",Rucan);
   // NSLog(@"12312312312323");
    
    [WarningBox warningBoxModeIndeterminate:@"正在上报" andView:self.view];
    
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            
            //NSLog(@"14 学生sos\n%@",responseObject);
            
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
        
    } failure:^(NSError *error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
       // NSLog(@"%@",error);
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==3){
        return notelist.count;
    }else{

    return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 150;
    }else if (indexPath.section==1){
        return 40;
    }else if (indexPath.section==2){
        return 160;
    }else{
        return 70;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==3){
        return 10;
    }else{
        return 0;
    }
    
 }
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==1){
        return 5;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section==0){
      static NSString*cell1 =@"cell1";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        UIScrollView *scroll =(UIScrollView*)[cell viewWithTag:100];
        //UIPageControl*page =(UIPageControl*)[cell viewWithTag:101];
        scroll.contentSize =CGSizeMake(self.view.frame.size.width, 150);
        
        
        // 情景二：采用网络图片实现
//        NSArray *imagesURLStrings = @[
//                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                      ];
//        
//        // 情景三：图片配文字
//        NSArray *titles = @[@"新建交流QQ群：185534916 ",
//                            @"disableScrollGesture可以设置禁止拖动",
//                            @"感谢您的支持，如果下载的",
//                            @"如果代码在使用过程中出现问题",
//                            @"您可以发邮件到gsdios@126.com"
//                            ];
        
        
        // 网络加载 --- 创建带标题的图片轮播器
        
        CGFloat w = self.view.bounds.size.width;
        SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, w, 150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView2.titlesGroup = titles;
        cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [scroll addSubview:cycleScrollView2];
        
        //         --- 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
        });
        
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section==1){
        static NSString*cell1 =@"cell2";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        
        UIView *textvie =(UIView*)[cell viewWithTag:200];
       //考勤时间滚动 如果没有显示暂无考勤时间
        for (UIView *vv in cell.contentView.subviews) {//获取当前cell的全部子视图
            if (vv.tag==10000){
                [vv removeFromSuperview];
            }
        }
        TextFlowView *nameview =  [[TextFlowView alloc] initWithFrame:textvie.frame Text:attendanceinfo textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:15] backgroundColor:[UIColor clearColor] alignLeft:YES];
        nameview.tag =10000;
        
        [cell.contentView addSubview:nameview];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section==2){
        static NSString*cell1 =@"cell3";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        UIButton *attendance =(UIButton*)[cell viewWithTag:301];
        UIButton *notice =(UIButton*)[cell viewWithTag:302];
        UIButton *advisory =(UIButton*)[cell viewWithTag:303];
        UIButton *help =(UIButton*)[cell viewWithTag:304];
        UIButton *appraise =(UIButton*)[cell viewWithTag:305];
        UIButton *diary =(UIButton*)[cell viewWithTag:306];
        UIButton *myself =(UIButton*)[cell viewWithTag:307];
        UIButton *set =(UIButton*)[cell viewWithTag:308];
        
        
        UIView *view1 =(UIView*)[cell viewWithTag:1000];
        UIView *view2 =(UIView*)[cell viewWithTag:1001];
        UIView *view3 =(UIView*)[cell viewWithTag:1002];
        UIView *view4 =(UIView*)[cell viewWithTag:1003];
        UIView *view5 =(UIView*)[cell viewWithTag:1004];
        UIView *view6 =(UIView*)[cell viewWithTag:1005];
        UIView *view7 =(UIView*)[cell viewWithTag:1006];
        UIView *view8 =(UIView*)[cell viewWithTag:1007];
        
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(-(((kWidth-200)/5)+((kWidth-200)/5)/2+75));
        }];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(-(((kWidth-200)/5)/2+25));
        }];
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerX.mas_equalTo(((kWidth-200)/5)/2+25);
        }];
        [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerX.mas_equalTo(((kWidth-200)/5)+((kWidth-200)/5)/2+75);
        }];
        [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(-(((kWidth-200)/5)+((kWidth-200)/5)/2+75));
        }];
        [view6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(-(((kWidth-200)/5)/2+25));
        }];
        [view7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(((kWidth-200)/5)/2+25);
        }];
        [view8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(((kWidth-200)/5)+((kWidth-200)/5)/2+75);
        }];
        
        
        [attendance addTarget:self action:@selector(Attendance:) forControlEvents:UIControlEventTouchUpInside];
        [notice addTarget:self action:@selector(Notice:) forControlEvents:UIControlEventTouchUpInside];
        [advisory addTarget:self action:@selector(Advisory:) forControlEvents:UIControlEventTouchUpInside];
        [help addTarget:self action:@selector(Help:) forControlEvents:UIControlEventTouchUpInside];
        [appraise addTarget:self action:@selector(Appraise:) forControlEvents:UIControlEventTouchUpInside];
        [diary addTarget:self action:@selector(Diary:) forControlEvents:UIControlEventTouchUpInside];
        [myself addTarget:self action:@selector(Myself:) forControlEvents:UIControlEventTouchUpInside];
        [set addTarget:self action:@selector(Set:) forControlEvents:UIControlEventTouchUpInside];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        static NSString*cell1 =@"cell4";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        //UIView *view =(UIView*)[cell viewWithTag:405];
        UILabel*title =(UILabel*)[cell viewWithTag:400];
        UILabel*time =(UILabel*)[cell viewWithTag:401];
        UIImageView*img1= (UIImageView*)[cell viewWithTag:402];
        UIImageView*img2= (UIImageView*)[cell viewWithTag:403];
        
        if(NULL==[notelist[indexPath.row] objectForKey:@"noticeTitle"]){
         title.text =@"";
        }else{
            title.text =[NSString stringWithFormat:@"%@",[notelist[indexPath.row] objectForKey:@"noticeTitle"]];
        }
        if(NULL==[notelist[indexPath.row] objectForKey:@"createDate"]){
            time.text =@"";
        }else{
            time.text =[NSString stringWithFormat:@"%@",[notelist[indexPath.row] objectForKey:@"createDate"]];
        }
        if([[notelist[indexPath.row] objectForKey:@"isRead"] intValue]==1){
            img1.image =[UIImage imageNamed:@"important.png"];
            img2.image =[UIImage imageNamed:@""];
        }else{
            img1.image =[UIImage imageNamed:@"important.png"];
            img2.image =[UIImage imageNamed:@"weidu.png"];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =[UIColor clearColor];
        return cell;
    }
  
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"3213123123");
    if(indexPath.section==3){
        NoticeInfoViewController *info = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"noticeinfo"];
        
        info.NoticeId =[NSString stringWithFormat:@"%@",[notelist[indexPath.row] objectForKey:@"noticeId"]];
        
        [self.navigationController pushViewController:info animated:YES];
    
    }
    

    
}



- (void)Attendance:(UIButton*)sender {
//    AttendanceViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Attendance"];
//    his.jingdu =jing;
//    his.weidu =wei;
//    his.dizhi =address;
//    [self.navigationController pushViewController:his animated:YES];
    [self phone];
}

- (void)Notice:(UIButton*)sender {
    NoticeViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"notice"];
    [self.navigationController pushViewController:his animated:YES];
    
}

- (void)Advisory:(UIButton*)sender {
    AdvisoryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Advisory"];
    [self.navigationController pushViewController:his animated:YES];
    
}

- (void)Help:(UIButton*)sender {
    
    
    [self SOSjiekou];
    
    
    
}

- (void)Appraise:(UIButton*)sender {
   
    [self tan];
}


-(void)tan{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择被评价类型" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"评价企业" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
   
        AppraiseViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Appraise"];
        his.EvaluatEdType =@"1";
        [self.navigationController pushViewController:his animated:YES];
        
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"评价教师" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        AppraiseViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Appraise"];
        his.EvaluatEdType =@"2";
        [self.navigationController pushViewController:his animated:YES];
        
    }]];
    [self.view endEditing:YES];
    // 由于它是一个控制器 直接modal出来就好了
    [self presentViewController:alertController animated:YES completion:nil];

}


- (void)Diary:(UIButton*)sender {
    EditDiaryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EditDiary"];
    [self.navigationController pushViewController:his animated:YES];
}

- (void)Myself:(UIButton*)sender {
    MySelfTableViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MySelf"];
    [self.navigationController pushViewController:his animated:YES];
}

- (void)Set:(UIButton*)sender {
    SetViewController  *set = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Set"];
    [self.navigationController pushViewController:set animated:YES];
}
#pragma mark - CLLocationManagerDelegate methods 定位
//
- (void)initializeLocationService {
    
    if([CLLocationManager locationServicesEnabled]){
       
    }
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    _locationManager.delegate = self;
    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
    [_locationManager requestAlwaysAuthorization];//这句话ios8以上版本使用。
    [_locationManager requestWhenInUseAuthorization];
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = 5.0;
    // 开始定位
    // 取得定位权限，有两个方法，取决于你的定位使用情况
    
    [_locationManager startUpdatingLocation];
 
}
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //将经度显示到label上
    jing = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //将纬度现实到label上
    wei = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        
       
        if (array.count > 0){
            
            CLPlacemark *placemark = [array objectAtIndex:0];
           // NSLog(@"%@",placemark);
            
            address=[placemark.addressDictionary objectForKey:@"FormattedAddressLines"][0];
            
            NSUserDefaults*defaults =[NSUserDefaults standardUserDefaults];
            content=[NSString stringWithFormat:@"我是%@,我在%@遇到问题,请速与我联系! 经度:%@,纬度:%@, 电话:%@",[defaults objectForKey:@"nick"],address,jing,wei,[defaults objectForKey:@"tel"]];
           // NSLog(@"--------%@",content);
            
       
        }
        else if (error == nil && [array count] == 0)
        {
        }
        else if (error != nil)
        {
        }
            
            
    
    }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    //  panduan=0;
    
    
    [manager stopUpdatingLocation];
  
}
//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
    NSUserDefaults*defaults =[NSUserDefaults standardUserDefaults];
   content=[NSString stringWithFormat:@"我是%@,遇到问题,请速与我联系! 电话:%@",[defaults objectForKey:@"nick"],[defaults objectForKey:@"tel"]];
   // NSLog(@"%@",content);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}





#pragma mark---摇一摇
//-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>) viewControllerForLocation:(CGPoint)location{
//   
//}
//-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
//    NSLog(@"哈哈哈哈");
//}
#pragma mark - 开始摇晃就会调用
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
   
   
    
}

#pragma mark - 摇晃结束就会调用
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //摇晃结束
    [self SOSSSSjiekou];
}

#pragma mark - 摇晃被打断就会调用
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇晃被打断
}




#pragma mark----发送短信
-(void)sendsms{
    if( [MFMessageComposeViewController canSendText] )// 判断设备能不能发送短信
    {
        MFMessageComposeViewController*picker = [[MFMessageComposeViewController alloc] init];
        // 设置委托
        picker.messageComposeDelegate= self;
     
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
        
        
        picker.body = content;
        // 默认收件人(可多个)
        NSString *Ss = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"teacherTel"]];
        
        picker.recipients = [NSArray arrayWithObject:Ss];
        
        
        [self presentViewController:picker animated:YES completion:^{}];
        
    }else{
        [WarningBox warningBoxModeText:@" 该设备不能发送应用内SMS消息，请升级设备" andView:self.view];
        //NSLog(@"不支持");
    }
}

#pragma mark MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result){
        case MessageComposeResultCancelled:
            // NSLog(@"取消发送");
            break;
        case MessageComposeResultFailed:
            
            // NSLog(@"发送失败");
            break;
        case MessageComposeResultSent:
            //  NSLog(@"发送成功");
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark--------签到方法

-(void)qiandao{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/homePageStu/attendance";
    
    
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",jing,@"longitude",wei,@"latitude",address,@"address",nil];

    NSLog(@"%@",Rucan);
    //UIImage *image = [UIImage imageNamed:@"对号2"];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:filepath];
   // NSLog(@"%@",image);
    NSArray * arr = [NSArray arrayWithObjects:image, nil];
    
    [WarningBox warningBoxModeIndeterminate:@"正在签到" andView:self.view];
    
    [XL_WangLuo ShangChuanTuPianwithBizMethod:Method Rucan:Rucan type:Post image:arr key:@"url" success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
             [WarningBox warningBoxModeText:@"考勤成功" andView:self.view];
          // NSLog(@"8 学生考勤\n%@",responseObject);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
        
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        
       // NSLog(@"%@",error);
    }];

}


//相机
-(void)phone {
    
    //打开相机
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }else
    {
        
        
        Imgpicker = [[UIImagePickerController alloc] init];
        Imgpicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//相册
        
        Imgpicker.delegate = self;
        //设置选择后的图片可被编辑
        Imgpicker.allowsEditing = YES;
        
        [self presentViewController:Imgpicker animated:YES completion:nil];
        
        
    }
    
    
}

#pragma mark  相机相册

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //self.image.image = image;
    NSData  *imgdata = UIImageJPEGRepresentation(image, 0.1);
    
    //图片保存的路径
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //这里将图片放在沙盒的documents下的Image文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    
    
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //图片名以时间戳的格式存储到目录下
    filepath=[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/currentImage.png"]];
    
    
    
    
    [fileManager createFileAtPath:filepath contents:imgdata attributes:nil];
    
  
    
    // NSLog(@"%@",NSHomeDirectory());
    
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self qiandao];
    
    
}
//取消选择图片
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark - SDCycleScrollViewDelegate轮播点击方法

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    ImgInfoViewController  *imginfo = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Imginfo"];
    imginfo.CarouselId =[NSString stringWithFormat:@"%@",[carolist[index] objectForKey:@"id"]];
    
    [self.navigationController pushViewController:imginfo animated:YES];
    
    //NSLog(@"---点击了第%ld张图片", (long)index);
    
    
}


@end
