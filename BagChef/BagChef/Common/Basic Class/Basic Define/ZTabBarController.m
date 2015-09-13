//
//  ZTabBarController.m
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "ZTabBarController.h"
#define NumberOfTabBar 3
#define ArrayImage @[@"privatechef_u",@"gourmet_u",@"armedescort_u"]
#define ArrayImageSelected @[@"privatechef_s",@"gourmet_s",@"armedescort_s"]
#define TabNameArray @[@"吃货",@"私厨",@"镖师"]
@interface ZTabBarController ()

@end


@implementation ZTabBarController

@synthesize currentSelectedIndex;
@synthesize bgView;
@synthesize redPoints;


- (id)init
{
    if (self) {
        // Custom initialization
        self.tabType = TabTypeName;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    UIButton *button = (UIButton *)[self.view viewWithTag:0];
//    [self.view bringSubviewToFront:button];
}

- (void)viewDidLoad

{
    [super viewDidLoad];
// Do any additional setup after loading the view.
    //隐藏父类tabBar
    [self setHideEsunTabBar:YES];
    
    //
//    [self setHideEsunTabBarBtn:NO];
    [self showTabBarButtonName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *隐藏父类的view
 */
- (void)setHideEsunTabBar:(BOOL)hide
{
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = hide;
            break;
        }
    }
}

/*
 *隐藏本类的Btn
 */
- (void)setHideEsunTabBarBtn:(BOOL)hide
{
    CGFloat height = 0;
    if(hide)
    {
        height = 0;
        for(UIButton *btn in self.btnArray)
        {
            CGRect frame = btn.frame;
            frame.size.height = height;
            btn.frame = frame;
        }
        CGRect frame = self.bgView.frame;
        
        frame.size.height = height;
        self.bgView.frame = frame;
        bgView.backgroundColor = [UIColor clearColor];
        bgView.hidden = YES;
    }
    else
    {
        height = 49;
        for (int i = 0; i<[self.btnArray count]; i++)
        {
            UIButton *btn = [self.btnArray objectAtIndex:i];
            CGRect frame = btn.frame;
            frame.size.height = height;
//            if (i == 2)
//            {
//                frame.size.height = 65;
//                frame.size.width = 65;
//                btn.layer.cornerRadius = 65/2;
//            }
            btn.frame = frame;
            CGRect bgframe = self.bgView.frame;
            bgframe.size.height = height;
            self.bgView.frame = bgframe;
            bgView.backgroundColor = [UIColor clearColor];
            bgView.hidden = NO;
        }
    }
}
//用索引改变状态
- (void)tabbarSelectIndex:(int)index
{
    UIButton *button = [self.btnArray objectAtIndex:index];
    [self tabbarSelectBtn:button];
}

- (void)setHideRedPoint:(BOOL)hide index:(NSInteger)index {
    
    UIView *redPoint = redPoints[index];
    [redPoint setHidden:hide];
}

/*
 *设置btn选中
 */
- (void)tabbarSelectBtn:(UIButton *)button
{
    UIButton *btn = [self.btnArray objectAtIndex:self.currentSelectedIndex];
    btn.selected = NO;
    button.selected = YES;
    self.currentSelectedIndex = button.tag;
    self.selectedIndex = button.tag;
}

//图片文字模式
- (void)showTabBarButtonName
{
    
    redPoints = [[NSMutableArray alloc] init];
    self.btnArray = [[NSMutableArray alloc] initWithCapacity:5];
    bgView = [[UIView alloc] init];
//    bgView.backgroundColor = [UIColor clearColor];
//    bgView.image = GET_IMAGE(@"tabBarImage.png");
//    bgView.image = [UIImage imageNamed:@"footerImage"];
    bgView.alpha = 1.0;
//    bgView.alpha = 0.5;
//    bgView.alpha = 1.0;
    bgView.contentMode = UIViewContentModeScaleAspectFit;
//    bgView.backgroundColor = [UIColor whiteColor];
//    bgView.clipsToBounds = NO;
//    bgView.userInteractionEnabled = YES;
    bgView.frame = CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49);
    [self.view addSubview:bgView];
    
//    添加tabBar黑线
    UILabel *line = [[UILabel alloc]init];
    line.frame = CGRectMake(0, 0.5, ScreenWidth, 0.5);
    line.backgroundColor = [UIColor colorWithRed:0.694f green:0.694f blue:0.694f alpha:1.00f];
    [bgView addSubview:line];
    
    NSArray *arr = ArrayImage;
    NSArray *arrSelect = ArrayImageSelected;
    NSArray *nameArray = TabNameArray;
    double _width = ScreenWidth / [nameArray count];
    for (int i = 0; i < arrSelect.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        btn.clipsToBounds = YES;
        btn.userInteractionEnabled = YES;
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(tabbarSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
//        if (i == 2)
//        {
//            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//            btn.bounds = CGRectMake(0, 0, 65, 65);
//            btn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(self.bgView.frame) - 26 + 3);
//            btn.layer.borderWidth = 2.0;
//            btn.layer.borderColor = [UIColor colorWithRed:66 / 255.0 green:150 / 255.0 blue:235 / 255.0 alpha:1.0].CGColor;
//            btn.layer.cornerRadius = CGRectGetHeight(btn.bounds) / 2.0;
//            btn.backgroundColor = [UIColor colorWithRed:0.969f green:0.969f blue:0.969f alpha:1.00f];
//            btn.clipsToBounds = YES;
//            UIImageView *imageView = [[UIImageView alloc] init];
//            imageView.bounds = CGRectMake(0, 0, CGRectGetWidth(btn.frame)-10, CGRectGetHeight(btn.frame) - 24);
//            imageView.center = CGPointMake(CGRectGetWidth(btn.frame) / 2.0, CGRectGetHeight(btn.frame) / 2.0);
//            imageView.image = [UIImage imageNamed:@"saomiao"];
//            imageView.layer.cornerRadius = CGRectGetWidth(btn.frame) / 2;
//            [btn addSubview:imageView];
//            
//        }
//        else
//        {
            [btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:arrSelect[i]] forState:UIControlStateSelected];
        
            [btn setTitle:nameArray[i] forState:UIControlStateNormal];
            btn.frame = CGRectMake(i*_width ,0, _width, 53);
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.251f blue:0.000f alpha:1.00f] forState:UIControlStateSelected];
            btn.imageEdgeInsets = UIEdgeInsetsMake(5, 20, 20, 20);
