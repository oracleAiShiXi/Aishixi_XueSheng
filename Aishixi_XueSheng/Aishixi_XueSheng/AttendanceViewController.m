//
//  AttendanceViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "AttendanceViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "XL_TouWenJian.h"
@interface AttendanceViewController ()<CLLocationManagerDelegate>
{
    UIImagePickerController  *Imgpicker;
    CLLocationManager*_locationManager;
    NSString *filepath;
    
//    NSString*sheng;
//    NSString*shi;
//    NSString*qu;
//    NSString*street;
//    NSString*jing;
//    NSString*wei;
//    NSString*address;
//    NSString*jied;
    
}

@end

@implementation AttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self navagatio];
    [self phone];//调取相机
    //[self  initializeLocationService];//开启定位
    
    
    // Do any additional setup after loading the view.
}
-(void)navagatio{
    self.title =@"签到";
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




- (IBAction)Attendan:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * Method = @"/homePageStu/attendance";
    
    
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",_jingdu,@"longitude",_weidu,@"latitude",_dizhi,@"address",nil];
    NSLog(@"%@",Rucan);
    //UIImage *image = [UIImage imageNamed:@"对号2"];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:filepath];
    NSLog(@"%@",image);
    NSArray * arr = [NSArray arrayWithObjects:image, nil];
    
    [WarningBox warningBoxModeIndeterminate:@"正在签到" andView:self.view];
    
    [XL_WangLuo ShangChuanTuPianwithBizMethod:Method Rucan:Rucan type:Post image:arr key:@"url" success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            
        NSLog(@"8 学生考勤\n%@",responseObject);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
        
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        
        NSLog(@"%@",error);
    }];
    
    
    
    
    
    
}
//相机
-(void)phone {
    
    //打开相机
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }else
    {
        
        
        Imgpicker = [[UIImagePickerController alloc] init];
        Imgpicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//相册
        
        Imgpicker.delegate = self;
        //设置选择后的图片可被编辑
        Imgpicker.allowsEditing = YES;

        [self presentViewController:Imgpicker animated:YES completion:nil];
        
        
    }
    
    
}

#pragma mark  相机相册

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //self.image.image = image;
    NSData  *imgdata = UIImageJPEGRepresentation(image, 0.1);
    
    //图片保存的路径
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //这里将图片放在沙盒的documents下的Image文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    
    
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //图片名以时间戳的格式存储到目录下
    filepath=[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/currentImage.png"]];
    
    
    
    
    [fileManager createFileAtPath:filepath contents:imgdata attributes:nil];
    
    //将图片显示到image上
    UIImage *img = [[UIImage alloc]initWithContentsOfFile:filepath];
    [self.Img setImage:img];
    
    // NSLog(@"%@",NSHomeDirectory());
    
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
//取消选择图片
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CLLocationManagerDelegate methods 定位

//- (void)initializeLocationService {
//    
//    // 初始化定位管理器
//    _locationManager = [[CLLocationManager alloc] init];
//    // 设置代理
//    _locationManager.delegate = self;
//    // 设置定位精确度到米
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    // 设置过滤器为无
//    _locationManager.distanceFilter = kCLDistanceFilterNone;
//    // 开始定位
//    // 取得定位权限，有两个方法，取决于你的定位使用情况
//    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
//    [_locationManager requestAlwaysAuthorization];//这句话ios8以上版本使用。
//    [_locationManager startUpdatingLocation];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
//    
//    //将经度显示到label上
//    jing = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
//    //将纬度现实到label上
//    wei = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
//    // 获取当前所在的城市名
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    //根据经纬度反向地理编译出地址信息
//    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
//        if (array.count > 0){
//            
//            CLPlacemark *placemark = [array objectAtIndex:0];
//            NSLog(@"%@",placemark);
//           
//            address=[placemark.addressDictionary objectForKey:@"FormattedAddressLines"][0];
//            
//            NSLog(@"--------%@",address);
//            
//           // sheng=[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:@"State"]];
//            
//            //获取城市
////            NSString *city = placemark.locality;
////            
////            if (city) {
////                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
////                city = placemark.administrativeArea;
////                
////                //市
////                
////                shi=[NSString stringWithFormat:@"%@",placemark.locality];
////                //区
////                qu=[NSString stringWithFormat:@"%@",placemark.subLocality];
////                //街道
////                jied =[NSString stringWithFormat:@"%@",placemark.thoroughfare];
////            }
////            if (sheng==nil||shi==nil||qu==nil) {
////                
////            }else{
////                if(nicaicai==0){
////                    nicaicai=1;
////                    @try {
////                       
////                    } @catch (NSException *exception) {
////                        NSLog(@"崩了崩了崩了");
////                    }
////                    
////                }
////            }
//        }
//        else if (error == nil && [array count] == 0)
//        {
//        }
//        else if (error != nil)
//        {
//        }
//    }];
//    
//    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
//  //  panduan=0;
//    
//    
//    [manager stopUpdatingLocation];
//
//    
//    
//}



@end
