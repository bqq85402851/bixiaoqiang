//
//  mainScreenVC.m
//  MiningGame
//
//  Created by 杨汉池 on 15/9/29.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "mainScreenVC.h"
#define SCALE [[UIScreen mainScreen]bounds].size.width/320.0
@interface mainScreenVC ()
{
    NSInteger count;
}
@property(nonatomic)UIScrollView*mainView;
@end

@implementation mainScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMainView];
}
-(void)setMainView{
    self.mainView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mainView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.mainView];
    
    int count=40;
    int tag=0;
    CGFloat width=self.view.frame.size.width/5.0;
    for (int y=0; y<count/5; y++) {
        for (int x=0; x<5; x++) {
            UIImageView*land=[[UIImageView alloc]initWithFrame:CGRectMake(x*width, 150+y*width, width, width)];
            land.backgroundColor=[UIColor yellowColor];
            land.layer.borderColor=[UIColor blackColor].CGColor;
            land.layer.borderWidth=0.5;
            land.tag=100+tag;
            tag++;
            [self.mainView addSubview:land];
        }
    }
    self.mainView.contentSize=CGSizeMake(0,(count/5.0)*width+150);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
