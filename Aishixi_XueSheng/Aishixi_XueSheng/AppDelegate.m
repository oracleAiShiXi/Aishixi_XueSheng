//
//  AppDelegate.m
//  Aishixi_XueSheng
//
//  Created by 斌小狼 on 2017/9/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "AppDelegate.h"
#import "XL_TouWenJian.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CoreLocation/CoreLocation.h>

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AppDelegate ()<CLLocationManagerDelegate>
{
    CLLocationManager*_locationManager;
    NSString*jing;
    NSString*wei;
    NSString*address;
}

@property (strong, nonatomic) UIView *lunchView;
@end

@implementation AppDelegate
@synthesize lunchView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    
    
    //前导页
    NSString *str;
    str=[NSString stringWithFormat:@"%@%@%@",Scheme,QianWaiWangIP,[[NSUserDefaults standardUserDefaults] objectForKey:@"tupianqidong"]];
    self.window.backgroundColor=[UIColor colorWithHexString:@"33c383"];
    [self.window makeKeyAndVisible];
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    lunchView = viewController.view;
    lunchView.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
    [self.window addSubview:lunchView];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
      // str = [str  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    //str= @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490322357&di=41a07a09e62f75400dade1b603142199&imgtype=jpg&er=1&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F7acb0a46f21fbe09359315d16f600c338644ad22.jpg";
    [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"引导页.png"]];
    [lunchView addSubview:imageV];
    
    [self.window bringSubviewToFront:lunchView];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
    
    [self jiekou];
    
    [self initializeLocationService];
    [self creatShortcutItem];  //动态创建应用图标上的3D touch快捷选项
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    //如果是从快捷选项标签启动app，则根据不同标识执行不同操作，然后返回NO，防止调用- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
    if (shortcutItem) {
        //判断设置的快捷选项标签唯一标识，根据不同标识执行不同操作
        //        if([shortcutItem.type isEqualToString:@"com.yang.one"]){
        //            NSLog(@"新启动APP-- 第一个按钮");
        //        } else if ([shortcutItem.type isEqualToString:@"com.yang.search"]) {
        //            //进入搜索界面
        //            NSLog(@"新启动APP-- 搜索");
        //        } else if ([shortcutItem.type isEqualToString:@"com.yang.add"]) {
        //            //进入分享界面
        //            NSLog(@"新启动APP-- 添加联系人");
        //        }else
        if ([shortcutItem.type isEqualToString:@"com.yang.share"]) {
            //进入分享页面
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            NSLog(@"新启动APP-- 帮助");
            [self  SOSjiekou];
           
            
        }
        
        return NO;
    }

    
    
    
    return YES;
}
- (void)creatShortcutItem {
    //创建系统风格的icon
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    //创建快捷选项
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"com.yang.share" localizedTitle:@"帮助" localizedSubtitle:@"寻求他人帮助" icon:icon userInfo:nil];
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item];
}
//如果APP没被杀死，还存在后台，点开Touch会调用该代理方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if (shortcutItem) {
        if ([shortcutItem.type isEqualToString:@"com.yang.share"]) {
            //进入分享页面
          
            [self  SOSjiekou];
                   }
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
}





-(void)removeLun{
    [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        lunchView.alpha = 0.0f;
        lunchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
    } completion:^(BOOL finished) {
        [lunchView removeFromSuperview];
    }];
}
-(void)SOSjiekou{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString*content= [NSString stringWithFormat:@"我是%@，我在%@遇到困难",[defaults objectForKey:@"nick"],address];
    
    NSString * Method = @"/classManagement/sos/seekHelp";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",jing,@"longitude",wei,@"latitude",address,@"address",content,@"context", nil];
    NSLog(@"-----%@",Rucan);
    NSLog(@"12312312312323");
    
 
    
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
 
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            
            NSLog(@"14 学生sos\n%@",responseObject);
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}
#pragma mark -- 启动页接口
-(void)jiekou{
    
    __block NSString *str = [NSString string];
    NSString *BizMethod=@"/set/startPage";
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:BizMethod Rucan:nil type:Post success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            str = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"tupianqidong"];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - CLLocationManagerDelegate methods 定位
//
- (void)initializeLocationService {
    
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    // 取得定位权限，有两个方法，取决于你的定位使用情况
    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
    [_locationManager requestAlwaysAuthorization];//这句话ios8以上版本使用。
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //将经度显示到label上
    jing = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //将纬度现实到label上
    wei = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            
            CLPlacemark *placemark = [array objectAtIndex:0];
           // NSLog(@"%@",placemark);
            
            address=[placemark.addressDictionary objectForKey:@"FormattedAddressLines"][0];
            
            //NSLog(@"--------%@",address);
            
            
        }
        else if (error == nil && [array count] == 0)
        {
        }
        else if (error != nil)
        {
        }
    }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    //  panduan=0;
    
    
    [manager stopUpdatingLocation];
    
    
    
}


@end
