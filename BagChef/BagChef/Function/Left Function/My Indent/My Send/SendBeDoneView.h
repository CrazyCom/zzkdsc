//
//  SendBeDoneView.h
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendBeDoneView : UIView<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
}

- (void)updateViewWith:(NSMutableDictionary *)params;
@end
