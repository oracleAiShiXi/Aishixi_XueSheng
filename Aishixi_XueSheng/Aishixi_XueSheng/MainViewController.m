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
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "XL_TouWenJian.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = false;
    _table.delegate =self;
    _table.dataSource =self;
    
    

    
    [self navagatio];
    [self jiekou];
    
    
    // Do any additional setup after loading the view.
}
-(void)navagatio{
    self.title =@"爱实习";
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
   
}


-(void)Phonenum:(UIButton *)button{
    PhoneViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"phone"];
    [self.navigationController pushViewController:his animated:YES];
}



-(void)jiekou{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/homePageStu/homePage";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"6、学生首页\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
#pragma mark---轮播详情接口页面没有
-(void)jiekou6{
    NSString * Method = @"/homePageStu/carouselInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"carouselId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"7、轮播详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)SOSjiekou{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString * Method = @"/classManagement/sos/seekHelp";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",@"123°43′45",@"longitude",@"45°03′38",@"latitude",@"哈尔滨工业大学",@"address",@"哈哈哈哈",@"context", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"14 学生sos\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
        return 5;
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
        NSArray *imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];
        
        // 情景三：图片配文字
        NSArray *titles = @[@"新建交流QQ群：185534916 ",
                            @"disableScrollGesture可以设置禁止拖动",
                            @"感谢您的支持，如果下载的",
                            @"如果代码在使用过程中出现问题",
                            @"您可以发邮件到gsdios@126.com"
                            ];
        
        
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
        
        
        
        
        
        return cell;
    }else if (indexPath.section==1){
        static NSString*cell1 =@"cell2";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        UIView *textvie =(UIView*)[cell viewWithTag:200];
        
        
        return cell;
    }else if (indexPath.section==2){
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
        
        [attendance addTarget:self action:@selector(Attendance:) forControlEvents:UIControlEventTouchUpInside];
        [notice addTarget:self action:@selector(Notice:) forControlEvents:UIControlEventTouchUpInside];
        [advisory addTarget:self action:@selector(Advisory:) forControlEvents:UIControlEventTouchUpInside];
        [help addTarget:self action:@selector(Help:) forControlEvents:UIControlEventTouchUpInside];
        [appraise addTarget:self action:@selector(Appraise:) forControlEvents:UIControlEventTouchUpInside];
        [diary addTarget:self action:@selector(Diary:) forControlEvents:UIControlEventTouchUpInside];
        [myself addTarget:self action:@selector(Myself:) forControlEvents:UIControlEventTouchUpInside];
        [set addTarget:self action:@selector(Set:) forControlEvents:UIControlEventTouchUpInside];
       
        return cell;
    }else{
        static NSString*cell1 =@"cell4";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        UIView *view =(UIView*)[cell viewWithTag:405];
        UILabel*title =(UILabel*)[cell viewWithTag:400];
        UILabel*time =(UILabel*)[cell viewWithTag:401];
        UIImageView*img1= (UIImageView*)[cell viewWithTag:402];
        UIImageView*img2= (UIImageView*)[cell viewWithTag:403];
        
        
        cell.backgroundColor =[UIColor clearColor];
        return cell;
    }
  
}

- (void)Attendance:(UIButton*)sender {
    AttendanceViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Attendance"];
    [self.navigationController pushViewController:his animated:YES];
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
    
    
    
    
    
    
}

- (void)Appraise:(UIButton*)sender {
    AppraiseViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Appraise"];
    [self.navigationController pushViewController:his animated:YES];
    
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

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    
}


@end