//            if (ScreenWidth == 320) {
//                btn.titleEdgeInsets = UIEdgeInsetsMake(30, -25, 0, 0);
//            }
//            else {
                btn.titleEdgeInsets = UIEdgeInsetsMake(30, -50, 0, 0);
//            }
        
//        }
        [self.btnArray addObject:btn];
        [self.bgView  addSubview:btn];
       
        UIView *redPoint = [[UIView alloc] init];
        redPoint.frame = CGRectMake(CGRectGetWidth(btn.frame) - 20, 5, 8, 8);
        redPoint.backgroundColor = [UIColor redColor];
        redPoint.userInteractionEnabled = YES;
        redPoint.layer.cornerRadius = 8/2;
        redPoint.hidden = YES;
        [redPoints addObject:redPoint];
        [btn addSubview:redPoint];
        
        UILabel *numLabel = [[UILabel alloc]init];
        numLabel.frame = CGRectMake(CGRectGetWidth(btn.frame) - 20, 5, 8, 8);
        numLabel.backgroundColor = [UIColor redColor];
        numLabel.font = [UIFont systemFontOfSize:10];
        numLabel.hidden = YES;
        [btn addSubview:numLabel];
    }
    [self tabbarSelectBtn:[self.btnArray objectAtIndex:0]];
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
