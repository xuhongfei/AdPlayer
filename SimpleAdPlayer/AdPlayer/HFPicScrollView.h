//
//  HFPicScrollView.h
//  BubbleGum
//
//  Created by xuhongfei on 15/11/12.
//  Copyright © 2015年 shansander. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFPicScrollView;

@protocol HFPicScrollViewDelegate <NSObject>

@optional
- (void)picScrollView:(HFPicScrollView *)picScrollView didClickedPicIndex:(NSInteger)index;

@end

@interface HFPicScrollView : UIView

@property (nonatomic, weak) id<HFPicScrollViewDelegate> deleagte;

/**
 *  设置滚动的图片数组
 *
 *  @param pics 图片数组
 */
- (void)settingScrollPics:(NSArray *)pics ;

@end
