//
//  DiaryInfoViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "DiaryInfoViewController.h"
#import "XL_TouWenJian.h"
#import "EBImageBrowser.h"
@interface DiaryInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *arr;
    UILabel *titles;
     float width;
}
@end

@implementation DiaryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navagatio];
    [self delegate];
    [self jiekou];
    _table.showsHorizontalScrollIndicator= NO;
    _table.showsVerticalScrollIndicator =NO;
     width =[UIScreen mainScreen].bounds.size.width;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)navagatio{
    self.title =@"日记详情";
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
    
    NSString * Method = @"/diary/internshipInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_InternshipId,@"internshipId",nil];
    
     [WarningBox warningBoxModeIndeterminate:@"正在加载" andView:self.view];
    
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
        
       // NSLog(@"17 学生日记详情\n%@",responseObject);
        arr =[[NSDictionary alloc]init];
        arr =[responseObject objectForKey:@"data"];
        [_table reloadData];
        
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
        
    } failure:^(NSError *error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
        //NSLog(@"%@",error);
    }];

}

-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor =[UIColor clearColor];
    self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 50;
    }else if (indexPath.section==1){
        NSString* ss=[[NSString alloc] init];
        if(nil==[arr objectForKey:@"content"]){
            ss =@"";
        }else{
            ss =[NSString stringWithFormat:@"%@",[arr objectForKey:@"content"]];
        }
        titles=[[UILabel alloc] init];
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-40, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        
        titles.text=ss;
        [titles setFrame:CGRectMake(20,10, rect.size.width, rect.size.height)];
        
        return titles.frame.size.height+15>40? titles.frame.size.height+55:40;
    }
    else if (indexPath.section==2){
        return 50;
    }
    else{
        if(![[arr objectForKey:@"quesionImg1"]isEqualToString:@""]){
            return 155;
        }else if(![[arr objectForKey:@"quesionImg2"]isEqualToString:@""]){
            return 155;
        }else if(![[arr objectForKey:@"quesionImg3"]isEqualToString:@""]){
            return 155;
        }else{
            return 0;
        }
        
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"rell";
    UITableViewCell *cell=[self.table cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
        for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
            [suView removeFromSuperview];//移除全部子视图
        }
    if(indexPath.section==0){
        UILabel *xixi =[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 30)];
        xixi.text =@"日记内容:";
        [cell.contentView addSubview:xixi];
    }
    else if(indexPath.section==1){
        titles.numberOfLines =0;
        titles.font =[UIFont fontWithName:@"Arial" size:15];
        [cell.contentView addSubview:titles];
    }
    else if (indexPath.section==2){
        UILabel *time =[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 290, 30)];
        
        if(NULL==[arr objectForKey:@"cretateTime"]){
        time.text =@"";
        }else{
        time.text =[NSString stringWithFormat:@"发布时间:%@",[arr objectForKey:@"cretateTime"]];
        }
        
        
        [cell.contentView addSubview:time];
    }
    else if (indexPath.section==3){
        if(![[arr objectForKey:@"url1"]isEqualToString:@""]){
            UIImageView *image =[[UIImageView alloc]init];
            image.frame = CGRectMake(0,0,width-20,150);
            //image.contentMode = UIViewContentModeScaleAspectFill;
            // image.contentMode = UIViewContentModeScaleAspectFit;
            image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
            [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
            NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,QianWaiWangIP,[arr objectForKey:@"url1"]];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //NSLog(@"%@",url);
            [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            //为UIImageView1添加点击事件
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
            [image addGestureRecognizer:tapGestureRecognizer1];
            //让UIImageView和它的父类开启用户交互属性
            NSString *ss=[NSString stringWithFormat:@"%@%@(null)",Scheme,QianWaiWangIP];
            if([url isEqual:ss]){
                [image setUserInteractionEnabled:NO];
            }else{
                [image setUserInteractionEnabled:YES];
            }
            
            
            
            [cell.contentView addSubview:image];
        }
    }
    else if (indexPath.section==4){
        if(![[arr objectForKey:@"url2"]isEqualToString:@""]){
            UIImageView *image =[[UIImageView alloc]init];
            image.frame = CGRectMake(0,0,width-20,150);
            //image.contentMode = UIViewContentModeScaleAspectFill;
            //image.contentMode = UIViewContentModeScaleAspectFit;
            image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
            [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
            NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,QianWaiWangIP,[arr objectForKey:@"url2"]];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
            [image addGestureRecognizer:tapGestureRecognizer1];
            //让UIImageView和它的父类开启用户交互属性
            NSString *ss=[NSString stringWithFormat:@"%@%@(null)",Scheme,QianWaiWangIP];
            if([url isEqual:ss]){
                [image setUserInteractionEnabled:NO];
            }else{
                [image setUserInteractionEnabled:YES];
            }
            [cell.contentView addSubview:image];
        }
    }
    else{
        if(![[arr objectForKey:@"url3"]isEqualToString:@""]){
            UIImageView *image =[[UIImageView alloc]init];
            image.frame = CGRectMake(0,0,width-20,150);
            //image.contentMode = UIViewContentModeScaleAspectFill;
            //image.contentMode = UIViewContentModeScaleAspectFit;
            image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
            [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
            NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,QianWaiWangIP,[arr objectForKey:@"url3"]];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
            [image addGestureRecognizer:tapGestureRecognizer1];
            //让UIImageView和它的父类开启用户交互属性
            NSString *ss=[NSString stringWithFormat:@"%@%@(null)",Scheme,QianWaiWangIP];
            if([url isEqual:ss]){
                [image setUserInteractionEnabled:NO];
            }else{
                [image setUserInteractionEnabled:YES];
            }
            [cell.contentView addSubview:image];
        }
    }
    
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)scanBigImageClick1:(UITapGestureRecognizer *)tap{
    
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    //    [XWScanImage scanBigImageWithImageView:clickedImageView];
    [EBImageBrowser showImage:clickedImageView];
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
