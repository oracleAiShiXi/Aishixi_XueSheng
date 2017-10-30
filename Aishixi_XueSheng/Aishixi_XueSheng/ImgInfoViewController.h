//
//  ImgInfoViewController.h
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/10/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgInfoViewController : UIViewController
@property (strong, nonatomic) NSString *CarouselId;

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
