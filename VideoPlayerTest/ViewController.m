//
//  ViewController.m
//  VideoPlayerTest
//
//  Created by tudc on 2020/8/27.
//  Copyright © 2020 yjw. All rights reserved.
//

#import "ViewController.h"
#import <SJVideoPlayer.h>
#import "SJPlayerSuperview.h"

#define SourceURL1 [NSURL URLWithString:@"https://crazynote.v.netease.com/2019/0811/6bc0a084ee8655bfb2fa31757a0570f4qt.mp4"]

@interface ViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) SJVideoPlayer *player;
@property (nonatomic,strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 3.0);
    [self.view addSubview:self.scrollView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(100.0, 500.0, 100.0, 40.0);
    [self.button setTitle:@"aaa" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(aakao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    SJPlayerSuperview *playerSuperview = [SJPlayerSuperview.alloc initWithFrame:CGRectMake(50.0, 100.0, self.view.bounds.size.width - 100.0, 150.0)];
    playerSuperview.backgroundColor = UIColor.redColor;
    [self.scrollView addSubview:playerSuperview];
    
    _player = SJVideoPlayer.player;
    _player.autoManageViewToFitOnScreenOrRotation = NO;
    _player.shouldTriggerRotation = ^BOOL(__kindof SJBaseVideoPlayer * _Nonnull player) {
//        __strong typeof(_self) self = _self;
//        if ( !self ) return NO;
        // 此处添加逻辑, 如果可以旋转, 则返回YES, 否之
        // ...
        // ...
        return YES;
    };
    
    _player.rotationManager.autorotationSupportedOrientations = SJOrientationMaskAll;
    
    //_player.floatSmallViewController.enabled = YES;
    //_player.useFitOnScreenAndDisableRotation = YES;
    __weak typeof(self) _self = self;
//    _player.floatSmallViewController.singleTappedOnTheFloatViewExeBlock = ^(id<SJFloatSmallViewController>  _Nonnull controller) {
//        __strong typeof(_self) self = _self;
//        if ( !self ) return;
//        [controller dismissFloatView];
//        UIViewController *vc = UIViewController.new;
//        vc.view.backgroundColor = UIColor.whiteColor;
//        [self.navigationController pushViewController:vc animated:YES];
//    };
    _player.floatSmallViewController.doubleTappedOnTheFloatViewExeBlock = ^(id<SJFloatSmallViewController>  _Nonnull controller) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        self.player.isPaused ? [self.player play] : [self.player pause];
    };
    _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:SourceURL1 playModel:[SJPlayModel playModelWithScrollView:self.scrollView]];
    [_player play];
}

- (void)aakao{
    [self.player setFitOnScreen:YES animated:YES completionHandler:^(__kindof SJBaseVideoPlayer * _Nonnull player) {
//            [player rotate:SJOrientation_LandscapeRight animated:YES completion:^(__kindof SJBaseVideoPlayer * _Nonnull player) {
//        
//            }];
    }];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player vc_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player vc_viewDidDisappear];
}

//- (BOOL)shouldAutorotate {
//    return NO;
//}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

@end
