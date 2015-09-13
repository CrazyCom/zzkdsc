//
//  ClickPictureView.h
//  BagChef
//
//  Created by zhangzhi on 15/8/19.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSUInteger {
    
    takePhotos = 0, //拍照
    pickImageFromAlbum, //相册
    cancel = 2, //取消
    
}PickMethods;

typedef void(^takePictureBlock) (PickMethods method);

@interface ClickPictureView : UIView

@property (nonatomic , copy) takePictureBlock pictureBlock;

@end
