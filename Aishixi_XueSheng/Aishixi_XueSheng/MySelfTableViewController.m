//
//  MySelfTableViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/22.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "MySelfTableViewController.h"

@interface MySelfTableViewController ()<UIActionSheetDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *type;
    NSMutableDictionary *buyaoFuyong;
   
    UIPickerView *mypicker;
    UIView *popview;
    float width,heigth;
    NSArray  *provines,*cities,*areas;//省 市 区
        
        
   
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
  
    _diqu.delegate = self;
    width = [[UIScreen mainScreen]bounds].size.width;
    heigth = [[UIScreen mainScreen]bounds].size.height;
    //self.view.backgroundColor = [UIColor orangeColor];
    
    //获取省
    provines = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist" ]];
    //获取市
    cities = [provines[0] objectForKey:@"cities"];
    //获取地区
    areas = [cities[0] objectForKey:@"areas"];
    
    
    
    
    //薪资
//   NSString *ss =@" 1000元以下 1000-2000元 2001-4000元 4001-6000元 6001-8000元 8001-10000元 10000元以上";
//    
//    //职位
//    NSString*sss =@"销售|客服|市场   财务|人力资源|行政  项目|质量|高级管理  IT|互联网|通信   房产|建筑|物业管理   金融   采购|贸易|交通|物流   生产|制造   传媒|印刷|艺术|设计    咨询|法律|教育|翻译   服务业     能源|环保|农业|科研   兼职|实习|社工|其他  ";
//    //行业
//    NSString *Ssss =@"IT|通信|电子|互联网   金融业  房地产|建筑业  商业服务  贸易|批发|零售|租赁业  文体教育|工艺美术  生产|加工|制造   交通|运输|物流|仓储    服务业     文化|传媒|娱乐|体育     能源|矿产|环保   政府|非盈利机构   农|林|牧|渔|其他  ";
   
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
    type =@"1";
    [_shi setImage:[UIImage imageNamed:@"是.png"] forState:UIControlStateNormal];
    [_fou setImage:[UIImage imageNamed:@"否.png"] forState:UIControlStateNormal];
  
    
}

- (IBAction)No:(id)sender {
    type =@"2";
    [_shi setImage:[UIImage imageNamed:@"否.png"] forState:UIControlStateNormal];
    [_fou setImage:[UIImage imageNamed:@"是.png"] forState:UIControlStateNormal];
    
}

//几个分组
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
//每个分组返回几行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        return [provines count];
    }else if (component==1) {
        return [cities count];
    }else {
        return [areas count];
    }
}

//每个分组的信息
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component==0) {
        return [provines[row]  objectForKey:@"state"];
    }
    else if (component==1)
        return [cities[row] objectForKey:@"city"];
    else
        return areas[row] ;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //弹出选择器
    
    if (popview ) {
        [popview  removeFromSuperview];
        popview=nil;
    }
    
    popview = nil;
    cities = nil;
    areas = nil;
    
    
    provines = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist" ]];
    //获取市
    cities = [provines[0] objectForKey:@"cities"];
    //获取地区
    areas = [cities[0] objectForKey:@"areas"];
    
    
    popview = [[UIView alloc]initWithFrame:CGRectMake(0, heigth, width, 260)];
    popview.backgroundColor = [UIColor  orangeColor];
    
    mypicker = [[UIPickerView  alloc]initWithFrame:CGRectMake(0, 60, width, 200)];
    mypicker.backgroundColor = [UIColor redColor];
    mypicker.dataSource = self;
    mypicker.delegate = self;
    [popview addSubview:mypicker];
    [self.view addSubview:popview];
    
    
    UIToolbar *tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, width, 60)];
    
    UIBarButtonItem *bb1 = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(queding)];
    
    UIBarButtonItem *fiex = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *bb2 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(quxiao)];
    
    NSArray *arr = [NSArray arrayWithObjects:bb1,fiex,bb2, nil];
    tool.items = arr;
    
    
    [popview addSubview:tool];
    
    
    [UIView animateWithDuration:0.3 animations:^ {
        popview.frame = CGRectMake(0, heigth-260, width, 260);
    }];
    
    return NO;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


-(void)queding {
    [popview  removeFromSuperview];
    
    NSDictionary *dic = provines[[mypicker selectedRowInComponent:0]];
    NSString *sheng =[dic objectForKey:@"state"];
    
    NSDictionary *dic1 =cities[[mypicker selectedRowInComponent:1]];
    
    int rorr = (int)[mypicker selectedRowInComponent:2];
    
    NSString *str = [NSString stringWithFormat:@"%@ %@ %@",sheng,[dic1 objectForKey:@"city"],([areas count]==0)?@"":areas[rorr]];
    _diqu.text =str;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component==0) {
        cities = [provines[row] objectForKey:@"cities"];
        [pickerView reloadComponent:1];
        areas = [cities[0] objectForKey:@"areas"];
        [pickerView reloadComponent:2];
        
        [pickerView selectRow:0 inComponent:1 animated:NO];
        
        if ([areas count]>0) {
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
        
    }
    
    else if (component==1) {
        
        areas = [cities[row] objectForKey:@"areas"];
        [pickerView reloadComponent:2];
        if ([areas count]>0) {
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
    }
    
    
}


-(void)quxiao {
    
    
    
    
}

@end
