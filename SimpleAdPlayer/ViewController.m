//
//  ViewController.m
//  SimpleAdPlayer
//
//  Created by xuhongfei on 15/12/29.
//  Copyright © 2015年 xuhongfei. All rights reserved.
//

#import "ViewController.h"

#import "HFPicScrollView.h"

@interface ViewController ()

@property (nonatomic, weak) HFPicScrollView *adPlayerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    HFPicScrollView *adPlayerView = [[HFPicScrollView alloc] initWithFrame:frame];
    adPlayerView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:adPlayerView];
    
    UIImage *image = [UIImage imageNamed:@"Ad.jpg"];
    
    NSArray *pics = @[image, image, image];
    [adPlayerView settingScrollPics:pics];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
