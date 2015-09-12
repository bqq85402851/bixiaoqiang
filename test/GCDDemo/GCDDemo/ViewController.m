//
//  ViewController.m
//  GCDDemo
//
//  Created by 杨汉池 on 15/9/11.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //获取主队列 并行队列
    dispatch_queue_t main=dispatch_get_main_queue();
    
    
    //获取全局队列 串行队列 第一个参数优先级 第二个参数保留参数 占时设置为0
    //这种全局的队列有4种不同的优先级：high, default, low 和 background。XNU内核会管理全局队列用到的线程以及它们的优先级。当添加任务到一个全局队列的时候，要选择一个优先级适合的队列。XNU并不能保证线程的实时性，优先级只是用作一个参考。比如，如果你不太在乎一个任务是否会被执行，就应该用background这个优先级。
    dispatch_queue_t global=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    //自己创建的队列 第一个参数是队列的名字 第二个参数 并行为DISPATCH_QUEUE_CONCURRENT 串行为 NULL
    dispatch_queue_t myThreadOne=dispatch_queue_create("com.myOne", NULL);
    dispatch_queue_t myThreadTwo=dispatch_queue_create("com.myTwo", DISPATCH_QUEUE_CONCURRENT);

    #warning 主队列不能放在并行队列中 会造成线程死锁
    // dispatch_async为串行执行 dispatch_sync为并行队列
    dispatch_async(main, ^{
        self.view.backgroundColor=[UIColor redColor];
    });
    dispatch_sync(global, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    //这个函数主要用来为新创建的队列设置优先级。当用dispatch_queue_create函数创建一个队列后，无论创建的是并行队列还是串行队列，队列的优先级都和全局dispatch队列的默认优先级一样。创建队列后，你可以用这个函数来修改队列的优先级。
    //在下面代码中，dispatch_set_target_queue函数的第一个参数是要设置优先级的队列，第二个参数是一个全局的dispatch队列，它会被作为目标队列。这段代码会使队列拥有和目标队列一样的优先级(稍后会解释这里的机制)。
    dispatch_set_target_queue(myThreadOne, global);
    
    //dispatch_after一段时间后加入执行队列中
    //dis_time创建一个相对时间
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 3ull*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"三秒钟后执行");
    });
    
    NSDate*date=[NSDate dateWithTimeIntervalSinceNow:1000];
    
    NSLog(@"%llu",getDispatchTimeBydate(date));
    
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, global, ^{
        NSLog(@"1");
    });
    dispatch_group_async(group, global, ^{
        NSLog(@"2");
    });
    dispatch_group_async(group, global, ^{
        NSLog(@"3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"4");
    });

}
dispatch_time_t getDispatchTimeBydate(NSDate*date){
    NSTimeInterval interval;
    double second, subsecond;
    struct timespec time;
    dispatch_time_t milestone;

    interval = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime(&time, 0);
    
    return milestone;
    
}
void getATM (NSString*string){
    NSLog(@"%@",string);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
