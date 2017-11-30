//
//  XL_Header.h
//  Aishixi_XueSheng
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.


#define CLog(format, ...)  NSLog(format, ## __VA_ARGS__)

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define Scheme  @"http://"
#define AppName @"/aishixi"

#define apath    @"/api/rest/1.0"
#define QianWaiWangIP @"www.ishixi.cn"

//#define QianWaiWangIP @"192.168.1.250:8080"//内网
#define QianWaiWang [NSString stringWithFormat:@"%@%@%@%@",Scheme,QianWaiWangIP,AppName,apath]

#define Appkey   @"d800528f235e4142b78a8c26c4d537d9"


