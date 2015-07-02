//
//  ViewController.m
//  homeWork
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 赵洋洋. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGes];
    
    rectView = [[UIView alloc] initWithFrame:CGRectZero];
    
    rectView.backgroundColor = [UIColor darkGrayColor];
    
    rectView.alpha = 0.5f;
    
    [self.view addSubview:rectView];
    
}
-(void)pan:(UIPanGestureRecognizer*)ges{

//判断状态
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
        {
            
            firstPoint = [ges locationInView:self.view];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
//            获取偏移量
           CGPoint newPoint =  [ges translationInView:self.view];
            
            rectView.frame = CGRectMake(firstPoint.x, firstPoint.y, newPoint.x, newPoint.y);
            
        }break;
        
        case UIGestureRecognizerStateEnded:
        {
            
//            保存图片
            
            [self savePic];
            
            [rectView removeFromSuperview];
            
        }break;
            
        default:
            break;
    }
}

-(void)savePic{
    
//    1.获取上下文
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    //    2.  设置裁剪区域
    UIRectClip(rectView.frame);
    
//    3.把ImageView 添加到 上下文中
    [imageV.layer renderInContext:context];
    
//    获取上下文中的图层  转化为 UIImage
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
//    结束
    UIGraphicsEndImageContext();
    
//   保存图片到相册
    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
