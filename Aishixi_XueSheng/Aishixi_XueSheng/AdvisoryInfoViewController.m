//
//  AdvisoryInfoViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "AdvisoryInfoViewController.h"
#import "XL_TouWenJian.h"
@interface AdvisoryInfoViewController ()
{

}
@end

@implementation AdvisoryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navagatio];
    [self jiekou];
    if([_status intValue]==1){
    
    }else{
        _img.hidden =YES;
        _viewss.hidden =YES;
        _reporttime.hidden =YES;
        _reportname.hidden =YES;
    
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)navagatio{
    self.title =@"咨询详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    //    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
    //    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
    //    self.navigationItem.leftBarButtonItem =left;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
}
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)jiekou{
    //写上个页面写传值

    NSString * Method = @"/consult/consulInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_ConsulId,@"consulId", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"13 学生咨询详情\n%@",responseObject);
        
        
        if ([[responseObject objectForKey:@"data"] objectForKey:@"createDate"]==NULL) {
            _zixuntime.text =@"";
        }else{
            _zixuntime.text =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"]  objectForKey:@"createDate"]];
        }
        if ([[responseObject objectForKey:@"data"]  objectForKey:@"consulUserName"]==NULL) {
            _consulname.text =@"";
        }else{
            _consulname.text =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"]  objectForKey:@"consulUserName"]];
        }
        if ([[responseObject objectForKey:@"data"]  objectForKey:@"consulContext"]==NULL) {
            _context.text =@"";
        }else{
            _context.text =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"]  objectForKey:@"consulContext"]];
        }
        
       
        
        if([[responseObject objectForKey:@"data"]  objectForKey:@"reportTime"]==NULL){
            _reporttime.text =@"";
        }else{
           _reporttime.text =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"]  objectForKey:@"reportTime"]];
        }
        if([[responseObject objectForKey:@"data"]  objectForKey:@"reportContent"]==NULL){
           _reportname.text =@"";
        }else{
           _reportname.text =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"]  objectForKey:@"reportUserName"]];
        }
        if([[responseObject objectForKey:@"data"]  objectForKey:@"reportContent"]==NULL){
            _reportcont.text =@"";
        }else{
          _reportcont.text =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"]  objectForKey:@"reportContent"]];
        }
       
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
