//
//  PictureView.h
//  BagChef
//
//  Created by zhangzhi on 15/8/19.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureView : UIView {
    
    float _height;
    NSInteger _count;
}

@property (nonatomic , strong) UIButton *addBtn;
@property (nonatomic , strong) UIView *bgView;
@property (nonatomic , strong) NSMutableArray *imgArray;

- (void)imageData:(NSMutableArray *)array;
- (void)upImageList;


@end
