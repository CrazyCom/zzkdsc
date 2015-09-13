//
//  PictureView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/19.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "PictureView.h"
@interface PictureView()<UIImagePickerControllerDelegate> {
    
    
}

@end

@implementation PictureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _imgArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 5; i ++) {
            self.backgroundColor = [UIColor redColor];
            UIButton *btn= [[UIButton alloc]initWithFrame:CGRectMake(10 + (49 + 8)*i, 8, 49, 49)];
            [btn setBackgroundImage:[UIImage imageNamed:@"pic"] forState:UIControlStateNormal];
            btn.tag = 100 + i ;
            [self addSubview:btn];
            if (btn.tag == 101) {
                btn.hidden = YES;
            }
            if (btn.tag == 102) {
                btn.hidden = YES;
            }
            if (btn.tag == 103) {
                btn.hidden = YES;
            }
            if (btn.tag == 104) {
                btn.hidden = YES;
            }
            
        }
        self.backgroundColor = [UIColor whiteColor];
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 8, 49, 49)];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"pic"] forState:UIControlStateNormal];
        _addBtn.tag = 100;
        [self addSubview:_addBtn];

    }
    return self;
}



//- (void)drawRect:(CGRect)rect {
//    
//    if (_count > 0) {
//        [self addPhotoCenter:_count + 100 ];
//    }
//}

- (void)addPhotoCenter:(NSInteger)tag {
    
    UIButton *btn = (UIButton *)[self viewWithTag:tag +1];
    btn.hidden = NO;
    _addBtn.userInteractionEnabled = YES;
    _addBtn.bounds = btn.bounds;
    _addBtn.center = btn.center;
//    _addBtn.frame = btn.frame;
    if (_count == 5) {
        self.addBtn.userInteractionEnabled = NO;
    }
}

- (void)imageData:(NSMutableArray *)array {
    
    _count = [_imgArray count] + [array count];
    
    for (int i = 0; i < [array count]; i++) {
        
        UIButton *imageView = (UIButton *)[self viewWithTag:100 + i + [_imgArray count]];
        imageView.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setImage:array[i] forState:UIControlStateNormal];
        
        imageView.hidden = NO;
        
//        [_imgArray addObject:array[i]];
    }
    
//    NSData *imageData = UIImageJPEGRepresentation(<#UIImage *image#>, <#CGFloat compressionQuality#>)
//
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image = [[array firstObject] copy];
        NSData *data;
        data = UIImageJPEGRepresentation(image, 1);
        
        //            Byte *testByte = (Byte *)[data bytes];
        while (data.length/1024 > 1024) {
            image = [PictureView imageScaleToSize:image size:CGSizeMake(image.size.width/2, image.size.height/2)];
            data = UIImageJPEGRepresentation(image, 0.7);
            
        }
        [_imgArray addObject:data];
        
        
        

    });
    
    
    
    UIButton *btn =  (UIButton *)[self viewWithTag:100 + _count];
    btn.hidden = NO;
    _addBtn.frame = btn.frame;
}

+ (UIImage *)imageScaleToSize:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (void)upImageList {
    
    for (int i = 0 ; i < 5; i++) {
        UIButton *imageView = (UIButton *)[self viewWithTag:100 + i];
        imageView.hidden = YES;
    }
}


#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSData *imageData = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"], 0.1);
    UIImage *img = [UIImage imageWithData:imageData];
    [_imgArray addObject:img];
    
    for (int i = 0; i <_imgArray.count; i++) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString * _filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"img_%d.jpg", i]];   // 保存文件的名称
        [UIImagePNGRepresentation(_imgArray[i])writeToFile:_filePath atomically:YES];

    }
}

@end
