//
//  ImgInfoViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/10/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "ImgInfoViewController.h"
#import "XL_TouWenJian.h"
@interface ImgInfoViewController ()<UIWebViewDelegate>

@end

@implementation ImgInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navagatio];
    [self webviews];
    //[self jiekou6];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)navagatio{
    self.title =@"详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
//    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
//    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
//    self.navigationItem.leftBarButtonItem =left;
    
    
    
}


#pragma mark---轮播详情接口页面没有
-(void)jiekou6{
    NSString * Method = @"/homePageStu/carouselInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_CarouselId,@"carouselId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"7、轮播详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)webviews{
    _webview.delegate=self;
    [_webview setOpaque:YES];//opaque是不透明的意思
    [_webview setScalesPageToFit:YES];//自动缩放以适应屏幕
    self.webview.backgroundColor = [UIColor clearColor];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'"];//修改百分比即可
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=self.view.frame.size.width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\""];
    [webView stringByEvaluatingJavaScriptFromString:meta];//(initial-scale是初始缩放比,minimum-scale=1.0最小缩放比,maximum-scale=5.0最大缩放比,user-scalable=yes是否支持缩放)
    
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
