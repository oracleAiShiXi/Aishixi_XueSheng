//
//  XL_WangLuo.h
//  Aishixi_XueSheng
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <SBJson5Writer.h>

typedef NS_ENUM(NSUInteger,Post_or_Get) {
    /**
     *  get请求
     */
    Get = 0,
    /**
     *  post请求
     */
    Post
};

@interface XL_WangLuo : NSObject
/*
 * 店小二的上传图片
 */
+(void)ShangChuanTuPianwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type image:(UIImage*)image key:(NSString*)key success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;
/*
 * 外网除了登录接口
 */
+(void)QianWaiWangQingqiuwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

@end
