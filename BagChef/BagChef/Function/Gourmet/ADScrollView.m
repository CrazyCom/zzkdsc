//
//  ADScrollView.m
//  MaiokStore
//
//  Created by maiok on 15/9/17.
//  Copyright (c) 2015年 maiok. All rights reserved.
//

#import "ADScrollView.h"
#import "UIImageView+WebCache.h"

@interface ADScrollView () <UIScrollViewDelegate> {

    UIScrollView *_scrollView;
    NSTimer *_timer;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    CGFloat _adMoveTime;
    BOOL _isDrawfirst;
}

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (assign,nonatomic,readonly) NSTimer *moveTimer;



// 获取实际图片展示索引
- (NSInteger)realIndexWithIndex:(NSInteger)index;


@end

@implementation ADScrollView
@synthesize moveTimer;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    _scrollView.frame = self.view.frame;
    _scrollView.clipsToBounds = YES;
    if (!_isDrawfirst) {
        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        [singleTapGestureRecognizer setNumberOfTapsRequired:1];
        [self addGestureRecognizer:singleTapGestureRecognizer];
        
        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
        [self addGestureRecognizer:doubleTapGestureRecognizer];
        //这行很关键，意思是只有当没有检测到doubleTapGestureRecognizer 或者 检测doubleTapGestureRecognizer失败，singleTapGestureRecognizer才有效
        [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
        _isDrawfirst = YES;
    }
    
}

+ (instancetype)adScrollViewWithFrame:(CGRect)frame block:(void(^)())block {
    
    ADScrollView *view = [[[NSBundle mainBundle] loadNibNamed:@"ADScrollView" owner:nil options:nil] firstObject];
    view.frame = frame;
    [view.view addSubview:view.scrollView];
    view.gesturePress = block;
    view->_adMoveTime = 3.0;
    
    return view;
}
- (void)singleTap:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"1111");
    self.gesturePress();
}

- (void)doubleTap:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"222");
    self.gesturePress();
}

- (void)processTimer:(NSTimer *)timer {
    
    BOOL isshoudAnimated = YES;
    // 判断是否超过最大索引位置，若超过则回到第一个索引位置
    if (++_currentIndex > [_dataSource count] ) {
        _currentIndex = 1;
        isshoudAnimated = NO;
    }
    
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds) * _currentIndex, 0)
                         animated:isshoudAnimated];
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.clipsToBounds = YES;
        _scrollView.frame = self.view.bounds;
        _scrollView.backgroundColor = UIColorFromRGB(0xfefefe);
        _scrollView.contentSize = self.scrollView.frame.size;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentOffset = CGPointZero;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
    }
    return _scrollView;
}
- (NSInteger)realIndexWithIndex:(NSInteger)index {
    
    // 获取最大索引
    NSInteger maximumIndex = [_dataSource count];
    // 判断真实索引位置
    if (index > maximumIndex) {
        index = 1;
    }
    else if (index < 0) {
        index = maximumIndex;

    }
    return index;
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    
    NSLog(@"dataSource:%@",dataSource);
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    [_dataSource removeAllObjects];
    for (NSString *url in dataSource) {
        [_dataSource addObject:url];
    }
    
    if (_dataSource.count >= 2) {
        
        [_dataSource insertObject:[_dataSource lastObject] atIndex:0]; //插入最后一个在第一个位置 把视图最后一个元素
        [_dataSource addObject:_dataSource[1]]; //放在最后一个位置 把视图弟0个元素
    }
   
    _currentIndex = 0;
    
    self.pageControl.currentPage = _currentIndex;
    self.pageControl.numberOfPages = [_dataSource count];
    
  
    _scrollView.contentSize = CGSizeMake(ScreenWidth * (_dataSource.count + 1), CGRectGetHeight(self.scrollView.bounds));
    
    for (int i = 0; i < [_dataSource count]; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds))];
       
        NSURL *ulr = [NSURL URLWithString:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",_dataSource[i][@"path"]]];
        // NSLog(@"图片----> %@",ulr);
        
        imageView.contentMode = UIViewContentModeScaleToFill;
       [imageView sd_setImageWithURL:ulr placeholderImage:[UIImage imageNamed:@"net_default_pic3"]];
        [_scrollView addSubview:imageView];
        
    }
    
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds) * 1, 0)
                         animated:YES];
}


// scrollview滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if ([scrollView isEqual:_scrollView]) {
        
        
        NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        if (index == [_dataSource count]-1) {
            [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds) * 1, 0)
                                 animated:NO];
            return;
        }
       
        if (index == _currentIndex) {
            return;
        } else
            if (index > _currentIndex) {
                _currentIndex = [self realIndexWithIndex:_currentIndex++];
                //+1
            } else {
                //-1
                _currentIndex = [self realIndexWithIndex:_currentIndex--];
                
            }
       
        _currentIndex = index;
        self.pageControl.currentPage = _currentIndex;
       
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (index == 0) {
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds) * 3, 0)
                             animated:NO];
    }
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [moveTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_adMoveTime]];
    }
    _isTimeUp = NO;

}

#pragma mark - System Method 这个方法会在子视图添加到父视图或者离开父视图时调用
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
    if (!newSuperview)
    {
        [self.moveTimer invalidate];
        moveTimer = nil;
    }
    else
    {
        [self setUpTime];
    }
}

- (void)setUpTime
{
    if (_isNeedCycleRoll&&_dataSource.count>=2)
    {
        moveTimer = [NSTimer scheduledTimerWithTimeInterval:_adMoveTime target:self selector:@selector(animalMoveImage:) userInfo:nil repeats:YES];
        _isTimeUp = NO;
    }
}
- (void)setIsNeedCycleRoll:(BOOL)isNeedCycleRoll
{
    _isNeedCycleRoll = isNeedCycleRoll;
    if (!_isNeedCycleRoll)
    {
        [moveTimer invalidate];
        moveTimer = nil;
    }
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage:(NSTimer *)time
{
    BOOL isshoudAnimated = YES;
    // 判断是否超过最大索引位置，若超过则回到第一个索引位置
    if (++_currentIndex > [_dataSource count] ) {
        _currentIndex = 1;
        isshoudAnimated = NO;
    }
    
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds) * _currentIndex, 0)
                         animated:isshoudAnimated];

   // [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds) * 2, 0) animated:YES];
    _isTimeUp = YES;

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [moveTimer invalidate];
    moveTimer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setUpTime];
}


- (void)dealloc {

    NSLog(@"当前释放了");
}




@end
