//
//  ViewController.m
//  GeTui
//
//  Created by 杨汉池 on 15/9/21.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel*oneLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, self.view.frame.size.width-100, 30)];
    oneLabel.backgroundColor=[UIColor lightGrayColor];
    oneLabel.textColor=[UIColor redColor];
    oneLabel.text=@"默认";
    if (self.token) {
        oneLabel.text=[NSString stringWithFormat:@"token:%@",self.token];
    }
    [self.view addSubview:oneLabel];
    
    UILabel*twoLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 90,  self.view.frame.size.width-100, 30)];
    twoLabel.backgroundColor=[UIColor lightGrayColor];
    twoLabel.textColor=[UIColor redColor];
    if (self.clientId) {
        twoLabel.text=[NSString stringWithFormat:@"clientId:%@",self.clientId];
    }
    [self.view addSubview:twoLabel];
}
-(void)showRecord:(NSString *)record{
    UILabel*threeLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 150, self.view.frame.size.width-100, 30)];
    threeLabel.backgroundColor=[UIColor lightGrayColor];
    threeLabel.textColor=[UIColor redColor];
    [threeLabel setText:[NSString stringWithFormat:@"record:%@",record]];
    [self.view addSubview:threeLabel];
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
