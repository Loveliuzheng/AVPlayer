//
//  CustomPlayerView.m
//  自定义AVPlayer
//
//  Created by GG on 16/6/21.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "CustomPlayerView.h"
#import "PlayControlView.h"
#pragma mark 播放试图

@interface CustomPlayerView ()

@property (nonatomic,strong) PlayControlView *playControlView;

@end

@implementation CustomPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.playControlView = [[PlayControlView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-kPlayControlViewHeight, self.frame.size.width, kPlayControlViewHeight)];
        
        
        self.playControlView.backgroundColor = [UIColor redColor];
        [self addSubview:self.playControlView];
        
        //给播放进度滑块设置事件
        [self.playControlView.vedioSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    return self;
}

- (void)valueChanged:(UISlider *)slider{
    
    
    //让视频快进到某一个时间点
    [self.player seekToTime:CMTimeMake(slider.value, 1) completionHandler:^(BOOL finished) {
        
        
    }];
    
    
}


- (void)setPlayer:(AVPlayer *)player{
    
    _player = player;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-kPlayControlViewHeight);
    [self.layer addSublayer:playerLayer];
    self.playControlView.player = player;
    
    [self setKvo];
    
}

- (void)setKvo{
    
    //监听当前播放视频的状态
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听缓冲进度
    [self.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    //注册通知，监听播放完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}

- (void)playEnd{
    
    [self.playControlView.playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [self.player pause];
    
    
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
       
        self.playControlView.vedioSlider.value = 0.0;
        
        self.playControlView.vedioProgress = 0;
        
    }];
    
    
    
}


//kvo监听的属性发生变化时调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"status"]) {
        
         if(self.player.currentItem.status == AVPlayerItemStatusReadyToPlay){
        
             self.playControlView.playBtn.userInteractionEnabled = YES;
        
            //获取视频的总时长
            CMTime cmtime = self.player.currentItem.duration;
            float totalDuration = CMTimeGetSeconds(cmtime);
        
            NSLog(@"视频总时长= %f",totalDuration);
        
           self.playControlView.vedioSlider.maximumValue = totalDuration;
        
        
            __weak CustomPlayerView *weakSelf = self;
           //实时监听播放进度
           [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1)  queue:NULL usingBlock:^(CMTime time) {
            
            
            float currentPlayTime = CMTimeGetSeconds(time);
            
//            NSLog(@"当前播放时间 = %f",currentPlayTime);
            
            weakSelf.playControlView.vedioSlider.value = currentPlayTime;
            
            //将秒转化为时间字符串
            NSString *currentTimeStr =  [weakSelf convertDuraion:currentPlayTime];
            
            NSString *totalDurtaionStr = [weakSelf convertDuraion:totalDuration];
            
            
            weakSelf.playControlView.timeLabel.text = [NSString stringWithFormat:@"%@/%@",currentTimeStr,totalDurtaionStr];
            
        
        }];
    }
        
    }else{
        
       NSArray *loadedTimeRangesArray =  self.player.currentItem.loadedTimeRanges;
        
        
        //获取缓冲区域
        CMTimeRange timeRange = [loadedTimeRangesArray.lastObject CMTimeRangeValue];
//        
//        NSLog(@"start = %f",CMTimeGetSeconds(timeRange.start));
//        
//        NSLog(@"duration = %f",CMTimeGetSeconds(timeRange.duration));
        
        float bufferTime = CMTimeGetSeconds(timeRange.duration)-CMTimeGetSeconds(timeRange.start);
        
        
        
        if (self.playControlView.vedioSlider.maximumValue != 1) {
            
            self.playControlView.vedioProgress.progress = bufferTime/self.playControlView.vedioSlider.maximumValue;
            
        }
        
//        NSLog(@"缓冲时间 = %f", bufferTime/self.playControlView.vedioSlider.maximumValue);
        
        
        
    }
}

- (NSString *)convertDuraion:(float)duraion{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:duraion];

    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];

    dateFormate.dateFormat = @"mm:ss";

    return [dateFormate stringFromDate:date];

}

- (void)dealloc{
    
    [self removeObserver:self forKeyPath:@"stauts"];
    
    [self removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
    [self.player removeTimeObserver:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    float alpha = self.playControlView.alpha == 1 ? 0 : 1;
    
    [UIView animateWithDuration:0.3 animations:
        ^{
        
        self.playControlView.alpha = alpha;
            
    }];
}

@end



