//
//  PlayControlView.h
//  自定义AVPlayer
//
//  Created by GG on 16/6/21.
//  Copyright © 2016年 GG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define kPlayControlViewHeight 60
#define kPading 10

@interface PlayControlView : UIView

@property (nonatomic,strong) AVPlayer *player;



//控制视频的暂停与播放
@property (nonatomic,strong) UIButton *playBtn;

//播放进度滑块
@property (nonatomic,strong) UISlider *vedioSlider;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIProgressView *vedioProgress;

@end

