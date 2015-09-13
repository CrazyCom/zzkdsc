//
//  ClickPictureView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/19.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ClickPictureView.h"

@interface ClickPictureView ()<UIActionSheetDelegate> {
    
    
}

@end

@implementation ClickPictureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    
    if (self = [super init]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择本地照片",@"拍照", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self];
    }
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
    }
    else if (buttonIndex == 1) {
        self.pictureBlock(pickImageFromAlbum);
    }
    else if (buttonIndex == 2) {
        self.pictureBlock(takePhotos);
    }
    else {
        self.pictureBlock(cancel);
    }
    [self removeFromSuperview];
}
@end
