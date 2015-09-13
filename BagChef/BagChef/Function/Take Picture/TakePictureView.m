//
//  TakePictureView.m
//  LuZhouTong
//
//  Created by dqdeng on 14/12/3.
//  Copyright (c) 2014年 choice. All rights reserved.
//

#import "TakePictureView.h"

@interface TakePictureView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalConstraint;
@property (weak, nonatomic) IBOutlet UIView *moveView;

@end
@implementation TakePictureView

+ (instancetype)takePictureViewWithTakePictureBlock:(takePictureBlock)pictureBlock {

    TakePictureView *view = [[[NSBundle mainBundle] loadNibNamed:@"TakePictureView" owner:nil options:nil] firstObject];
//    view.backgroundColor = [UIColor whiteColor];
    view.pictureBlock = pictureBlock;
    UIViewController *topvc = [Common appRootViewController];
    view.frame = topvc.view.frame;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view layoutIfNeeded];
        [UIView animateWithDuration:0.25 animations:^{
            view.verticalConstraint.constant = 0;
            [view layoutIfNeeded];
        }];
      
    });
    [topvc.view addSubview:view];
    
    return view;
}
- (void)drawRect:(CGRect)rect {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.verticalConstraint.constant = 0;
        [self layoutIfNeeded];
    });

}
- (IBAction)btnPressd:(UIButton *)sender {

    switch (sender.tag) {
        case 20:
            self.pictureBlock(pickImageFromAlbum);
            break;
        case 21:
            self.pictureBlock(pickTakePhotos);
            break;
        case 22:
            self.pictureBlock(pickCancel);
            break;

        default:
            break;
    }
    [self removeFromSuperview];    
}

#pragma mark - 根据触摸的坐标来判断是否消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
        UITouch *touch = [touches anyObject];
        CGPoint originalLocation = [touch locationInView:self];
        if (originalLocation.x > CGRectGetMinX(_moveView.frame) && originalLocation.x < CGRectGetMaxX(_moveView.frame) && originalLocation.y > CGRectGetMinY(_moveView.frame) && originalLocation.y < CGRectGetMaxY(_moveView.frame)) {
    
        } else {
            [self removeFromSuperview];
        }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
