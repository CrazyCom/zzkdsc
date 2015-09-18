//
//  GourmetViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/7/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "GourmetViewController.h"
#import "GourmetCell.h"
#import "HomePageOfPrivateChef.h"
#import "MenuListOfDetailViewController.h"
#import <BaiduMapAPI/BMapKit.h>

@interface GourmetViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate,UISearchResultsUpdating,BMKLocationServiceDelegate> {
    
    UITableView *_tableView;
    UISearchBar *_searchBar;
    UITextField *_searchField;
    
    //搜索条
    UIImageView *searchView;
    //搜索图片
    UIImageView *searchIcon;
    
    //UISearchController *_searchController;
    UISearchDisplayController *_searchDisplayController;
    NSMutableArray *_currentSource;
    NSMutableArray *_dataSource;
    NSMutableArray *_searchArray;
    
    NSMutableArray *_visableArray;
    int page;
    
    //定位
    BMKLocationService *_locationService;
    
    CGRect framenum1;
    CGRect framenum2;
}


- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation GourmetViewController

- (void)initializeDataSource {
    
    page = 1;
    _dataSource = [[NSMutableArray alloc]init];
    _searchArray = [[NSMutableArray alloc] init];
    _locationService = [[BMKLocationService alloc]init];
    _visableArray = _dataSource;
    [self footRefreshing];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeInterface];
    
    //    [self showLoading];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:NO];
    dvc.mainNavController.navigationBarHidden = YES;
    
    page = 1;
    [self footRefreshing];
    
    _locationService.delegate = self;
    [_locationService startUserLocationService];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    _locationService.delegate = self;
}

- (void)initializeSearch {
    
    //  searchField.textColor = [UIColor whiteColor];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.bounds), 44)];
    tableHeaderView.backgroundColor = [UIColor redColor];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:tableHeaderView.bounds];
    // 配置委托对象
    searchBar.delegate = self;
    // 配置显示类型
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    // 配置占位符
    searchBar.placeholder = @"搜索";
    searchBar.tintColor = [UIColor redColor];
    //   [searchBar setSearchFieldBackgroundPositionAdjustment:UIOffsetMake(-200, 0)];// 设置搜索框中文本框的背景的偏移量
    //  [searchBar setSearchTextPositionAdjustment:UIOffsetMake(30, 0)];// 设置搜索框中文本框的文本偏移量
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    [tableHeaderView addSubview:searchBar];
    
    
    // searbar关联tableview
    _tableView.tableHeaderView = tableHeaderView;
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar
                                                                 contentsController:self];
    _searchDisplayController.searchResultsDelegate = self;
    _searchDisplayController.searchResultsTableView.backgroundColor = [UIColor lightGrayColor];
    _searchDisplayController.searchResultsDataSource = self;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    [_searchDisplayController setActive:YES animated:YES];
//       [UIView animateWithDuration:0.25f animations:^{
//        _tableView.frame = framenum2;
//    }];
    
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [_searchDisplayController setActive:NO animated:YES];
//    UIView *view = [[UIView alloc] initWithFrame:framenum1];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view];
//    
//    [UIView animateWithDuration:0.3f animations:^{
//        _tableView.frame = framenum1;
//        ;
//    } completion:^(BOOL finished) {
//        [view removeFromSuperview];
//    }];
    
    
}
-(void)initializeInterface {
    
    framenum1 = CGRectMake(0, 64, ScreenWidth, ScreenHeight  - 64 - 49);
    framenum2 = CGRectMake(0, 20, ScreenWidth, ScreenHeight - 49 - 20);
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"我是吃货";
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight  - 64 - 49) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self initializeSearch];
    //下拉刷新
    [_tableView addFooterWithTarget:self action:@selector(footRefreshing)];
    
    //搜索栏
    //    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //    _searchController.searchResultsUpdater = self;
    //    _searchController.dimsBackgroundDuringPresentation = NO;
    //    _searchController.searchBar.delegate = self;
    //    _searchController.hidesNavigationBarDuringPresentation = NO;
    //    _searchController.searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x, _searchController.searchBar.frame.origin.y, _searchController.searchBar.frame.size.width, 44.0);
    //    _tableView.tableHeaderView = _searchController.searchBar;
    
    _currentSource = _dataSource;
}

