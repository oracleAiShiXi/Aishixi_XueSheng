//
//  MySelfTableViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/22.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "MySelfTableViewController.h"
#import "ActionSheetCustomPicker.h"
#import "MJExtension.h"
#import "XL_TouWenJian.h"
@interface MySelfTableViewController ()<UIActionSheetDelegate,UITextFieldDelegate,ActionSheetCustomPickerDelegate>
{
    NSString *type;
    NSMutableDictionary *buyaoFuyong;
   
//    UIPickerView *mypicker;
//    UIView *popview;
//    float width,heigth;
//    NSArray  *provines,*cities,*areas;//省 市 区
    int a;
        
   
}
@property (nonatomic,strong) NSArray *addressArr; // 解析出来的最外层数组
@property (nonatomic,strong) NSArray *provinceArr; // 省
@property (nonatomic,strong) NSArray *countryArr; // 市
@property (nonatomic,strong) NSArray *districtArr; // 区
@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (nonatomic,strong) ActionSheetCustomPicker *picker; // 选择器


@end

@implementation MySelfTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
     CGFloat imageWidth = _shi.imageView.bounds.size.width;
     CGFloat labelWidth = _shi.titleLabel.bounds.size.width;
     _shi.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
     _shi.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
     _fou.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
     _fou.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
  
   
    _phone.delegate = self;
    _qq.delegate = self;
    _weixin.delegate = self;
    _xinzi.delegate = self;
    _hangye.delegate = self;
    _mingcheng.delegate = self;
    _dianhua.delegate = self;
    _zhiwei.delegate = self;
    _diqu.delegate = self;
    _dizhi.delegate = self;
    _xingming.delegate = self;
    _lxdianhua.delegate = self;
    _lxdiqu.delegate = self;
    _lxdizhi.delegate = self;
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    if (self.pushAddress) {
        _diqu.text = self.pushAddress;
    }
    if (self.selections.count) {
        self.index1 = [self.selections[0] integerValue];
        self.index2 = [self.selections[1] integerValue];
        self.index3 = [self.selections[2] integerValue];
    }
    // 一定要先加载出这三个数组，不然就蹦了
    [self calculateFirstData];

  
}

-(void)navagatio{
    self.title =@"个人信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"通讯录.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Saves) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = right;
    
    
    
}


-(void)Saves{
    NSLog(@"baocun");
}
-(void)gerenxinxi{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/attend/getUserInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"18 学生个人信息查询\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    //根据返回确定是否在岗
//    [_shi setImage:[UIImage imageNamed:@"是.png"] forState:UIControlStateNormal];
//    [_fou setImage:[UIImage imageNamed:@"否.png"] forState:UIControlStateNormal];
    
}

