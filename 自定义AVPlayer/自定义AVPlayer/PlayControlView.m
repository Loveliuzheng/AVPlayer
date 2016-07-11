//
//  PlayControlView.m
//  自定义AVPlayer
//
//  Created by GG on 16/6/21.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "PlayControlView.h"

@interface PlayControlView ()

@property (nonatomic,assign) BOOL isPlayer;

@end

@implementation PlayControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self layoutUI];
    }
    return self;
}


- (void)layoutUI{
    
    
    //控制暂停与播放按钮
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [self.playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.playBtn.frame = CGRectMake(kPading, kPading, 60, self.frame.size.height-2*kPading);
    [self.playBtn addTarget:self action:@selector(playBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playBtn];
    
    self.playBtn.userInteractionEnabled = NO;
    
    
    //进度滑块
    self.vedioSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.playBtn.frame)+kPading, kPading, 210, CGRectGetHeight(self.playBtn.frame))];
    
    
    //获取到一个透明的图片
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //设置滑块两边的图片
    [self.vedioSlider setMaximumTrackImage:image forState:UIControlStateNormal];
    [self.vedioSlider setMinimumTrackImage:image forState:UIControlStateNormal];
    

    float screenW = self.frame.size.width;
    
    //时间label
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenW-kPading-100, kPading, 100, CGRectGetHeight(self.playBtn.frame))];
    
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.text = @"00:00/00:00";
    [self addSubview:self.timeLabel];
    
    
    //设置进度条
    _vedioProgress = [[UIProgressView alloc]initWithFrame:self.vedioSlider.frame];
    
    _vedioProgress.center = self.vedioSlider.center;

    [self addSubview:_vedioProgress];
    [self addSubview:self.vedioSlider];

}

- (void)playBtnTouch{
    
    self.isPlayer = !self.isPlayer;
    
    if (self.isPlayer) {
        
        [self.player pause];
        [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
        
    }else{
        
        [self.player play];
         [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    
}


@end
