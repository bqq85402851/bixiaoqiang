//
//  loginVC.m
//  MiningGame
//
//  Created by 杨汉池 on 15/9/29.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "loginVC.h"
#import "chosseVC.h"
@interface loginVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
- (IBAction)loginButton:(UIButton *)sender {
    if ([self.accountField.text isEqualToString:@"123"]||[self.passwordField.text isEqualToString:@"123"]) {
        chosseVC*cvc=[[chosseVC alloc]init];
       [self presentViewController:cvc animated:YES completion:^{
           
       }];
    }else{
        UIAlertView*alterView=[[UIAlertView alloc]initWithTitle:@"登陆失败" message:@"请重新登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alterView show];
    }
}
- (IBAction)registerButton:(UIButton *)sender {
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
