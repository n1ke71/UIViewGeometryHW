//
//  ViewController.m
//  UIViewGeometryHW
//
//  Created by Ivan Kozaderov on 19.02.2018.
//  Copyright © 2018 Ivan Kozaderov. All rights reserved.
//

#import "ViewController.h"
//#define PUPIL
#define STUDENT
#define MASTER
#define SUPERMAN
@interface ViewController ()
@property(nonatomic,weak) UIView* deskView;
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSMutableArray *pointArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
#ifdef PUPIL
    
    CGRect rect = CGRectMake(51.75,CGRectGetMidY(self.view.frame) / 2,51.75,51.75);

    for (int j = 1; j < 9; j++) {
        
        for (int i = 1; i < 5; i++) {
            
            UIView* view = [[UIView alloc] initWithFrame:rect];
            view.backgroundColor = [UIColor blackColor];
            [self.view addSubview:view];
            
            rect.origin.x+=103;
            
        }
        rect.origin.y+=51.75;
        
        if (j%2) { //even
            
            rect.origin.x=1;
            
        }
        else {
            
            rect.origin.x=51.75;
            
        }
    }
    
#endif

#ifdef STUDENT

    self.array      = [NSMutableArray array];
    self.pointArray = [NSMutableArray array];
    
    CGRect rect = CGRectMake(CGRectGetMinX(self.view.frame),CGRectGetMidY(self.view.frame) / 2, 414, 414);
    
    UIView* view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor orangeColor];
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                            UIViewAutoresizingFlexibleTopMargin  | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:view];
    
    self.deskView = view;
    self.deskView.center = self.view.center;
    
    CGRect rect1 = CGRectMake(CGRectGetMinX(self.deskView.bounds)+ 51.75,CGRectGetMinY(self.deskView.bounds) ,51.75,51.75);
    

    for (int j = 1; j < 9; j++) {
        
        for (int i = 1; i < 5; i++) {
            
            UIView* view1 = [[UIView alloc] initWithFrame:rect1];
            view1.backgroundColor = [UIColor blackColor];
            view1.tag = 1;
            [self.deskView addSubview:view1];
            rect1.origin.x+=103;
            
            if (j < 4) {
               
                [self addCheckersTo:self.deskView inView:view1 withColor:[UIColor whiteColor]];
            }
            else if (j > 5){
                
                [self addCheckersTo:self.deskView inView:view1 withColor:[UIColor redColor]];
                
            }
            
        }
        rect1.origin.y+=51.75;
        
        if (j%2) { //even
            
            rect1.origin.x=1;
            
        }
        else {
            
            rect1.origin.x=51.75;
            
        }
    }
 
#endif
    
    // Do any additional setup after loading the view, typically from a nib.
}
#ifdef MASTER

-(UIColor*)randomColor{
    
    CGFloat r = (float)(arc4random()%256)/255;
    CGFloat g = (float)(arc4random()%256)/255;
    CGFloat b = (float)(arc4random()%256)/255;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    NSLog(@"rotation");
    self.view.backgroundColor = [self randomColor];
    UIColor* color = [self randomColor];
    NSMutableArray* mar = [NSMutableArray array];
    for (UIView* view in [self.deskView subviews]) {
        
        if(view.tag == 1) {
            
            view.backgroundColor = color;
        }
        else {

         [mar addObject:view];
         [self.array addObject:[NSValue valueWithCGPoint:view.frame.origin]];
         [view removeFromSuperview];
    
        }
    }
    
    for (UIView* view in mar) {
        
        CGPoint p = [self randPointFromArray:self.array];
        CGSize size = view.frame.size;
        CGRect rect = CGRectMake(p.x, p.y, size.width, size.height);
        UIView* tempView = [[UIView alloc] initWithFrame:rect];
        tempView.backgroundColor = view.backgroundColor;
        [self.deskView addSubview:tempView];

    }

}
#endif

#ifdef SUPERMAN

-(CGPoint) randPointFromArray:(NSMutableArray*) array{
    
    unsigned int number = (unsigned int)[array count];
    unsigned int index = arc4random_uniform(number);
    CGPoint point = [[array objectAtIndex:index] CGPointValue];
    [array removeObjectAtIndex:index];
    return point;
    
}
#endif

-(void) addCheckersTo:(UIView*)view inView:(UIView*) pointInView withColor:(UIColor*) color{
    
    UIView*v = [[UIView alloc]initWithFrame:CGRectMake(pointInView.center.x - 10, pointInView.center.y - 10, 20, 20)];
    v.backgroundColor = color;
    [view addSubview:v];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
