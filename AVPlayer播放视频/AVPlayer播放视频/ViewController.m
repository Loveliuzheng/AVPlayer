//
//  ViewController.m
//  AVPlayer播放视频
//
//  Created by cqy on 16/6/21.
//  Copyright © 2016年 刘征. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController (){
    
    AVPlayer *player;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark 播放音频
    
//   AVPlayer *player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:   @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"]];
//    
//
//  [player play];
//
#pragma mark 播放视频
    /*
     * AVPlayer播放视频流程
     
     1、创建一个AVPlayerItem对象,每个AVPlayerItem对象，就是一个视频或音频
     
     2、将AVPlayerItem对象放到一个AVPlayer对象，AVPlayer对象负责视频的暂停与开启操作
     
     3、将AVPlayer放到一个AVPlayerLayer对象里，AVPlayerLayer负责视频的一个展示，他可以设置frame
     
     4、将AVPlayLayer放到某试图的layer层
     
     
     5、 播放
     */
    
    AVPlayerItem *playItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:@"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"]];
    
    
    player = [[AVPlayer alloc]initWithPlayerItem:playItem];
    
    AVPlayerLayer *avPlayLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    
    avPlayLayer.frame = CGRectMake(0, 0, 414, 400);
    
    
    [self.view.layer addSublayer:avPlayLayer];
    
    [player play];
    
}

@end
