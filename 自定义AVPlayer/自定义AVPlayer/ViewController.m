//
//  ViewController.m
//  自定义AVPlayer
//
//  Created by GG on 16/6/21.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "ViewController.h"
#import "CustomPlayerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CustomPlayerView *playerView = [[CustomPlayerView alloc]initWithFrame:CGRectMake(0, 0, 414, 300)];
    [self.view addSubview:playerView];
    
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:@"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"]];
    
    playerView.player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
    
    [playerView.player play];
    
    
    
    
    /*
     * AVPlayer自定义
     
       1、 两个KVO
     
           监听AVPlayerItem的status 获取视频的总时间
           
           监听AVPlayerItem的loadedTimeRanges 获取缓冲进度
     
       2、addPeriodicTimeObserverForInterval
     
           监听AVPlayer的播放进度
     
       3、通知
     
           监听播放结束
     
       4、移除以上所有的观察者
     
     
     
     */
    
    
    
    
    
    
}


@end
