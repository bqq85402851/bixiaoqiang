//
//  person.h
//  MiningGame
//
//  Created by 杨汉池 on 15/9/29.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface person : UIImageView
@property(nonatomic)UIImageView*tool;
/**矿锄旋转*/
-(void)rotation;
@end
