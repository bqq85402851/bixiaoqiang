//
//  ViewController.m
//  iPhoneModel
//
//  Created by 杨汉池 on 15/9/23.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "ViewController.h"
#import <sys/utsname.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel*labelOne=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, self.view.frame.size.width-25, 30)];
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    labelOne.text=[NSString stringWithFormat:@"设备名称: %@",deviceName];
    [self.view addSubview:labelOne];
    
    UILabel*labelTwo=[[UILabel alloc]initWithFrame:CGRectMake(50, 90, self.view.frame.size.width-25, 30)];
    NSString* phoneModel = [[UIDevice currentDevice] model];
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    labelTwo.text=[NSString stringWithFormat:@"国际化区域名称:%@",localPhoneModel];
    [self.view addSubview:labelTwo];
    
    UILabel*labelThree=[[UILabel alloc]initWithFrame:CGRectMake(50, 150, self.view.frame.size.width-25, 30)];
    NSString*phoneName=[[UIDevice currentDevice]name];
    labelThree.text=[NSString stringWithFormat:@"%@",[self deviceString]];
    [self.view addSubview:labelThree];
}
- (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
