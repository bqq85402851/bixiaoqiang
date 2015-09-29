//
//  ViewController.h
//  GeTui
//
//  Created by 杨汉池 on 15/9/21.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(nonatomic,copy)NSString*clientId;
@property(nonatomic,copy)NSString*token;
@property(nonatomic,copy)NSString*record;
-(void)showRecord:(NSString*)record;
@end
