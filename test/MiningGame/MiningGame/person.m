//
//  person.m
//  MiningGame
//
//  Created by 杨汉池 on 15/9/29.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "person.h"

@implementation person

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawRect:(CGRect)rect{
    self.image=[UIImage imageNamed:@"矿工"];
    CGFloat scale=rect.size.width/415.0;
    self.tool=[[UIImageView alloc]initWithFrame:CGRectMake(125*scale, 340*scale, 150*scale, 137*scale)];
    self.tool.image=[UIImage imageNamed:@"矿锄"];
    self.tool.hidden=YES;
    [self addSubview:self.tool];
}
-(void)rotation{
    self.tool.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.tool.transform=CGAffineTransformMakeRotation(3.14);
    } completion:^(BOOL finished) {
        self.tool.hidden=YES;
    }];
}
@end
