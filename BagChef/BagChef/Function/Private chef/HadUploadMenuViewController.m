//
//  HadUploadMenuViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/24.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "HadUploadMenuViewController.h"
#import "HadUploadMenuTableViewCell.h"

@interface HadUploadMenuViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {
    
    UITableView *_tableView;
    
    NSMutableArray *_dataSource;
    NSMutableArray *_indexPaths;
    BOOL is_footer;
    BOOL _isEdit;
    
    int page;
    
    UIView *deleteView;
    UIButton *allDeleteBtn;
    UIButton *deleteBtn;
    BOOL delete;
    
    UIAlertView *alertView;
    NSIndexPath *cellIndexPath;
    NSString *_selectedUserID;
}

- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation HadUploadMenuViewController

-(void)initializeDataSource {
    
    _dataSource = [[NSMutableArray alloc]init];
    _indexPaths = [[NSMutableArray alloc]init];
    page = 1;
    _isEdit = NO;
    delete = NO;
    [self footRefreshing];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    
}


- (void)initializeInterface {
    
    NSLog(@"self.view.frame:%@",NSStringFromCGRect(self.view.frame));
    self.titleLabel.text = @"我上传的菜品";
    
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];

    self.rightButton.hidden = NO;
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    self.rightButton.tag = 500;
    [self.rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 ) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView addFooterWithTarget:self action:@selector(footRefreshing)];
    
    
    
//    deleteView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50)];
//    deleteView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:deleteView];
//    
//    deleteView.hidden = YES;
//    
//    allDeleteBtn = [[UIButton alloc]init];
//    allDeleteBtn.frame = CGRectMake(13, (50 - 24) / 2, 24, 24);
//    [allDeleteBtn setBackgroundImage:[UIImage imageNamed:@"choose-n"] forState:UIControlStateNormal];
//    allDeleteBtn.tag = 501;
//    [allDeleteBtn setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
//    [allDeleteBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [deleteView addSubview:allDeleteBtn];
    
//    deleteBtn = [[UIButton alloc]init];
//    deleteBtn.frame = CGRectMake(ScreenWidth - 10 - 150, (50 - 39) / 2, 150, 39);
//    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
//    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//    deleteBtn.tag = 502;
//    [deleteBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [deleteView addSubview:deleteBtn];

}


- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)buttonPressed:(UIButton *)sender {
    
    
    
//    [_tableView setEditing:YES animated:YES];
    
    if ((int)sender.tag == 500) {
       
        sender.selected = !sender.selected;
        deleteView.hidden  = sender.selected ? NO : YES;
        _isEdit = !_isEdit;
        [_tableView reloadData];

    }
    else if ((int)sender.tag == 501) {
        
        sender.selected = !sender.selected;
            
            
    }
    else if ((int)sender.tag == 502) {
        
        
    }
}

//数据刷新
- (void)footRefreshing {
    
    
    is_footer = YES;
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defautls objectForKey:@"tel"];
    NSString *pwd = [defautls objectForKey:@"pwd"];
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"page":[NSString stringWithFormat:@"%i",page]};
    [NetWorkHandler dishList:dict completionHandler:^(id content) {
        if ([content[@"status"] integerValue] == 1) {
            
            NSLog(@"dishList:%@",content);
            for (NSDictionary *dict in content[@"data"]) {
                [_dataSource addObject:dict];
            }
        }
        page += 1;
        [DisplayView displayShowWithTitle:content[@"info"]];
        [_tableView reloadData];
        [_tableView footerEndRefreshing];
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_dataSource count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CELLID = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.row,(long)indexPath.section];
    
    HadUploadMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[HadUploadMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    HadUploadMenuModel *model = [[HadUploadMenuModel alloc]initWithDicitonary:_dataSource[indexPath.section]];
    [cell setCellWithModel:model];
    
    __weak typeof(self) myself = self;
    cell.selectButton.selected = [_indexPaths containsObject:indexPath];
    [cell setButtonClick:^(HadUploadMenuTableViewCell *cell, BOOL addOrDelete,int tag) {

        cellIndexPath = [_tableView indexPathForCell:cell];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *tel = [defaults objectForKey:@"tel"];
        NSString *pwd = [defaults objectForKey:@"pwd"];
        _selectedUserID = _dataSource[indexPath.section][@"id"];
//        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"id":_selectedUserID};
        
        if (addOrDelete && tag == 98) {
            delete = addOrDelete;
            [_indexPaths addObject:indexPath];
           
            
//            [NetWorkHandler delDish:dict completionHandler:^(id content) {
//                NSLog(@"newDataSource:%@",content);
//            }];
            
            alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您将删除此菜品信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        else if (tag == 99) {
            
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"id":_selectedUserID};
            [NetWorkHandler setTopDish:dict completionHandler:^(id content) {
                [DisplayView displayShowWithTitle:content[@"info"]];
                NSLog(@"setTopDish:%@",content);
            }];
        }
        else  {
            
//            [_indexPaths removeObject:indexPath];
            
        }
//        else if (allDelete){
//            for (int i = 0; i < _dataSource.count; i ++) {
//                
//                ((HadUploadMenuTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]]).selectButton.selected = YES;
//                
//            }
//            [_dataSource removeAllObjects];
//            [_tableView reloadData];
//        }
        [_tableView setEditing:_tableView.editing animated:YES];
        
    }];
    
    
    CGPoint center = cell.myContentView.center;
    center.x = _isEdit ? ScreenWidth / 2 + 40 : ScreenWidth / 2;
    cell.myContentView.center = center;
        

    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}

//headerView 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}


#pragma mark -  确认编辑

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (delete) {
//        return UITableViewCellEditingStyleDelete;
//    }
//    return nil;
//    
//}

////这个方法用来告诉表格 这一行是否可以移动
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
////这个方法就是执行移动操作的
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)
//sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    NSUInteger fromRow = [sourceIndexPath row];
//    NSUInteger toRow = [destinationIndexPath row];
//    
//    id object = [_dataSource objectAtIndex:fromRow];
//    [_dataSource removeObjectAtIndex:fromRow];
//    [_dataSource insertObject:object atIndex:toRow];
//}

//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
//- (void)tableView:(UITableView *)tableView commitEditingStyle:
//(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSUInteger section = [indexPath section];
//        [_dataSource removeObjectAtIndex:section];
////        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [tableView reloadData];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [_dataSource removeObjectAtIndex:cellIndexPath.section];
        [_tableView reloadData];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *tel = [defaults objectForKey:@"tel"];
        NSString *pwd = [defaults objectForKey:@"pwd"];
        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"id":_selectedUserID};

        [NetWorkHandler delDish:dict completionHandler:^(id content) {
            
            NSLog(@"%@",content);
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    
    NSLog(@"dismiss");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
