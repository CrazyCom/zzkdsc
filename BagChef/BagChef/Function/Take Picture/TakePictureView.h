//
//  TakePictureView.h
//  LuZhouTong
//
//  Created by dqdeng on 14/12/3.
//  Copyright (c) 2014年 choice. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    pickTakePhotos = 0, //拍照
    pickImageFromAlbum = 1, //相册
    pickCancel = 2, //取消
} PickMethods;
typedef void (^takePictureBlock)(PickMethods method);
@interface TakePictureView : UIView
@property (nonatomic,copy) takePictureBlock pictureBlock;

+ (instancetype)takePictureViewWithTakePictureBlock:(takePictureBlock)pictureBlock;

@end
