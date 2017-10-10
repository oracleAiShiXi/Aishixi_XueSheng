//
//  MySelfTableViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/22.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "MySelfTableViewController.h"

@interface MySelfTableViewController ()<UIActionSheetDelegate>
{
    NSString *type;
    NSMutableDictionary *buyaoFuyong;
}
@end

@implementation MySelfTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    type=@"1";
    
     CGFloat imageWidth = _shi.imageView.bounds.size.width;
     CGFloat labelWidth = _shi.titleLabel.bounds.size.width;
     _shi.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
     _shi.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
     _fou.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
     _fou.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
  
    
    //薪资
   NSString *ss =@" 1000元以下 1000-2000元 2001-4000元 4001-6000元 6001-8000元 8001-10000元 10000元以上";
    
    //职位
    NSString*sss =@"销售|客服|市场   财务|人力资源|行政  项目|质量|高级管理  IT|互联网|通信   房产|建筑|物业管理   金融   采购|贸易|交通|物流   生产|制造   传媒|印刷|艺术|设计    咨询|法律|教育|翻译   服务业     能源|环保|农业|科研   兼职|实习|社工|其他  ";
    //行业
    NSString *Ssss =@"IT|通信|电子|互联网   金融业  房地产|建筑业  商业服务  贸易|批发|零售|租赁业  文体教育|工艺美术  生产|加工|制造   交通|运输|物流|仓储    服务业     文化|传媒|娱乐|体育     能源|矿产|环保   政府|非盈利机构   农|林|牧|渔|其他  ";
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark----薪资
-(NSArray*)Xinzi{
    NSArray*arr=[NSArray arrayWithObjects:@"1000元以下",@"1000-2000元",@"2001-4000元",@"4001-6000元",@"6001-8000元",@"8001-10000元",@"10000元以上", nil];
    return arr;
}
-(void)tan{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"薪资范围：" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"1000元以下",@"1000-2000元",@"2001-4000元",@"4001-6000元",@"6001-8000元",@"8001-10000元",@"10000元以上", nil];
    
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([actionSheet.title isEqualToString:@"薪资范围："]){
        NSArray *xinzi = [self Xinzi];
        _xinzi.text=[NSString stringWithFormat:@"%@",xinzi[buttonIndex]];
      NSString * chuannima=[NSString stringWithFormat:@"%ld",(long)buttonIndex+1];
        NSLog(@"%@",chuannima);
    }else if ([actionSheet.title isEqualToString:@"职位："]){
        NSArray *zhiwei = [self Zhiwei];
        _zhiwei.text=[NSString stringWithFormat:@"%@",zhiwei[buttonIndex]];
        NSString * chuannima=[NSString stringWithFormat:@"%ld",(long)buttonIndex+1];
        NSLog(@"%@",chuannima);
    }else{
        NSArray *hangye = [self Hangye];
        _hangye.text=[NSString stringWithFormat:@"%@",hangye[buttonIndex]];
        NSString * chuannima=[NSString stringWithFormat:@"%ld",(long)buttonIndex+1];
        NSLog(@"%@",chuannima);
    }
    
}


#pragma mark----职位


-(NSArray*)Zhiwei{
    NSArray*arr=[NSArray arrayWithObjects:@"销售|客服|市场",@"财务|人力资源|行政",@"项目|质量|高级管理",@"IT|互联网|通信",@"房产|建筑|物业管理",@"金融",@"采购|贸易|交通|物流",@"生产|制造",@"传媒|印刷|艺术|设计",@"咨询|法律|教育|翻译",@"服务业",@"能源|环保|农业|科研",@"兼职|实习|社工|其他", nil];
    return arr;
}
-(void)tan1{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"职位：" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"销售|客服|市场",@"财务|人力资源|行政",@"项目|质量|高级管理",@"IT|互联网|通信",@"房产|建筑|物业管理",@"金融",@"采购|贸易|交通|物流",@"生产|制造",@"传媒|印刷|艺术|设计",@"咨询|法律|教育|翻译",@"服务业",@"能源|环保|农业|科研",@"兼职|实习|社工|其他", nil];
    
    [sheet showInView:self.view];
}


#pragma mark-----行业

-(NSArray*)Hangye{
    NSArray*arr=[NSArray arrayWithObjects:@"IT|通信|电子|互联网",@"金融业",@"房地产|建筑业",@"商业服务",@"贸易|批发|零售|租赁业",@"文体教育|工艺美术",@"生产|加工|制造",@"交通|运输|物流|仓储",@"服务业",@"文化|传媒|娱乐|体育",@"能源|矿产|环保",@"政府|非盈利机构",@"农|林|牧|渔|其他", nil];
    return arr;
}
-(void)tan2{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"行业：" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"IT|通信|电子|互联网",@"金融业",@"房地产|建筑业",@"商业服务",@"贸易|批发|零售|租赁业",@"文体教育|工艺美术",@"生产|加工|制造",@"交通|运输|物流|仓储",@"服务业",@"文化|传媒|娱乐|体育",@"能源|矿产|环保",@"政府|非盈利机构",@"农|林|牧|渔|其他", nil];
    
    [sheet showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Yes:(id)sender {
//    type =@"1";
//    [_shi setImage:[UIImage imageNamed:@"是.png"] forState:UIControlStateNormal];
//    [_fou setImage:[UIImage imageNamed:@"否.png"] forState:UIControlStateNormal];
    [self tan1];
    
}

- (IBAction)No:(id)sender {
    type =@"2";
    [_shi setImage:[UIImage imageNamed:@"否.png"] forState:UIControlStateNormal];
    [_fou setImage:[UIImage imageNamed:@"是.png"] forState:UIControlStateNormal];
    
}
@end
