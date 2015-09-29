//
//  chosseVC.m
//  MiningGame
//
//  Created by 杨汉池 on 15/9/29.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "chosseVC.h"
#import "mainScreenVC.h"
@interface chosseVC ()
{
    NSInteger color;
}
@property (weak, nonatomic) IBOutlet UIImageView *personView;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation chosseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    color=1;
}
- (IBAction)last:(UIButton *)sender {
    color--;
    if (color==0) {
        color=1;
    }
    if (color>4) {
        color=1;
    }
    self.personView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld",color]];

}
- (IBAction)next:(UIButton *)sender {
    color++;
    if (color==0) {
        color=1;
    }
    if (color>4) {
        color=1;
    }
    self.personView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",color]];
}
- (IBAction)throughButton:(UIButton *)sender {
    [self presentViewController:[[mainScreenVC alloc]init] animated:YES completion:^{
        
    }];
}
- (IBAction)adventureButton:(UIButton *)sender {
    [self presentViewController:[[mainScreenVC alloc]init] animated:YES completion:^{
        
    }];
}
- (IBAction)returnButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
