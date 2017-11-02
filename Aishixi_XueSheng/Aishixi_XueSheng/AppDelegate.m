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
#import <JPUSHService.h>
#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define appkey @"4f791f45eae7b1dae693ada3"
#define channell @""
#define isProduction 0
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<CLLocationManagerDelegate , JPUSHRegisterDelegate>
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
static AppDelegate *_appDelegate;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:appkey
                          channel:channell
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    
    
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
+ (AppDelegate *)appDelegate {
    return _appDelegate;
}
#pragma  mark -- 注册用户 （JPush）
-(void)method{

    NSString*alias=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];
    
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"--iResCode  %ld\niAlias  %@\nseq  %ld",(long)iResCode,iAlias,(long)seq);
        if (iResCode == 6002) {
            [self method];
        }
    } seq:1];
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

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"deviceToken    %@",deviceToken);
    
    
    [self method];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
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