-(void)xiugaixinxi{
  
    //所在职位ID
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/attend/userInfoSet";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",_phone.text,@"mobilePhone",_qq.text,@"qqCode",_weixin.text,@"wxCode",type,@"isInPost",_xinzi.text,@"money",_hangye.text,@"companyIndustry",_mingcheng.text,@"companyName",_dianhua.text,@"companyTelephone",@"1",@"postId",_zhiwei.text,@"postName",_diqu.text,@"location",_dizhi.text,@"address",_xingming.text,@"urgentName",_lxdianhua.text,@"urgentTel",_lxdiqu.text,@"locationAll",_lxdizhi.text,@"addressAll",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"19 学生个人信息保存\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
        if(buttonIndex<7){
        NSArray *xinzi = [self Xinzi];
        _xinzi.text=[NSString stringWithFormat:@"%@",xinzi[buttonIndex]];
      NSString * chuannima=[NSString stringWithFormat:@"%ld",(long)buttonIndex+1];
        NSLog(@"%@",chuannima);
        }
    }else if ([actionSheet.title isEqualToString:@"职位："]){
        if(buttonIndex<13){
        NSArray *zhiwei = [self Zhiwei];
        _zhiwei.text=[NSString stringWithFormat:@"%@",zhiwei[buttonIndex]];
        NSString * chuannima=[NSString stringWithFormat:@"%ld",(long)buttonIndex+1];
        NSLog(@"%@",chuannima);
        }
    }else{
        if(buttonIndex<13){
        NSArray *hangye = [self Hangye];
        _hangye.text=[NSString stringWithFormat:@"%@",hangye[buttonIndex]];
        NSString * chuannima=[NSString stringWithFormat:@"%ld",(long)buttonIndex+1];
        NSLog(@"%@",chuannima);
        }
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


#pragma mark-----textfield

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==_xinzi){
        
        [self tan];
        return NO;
    }else if (textField==_hangye){
        [self tan2];
        return NO;
    }else if (textField==_zhiwei){
        [self tan1];
        return NO;
    }else if (textField==_diqu){
        a=1;
        [self addresssss];
        return NO;
    }else if (textField==_lxdiqu){
        a=2;
        [self addresssss];
        return NO;
    }else{
    
        return YES;
    }
    
    
    
   
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    
        if(textField==_phone){
            [_qq becomeFirstResponder];
        }else if (textField==_qq){
            [_weixin becomeFirstResponder];
        }else if (textField==_weixin){
            [_xinzi becomeFirstResponder];
            //[self tan];
        }else if (textField==_xinzi){
            [_hangye becomeFirstResponder];
            //[self tan2];
        }else if (textField==_hangye){
            [_mingcheng becomeFirstResponder];
        }else if (textField==_mingcheng){
            [_dianhua becomeFirstResponder];
        }else if (textField==_dianhua){
            [_zhiwei becomeFirstResponder];
            //[self tan1];
        }else if (textField==_zhiwei){
           // a=1;
            [_diqu becomeFirstResponder];
            //[self addresssss];
        }else if (textField==_diqu){
            [_dizhi becomeFirstResponder];
        }else if (textField==_dizhi){
            [_xingming becomeFirstResponder];
        }else if (textField==_xingming){
            [_lxdianhua becomeFirstResponder];
        }else if (textField==_lxdianhua){
           // a=2;
            [_lxdiqu becomeFirstResponder];
             //[self addresssss];
        }else if (textField==_lxdiqu){
            [_lxdizhi becomeFirstResponder];
        }else if (textField==_lxdizhi){
           [textField resignFirstResponder];
        }
        return YES;
}

#pragma mark-----三级连动

- (void)loadFirstData
{
    // 注意JSON后缀的东西和Plist不同，Plist可以直接通过contentOfFile抓取，Json要先打成字符串，然后用工具转换
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSLog(@"%@",path);
    NSString *jsonStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    self.addressArr = [jsonStr mj_JSONObject];
    
    NSMutableArray *firstName = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.addressArr)
    {
        NSString *name = dict.allKeys.firstObject;
        [firstName addObject:name];
    }
    // 第一层是省份 分解出整个省份数组
    self.provinceArr = firstName;
}
- (void)addresssss{
    //    NSArray *initialSelection = @[@(self.index1), @(self.index2),@(self.index3)];
    // 点击的时候传三个index进去
    self.picker = [[ActionSheetCustomPicker alloc]initWithTitle:@"选择地区" delegate:self showCancelButton:YES origin:self.view initialSelections:@[@(self.index1),@(self.index2),@(self.index3)]];
    self.picker.tapDismissAction  = TapActionSuccess;
    // 可以自定义左边和右边的按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, 0, 44, 44);
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    [self.picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:button]];
    [self.picker setDoneButton:[[UIBarButtonItem alloc] initWithCustomView:button1]];
    
    //[self.picker addCustomButtonWithTitle:@"再来一次" value:@(1)];
    [self.picker showActionSheetPicker];
}

// 根据传进来的下标数组计算对应的三个数组
- (void)calculateFirstData
{
    // 拿出省的数组
    [self loadFirstData];
    
    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
    // 根据省的index1，默认是0，拿出对应省下面的市
    for (NSDictionary *cityName in [self.addressArr[self.index1] allValues].firstObject) {
        
        NSString *name1 = cityName.allKeys.firstObject;
        [cityNameArr addObject:name1];
    }
    // 组装对应省下面的市
    self.countryArr = cityNameArr;
    //                             index1对应省的字典         市的数组 index2市的字典   对应市的数组
    // 这里的allValue是取出来的大数组，取第0个就是需要的内容
    self.districtArr = [[self.addressArr[self.index1] allValues][0][self.index2] allValues][0];
}

