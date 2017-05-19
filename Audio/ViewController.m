//
//  ViewController.m
//  Audio
//
//  Created by sycf_ios on 2017/5/19.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,strong) NSURL *url;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingString:@"h.caf"];
    NSLog(@"path:%@",path);
    self.url = [NSURL fileURLWithPath:path];
    
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc]init];
    [recordSettings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSettings setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
    [recordSettings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    self.recorder = [[AVAudioRecorder alloc]initWithURL:self.url settings:recordSettings error:nil];
    
    [self.recorder prepareToRecord];
    
    
}
- (IBAction)handleRecordVolumes:(id)sender {
    if ([[(UIButton *)sender currentTitle] isEqualToString:@"开始录音"]) {
        [self.recorder record];
    }else if ([[(UIButton *)sender currentTitle] isEqualToString:@"暂停录音"]){
        [self.recorder pause];
    }else if ([[(UIButton *)sender currentTitle] isEqualToString:@"停止录音"]){
        [self.recorder stop];
    }else{
        self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:self.url error:nil];
        [self.player prepareToPlay];
        [self.player play];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
