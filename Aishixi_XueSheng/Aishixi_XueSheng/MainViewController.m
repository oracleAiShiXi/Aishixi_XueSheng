//
//  MainViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/10/12.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "MainViewController.h"

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
        return cell;
    }else if (indexPath.section==1){
        static NSString*cell1 =@"cell2";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        return cell;
    }else if (indexPath.section==2){
        static NSString*cell1 =@"cell3";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        return cell;
    }else{
        static NSString*cell1 =@"cell4";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cell1];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        cell.backgroundColor =[UIColor clearColor];
        return cell;
    }
    
    
    
    
}


@end
