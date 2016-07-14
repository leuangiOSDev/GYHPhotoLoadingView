//
//  CircleProgressViewController.m
//  GYHPhotoLoadingView
//
//  Created by 范英强 on 16/7/13.
//  Copyright © 2016年 gyh. All rights reserved.
//

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#import "CircleProgressViewController.h"
#import "GYHCircleProgressView.h"
#import "UIImageView+WebCache.h"

@interface CircleProgressViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation CircleProgressViewController
{
    GYHCircleProgressView *progressV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
        
    progressV = [[GYHCircleProgressView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 40)/2,(SCREEN_HEIGHT - 40)/2, 40, 40)];
    progressV.progressColor = [UIColor redColor];
    progressV.progressStrokeWidth = 3.0f;
    progressV.progressTrackColor = [UIColor whiteColor];
    [self.view addSubview:progressV];
    
    __weak __typeof__(self) block_self = self;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/gaoyuhang/DayDayNews/master/photo/newsfresh.png"] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
        [block_self animate:progress];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"此处应该弹框提示,并且隐藏progressV");
        }
        progressV.hidden = YES;
    }];
    
}

- (void)animate:(CGFloat)progress {
    progressV.progressValue = progress;
}

@end
