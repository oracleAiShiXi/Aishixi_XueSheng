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
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = false;
    _table.delegate =self;
    _table.dataSource =self;
    // Do any additional setup after loading the view.
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

    return 1;
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section==0){
      static NSString*cell1 =@"cell1";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        UIScrollView *scroll =(UIScrollView*)[cell viewWithTag:100];
        UIPageControl*page =(UIPageControl*)[cell viewWithTag:101];
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




@end
