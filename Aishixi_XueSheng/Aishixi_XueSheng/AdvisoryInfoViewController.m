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

@end

@implementation AdvisoryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"咨询详情";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)jiekou{
    //写上个页面写传值

    NSString * Method = @"/consult/consulInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"consulId", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"13 学生咨询详情\n%@",responseObject);
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