- (void)fileDataSource:(NSString *)searchText {
    
    [_searchArray removeAllObjects];
    for (NSDictionary *dic in _dataSource) {
        
        if ([dic[@"nicename"] containsString:searchText]) {
            
            [_searchArray addObject:dic];
            
        }
        
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self fileDataSource:searchText];
    _currentSource = _searchArray;
    [_tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    _currentSource = _dataSource;
    [_tableView reloadData];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //    if (!_visableArray || _visableArray.count !=0) {
    //        return _dataSource.count;
    //    }
    //    else {
    //        return _visableArray.count;
    //    }
    return _currentSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellID";
    GourmetCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[GourmetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    //    cell.nameLabel.text = _currentSource[indexPath.section][@"nicename"];
    NSLog(@"%@",_dataSource[indexPath.section]);
    GourmetViewModel *model = [[GourmetViewModel alloc]initWithDicitonary:_currentSource[indexPath.section]];
    [cell setCellWithModel:model];
    
    
//    if (_searchController.active) {
//        
//    }
    __weak GourmetViewController * gourmentVC = self;
    cell.sendBtn = ^(GourmetCell *cell , int tag) {
        
        if (tag >= 30 && tag < 33) {
            
            MenuListOfDetailViewController *mvc = [[MenuListOfDetailViewController alloc]initWithDishId: _dataSource[[tableView indexPathForCell:cell].section][@"top"][tag - 30][@"id"]];
            [gourmentVC.navigationController pushViewController:mvc animated:YES];
            
        }
        else if (tag == 60) {
            
            HomePageOfPrivateChef *hvc = [[HomePageOfPrivateChef alloc]initWithUserId: _dataSource[[tableView indexPathForCell:cell].section][@"uid"]];
            [gourmentVC.navigationController pushViewController:hvc animated:YES];
        }
    };
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *filterString = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@",filterString];
    _visableArray = [NSMutableArray arrayWithArray:[_dataSource filteredArrayUsingPredicate:predicate]];
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        return 0.1;
    }
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_dataSource[indexPath.section][@"top"] isKindOfClass:[NSNull class]]) {
        return 140 * ratioY;
        
    }
    else {
        
        return 235 * ratioY;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        //        UIView *headerView = [[UIView alloc]init];
        //        headerView.frame = CGRectMake(0, 64, ScreenWidth, 53);
        //        headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
        //
        //        //搜索条
        //        searchView = [[UIImageView alloc]init];
        //        [searchView setFrame:CGRectMake(8, 11, ScreenWidth - 16, 29)];
        //        [searchView setUserInteractionEnabled:YES];
        //        [searchView setImage:[UIImage imageNamed:@"searchbg_home_"]];
        //        [headerView addSubview:searchView];
        //
        //        searchIcon = [[UIImageView alloc]init];
        //        [searchIcon setFrame:CGRectMake((ScreenWidth - 16) / 2 - 13.5, 10, 13.5, 13.5)];
        //        [searchIcon setImage:[UIImage imageNamed:@"search"]];
        //        [searchView addSubview:searchIcon];
        //
        //        _searchField = [[UITextField alloc]init];
        //        [_searchField setFrame:CGRectMake(CGRectGetMaxX(searchIcon.frame) + 8, CGRectGetMinY(searchView.frame) - 7, 100, CGRectGetHeight(searchView.frame))];
        //        [_searchField setPlaceholder:@"搜索"];
        //        [_searchField setReturnKeyType:UIReturnKeySearch];
        //        [_searchField setFont:[UIFont fontWithName:@"迷你简准圆" size:12]];
        //        [_searchField setDelegate:self];
        //        [searchView addSubview:_searchField];
        return nil;
        
        
        
    }
    else {
        
        UIView *headerView = [[UIView alloc]init];
        [headerView setBounds:CGRectMake(0, 0, ScreenWidth, 11)];
        [headerView setBackgroundColor:[UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f]];
        return headerView;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}


//#pragma mark - UITextFieldDelegate
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//
//    [_searchField resignFirstResponder];
//}
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//
//    NSLog(@"11");
////    _searchField
//    searchIcon.frame = CGRectMake(10, 11, 13.5, 13.5);
//    _searchField.frame = CGRectMake(31, 5, ScreenWidth - 62, 29);
//    return YES;
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//
//    [textField resignFirstResponder];
//    searchIcon.frame = CGRectMake((ScreenWidth - 16) / 2 - 13.5, 10, 13.5, 13.5);
//    _searchField.frame = CGRectMake(CGRectGetMaxX(searchIcon.frame) + 8, CGRectGetMinY(searchView.frame) - 7, 100, CGRectGetHeight(searchView.frame));
//    return YES;
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <数据加载>
#pragma mark 下拉刷新
//数据刷新
- (void)footRefreshing {
    
    if ([AppDelegate app].lat == nil && [AppDelegate app].lon == nil) {
        
        _locationService.delegate = self;
        [_locationService startUserLocationService];
    }
    else {
        
        NSDictionary *dict = @{@"lat":[AppDelegate app].lat,@"lon":[AppDelegate app].lon,@"page":[NSString stringWithFormat:@"%i",page]};
        
        if (![AppDelegate app].lat) {
            return;
        }
        
        NSLog(@"%@",dict);
        __weak typeof(self)myself = self;
        [myself showLoading];
        
        [NetWorkHandler getChefList:dict completionHandler:^(id content) {
            //            [_dataSource removeAllObjects];
            if ([content isKindOfClass:[NSError class]]) {
                [myself hideLoading];
                [DisplayView displayShowWithTitle:@"连接超时"];
                [_tableView footerEndRefreshing];
                return ;
            }
            else {
                
                NSLog(@"%@",content);
                [myself hideLoading];
                if (![content isKindOfClass:[NSDictionary class]]) {
                    [DisplayView displayShowWithTitle:@"连接超时"];
                    [_tableView footerEndRefreshing];
                    return ;
                }
                else  if ([content[@"status"] integerValue] == 1) {
                    if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                        
                        [_tableView footerEndRefreshing];
                        [DisplayView displayShowWithTitle:@"没有多余数据"];
                        return ;
                    }
                    for (NSMutableArray *dict in content[@"data"]) {
                        [_dataSource addObject:dict];
                    }
                    NSLog(@"_dataSource:%@",_dataSource);
                    page += 1;
                    [_tableView reloadData];
                }
                [DisplayView displayShowWithTitle:content[@"info"]];
                [_tableView footerEndRefreshing];
            }
        }];
    }
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [AppDelegate app].lat = [NSString stringWithFormat:@"%lf",userLocation.location.coordinate.latitude] ;
    [AppDelegate app].lon = [NSString stringWithFormat:@"%lf",userLocation.location.coordinate.longitude] ;
    
    static int i = 0;
    if (i++ == 0) {
        [self footRefreshing];
    }
    
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
