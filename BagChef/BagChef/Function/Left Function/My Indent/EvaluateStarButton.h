//
//  EvaluateStarButton.h
//  BagChef
//
//  Created by zhangzhi on 15/9/13.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, StarButtonType) {
 
    StarTypeNormal = 0,
    StarTypeSelected1,
    StarTypeSelected2,
};

@interface EvaluateStarButton : UIButton

@property (nonatomic, assign) StarButtonType starType;

- (void)setImage:(UIImage *)image forType:(StarButtonType)type;



@end
