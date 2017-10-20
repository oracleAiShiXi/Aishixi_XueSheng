//
//  XL_WangLuo.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "XL_WangLuo.h"
#import "XL_Header.h"

@implementation XL_WangLuo

+(void)QianWaiWangQingqiuwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;{
    
    NSString *Waiwang=QianWaiWang;
    NSString *BizMethod=BizMetho;
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",Waiwang,BizMethod];
    SBJson5Writer *writer=[[SBJson5Writer alloc] init];
    NSDictionary*BizParamStr = BizParamSt;
    NSString *Rucan=[writer stringWithObject:BizParamStr];
    NSDictionary *ChuanCan=[NSDictionary dictionaryWithObjectsAndKeys:Appkey,@"appkey",Rucan,@"params", nil];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    switch (type) {
        case Get:{
            [manager GET:Url parameters:ChuanCan progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        }
            
            break;
        case Post:{
            [manager POST:Url parameters:ChuanCan progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        }
            
            break;
    }
    
}
+(void)ShangChuanTuPianwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type image:(NSArray*)arr key:(NSString*)key success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure{
    NSString *JuYuwang=QianWaiWang;//登录接口不用
    NSString *BizMethod=BizMetho;
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",JuYuwang,BizMethod];
    NSDictionary*BizParamStr=BizParamSt;
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    [manager POST:Url parameters:BizParamStr constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i<arr.count;i++) {
            UIImage *image =arr[i];
            NSData *data= UIImageJPEGRepresentation(image, 0.5); //如果用jpg方法需添加jpg压缩方法
            NSDateFormatter *fm = [[NSDateFormatter alloc] init];
            // 设置时间格式
            fm.dateFormat = @"yyyyMMdd_HHmmss";
            NSString *str = [fm stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@_%d.png", str,i];
            [formData appendPartWithFileData:data name:key fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}

@end
