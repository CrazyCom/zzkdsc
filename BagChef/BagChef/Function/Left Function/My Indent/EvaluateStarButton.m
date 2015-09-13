//
//  EvaluateStarButton.m
//  BagChef
//
//  Created by zhangzhi on 15/9/13.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "EvaluateStarButton.h"

@interface EvaluateStarButton () {

    UIImage *_normalImage;
    UIImage *_selectImage1;
    UIImage *_selectImage2;
}

@end

@implementation EvaluateStarButton

- (void)setImage:(UIImage *)image forType:(StarButtonType)type {
 
    switch (type) {
        case StarTypeNormal:{
            if (!_normalImage) {
                _normalImage = image;
                self.starType = StarTypeNormal;
            }
            else _normalImage = image;
        }
            break;
        case StarTypeSelected1:{
            _selectImage1 = image;
        }
            break;
        case StarTypeSelected2:{
            _selectImage2 = image;
        }
            break;
    }
    
}

- (void)setStarType:(StarButtonType)starType {

    _starType = starType;
    
    switch (_starType) {
        case StarTypeNormal:{
            if (_normalImage) {
                [self setImage:_normalImage forState:UIControlStateNormal];
            }
        }
            break;
        case StarTypeSelected1:{
            if (_selectImage1) {
                [self setImage:_selectImage1 forState:UIControlStateNormal];
            }
        }
            break;
        case StarTypeSelected2:{
            if (_selectImage2) {
                [self setImage:_selectImage2 forState:UIControlStateNormal];
            }
        }
            break;
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