#pragma mark - UIPickerViewDataSource Implementation
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Returns
    switch (component)
    {
        case 0: return self.provinceArr.count;
        case 1: return self.countryArr.count;
        case 2:return self.districtArr.count;
        default:break;
    }
    return 0;
}
#pragma mark UIPickerViewDelegate Implementation

// returns width of column and height of row for each component.
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    switch (component)
//    {
//        case 0: return SCREEN_WIDTH /4;
//        case 1: return SCREEN_WIDTH *3/8;
//        case 2: return SCREEN_WIDTH *3/8;
//        default:break;
//    }
//
//    return 0;
//}

/*- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
 {
 return
 }
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.provinceArr[row];break;
        case 1: return self.countryArr[row];break;
        case 2:return self.districtArr[row];break;
        default:break;
    }
    return nil;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* label = (UILabel*)view;
    if (!label)
    {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14]];
    }
    
    NSString * title = @"";
    switch (component)
    {
        case 0: title =   self.provinceArr[row];break;
        case 1: title =   self.countryArr[row];break;
        case 2: title =   self.districtArr[row];break;
        default:break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text=title;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            self.index1 = row;
            self.index2 = 0;
            self.index3 = 0;
            //            [self calculateData];
            // 滚动的时候都要进行一次数组的刷新
            [self calculateFirstData];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
            
        case 1:
        {
            self.index2 = row;
            self.index3 = 0;
            //            [self calculateData];
            [self calculateFirstData];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
        }
            break;
        case 2:
            self.index3 = row;
            break;
        default:break;
    }
}
//
//- (void)calculateData
//{
//    [self loadFirstData];
//    NSDictionary *provincesDict = self.addressArr[self.index1];
//    NSMutableArray *countryArr1 = [[NSMutableArray alloc] init];
//    for (NSDictionary *contryDict in provincesDict.allValues.firstObject) {
//        NSString *name = contryDict.allKeys.firstObject;
//        [countryArr1 addObject:name];
//    }
//    self.countryArr = countryArr1;
//
//    self.districtArr = [provincesDict.allValues.firstObject[self.index2] allValues].firstObject;
//
//}

- (void)configurePickerView:(UIPickerView *)pickerView
{
    pickerView.showsSelectionIndicator = NO;
}
// 点击done的时候回调
- (void)actionSheetPickerDidSucceed:(ActionSheetCustomPicker *)actionSheetPicker origin:(id)origin
{
    NSMutableString *detailAddress = [[NSMutableString alloc] init];
    if (self.index1 < self.provinceArr.count) {
        NSString *firstAddress = self.provinceArr[self.index1];
        [detailAddress appendString:firstAddress];
    }
    if (self.index2 < self.countryArr.count) {
        NSString *secondAddress = self.countryArr[self.index2];
        [detailAddress appendString:secondAddress];
    }
    if (self.index3 < self.districtArr.count) {
        NSString *thirfAddress = self.districtArr[self.index3];
        [detailAddress appendString:thirfAddress];
    }
    // 此界面显示
    if(a==1){
    _diqu.text = detailAddress;
    }else{
    _lxdiqu.text = detailAddress;
    }
    a=0;
   
}


- (NSArray *)provinceArr
{
    if (_provinceArr == nil) {
        _provinceArr = [[NSArray alloc] init];
    }
    return _provinceArr;
}
-(NSArray *)countryArr
{
    if(_countryArr == nil)
    {
        _countryArr = [[NSArray alloc] init];
    }
    return _countryArr;
}

- (NSArray *)districtArr
{
    if (_districtArr == nil) {
        _districtArr = [[NSArray alloc] init];
    }
    return _districtArr;
}

-(NSArray *)addressArr
{
    if (_addressArr == nil) {
        _addressArr = [[NSArray alloc] init];
    }
    return _addressArr;
}






@end
