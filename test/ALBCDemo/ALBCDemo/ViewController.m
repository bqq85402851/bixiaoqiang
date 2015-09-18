//
//  ViewController.m
//  ALBCDemo
//
//  Created by 杨汉池 on 15/9/12.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "ViewController.h"
#import <TAESDK/TAESDK.h>
#import <ALBBTradeSDK/ALBBCartService.h>
#import <ALBBTradeSDK/ALBBItemService.h>
#import <ALBBTradeSDK/ALBBOrderService.h>
#import <ALBBTradeSDK/ALBBPromotionService.h>

#define GOOD_URL @"https://detail.tmall.com/item.htm?spm=a222t.19413.2653790741.1.Qtb2nv&id=521788751645&acm=lb-zebra-19414-263111.1003.4.408835&scm=1003.4.lb-zebra-19414-263111.ITEM_521788751645_408835"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) id<ALBBItemService> itemService;
@property(nonatomic, strong) id<ALBBOrderService> orderService;
@property(nonatomic, strong) id<ALBBCartService> cartService;
@property(nonatomic, strong) id<ALBBPromotionService> promotionService;

@property(nonatomic, strong) tradeProcessSuccessCallback tradeProcessSuccessCallback;
@property(nonatomic, strong) tradeProcessFailedCallback tradeProcessFailedCallback;
@property(nonatomic, strong) addCartCacelledCallback addCartCacelledCallback;
@property(nonatomic, strong) addCartSuccessCallback addCartSuccessCallback;
@property(nonatomic)NSArray*dataArray;
@property(nonatomic)UITableView*tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addData];
    [self addTableView];
    _itemService=[[TaeSDK sharedInstance]getService:@protocol(ALBBItemService)];
    _orderService=[[TaeSDK sharedInstance] getService:@protocol(ALBBOrderService)];
    _cartService=[[TaeSDK sharedInstance] getService:@protocol(ALBBCartService)];
    _promotionService=[[TaeSDK sharedInstance] getService:@protocol(ALBBPromotionService)];
    
    _tradeProcessSuccessCallback=^(TaeTradeProcessResult*tradeProcessResult){
                NSString *tip=[NSString stringWithFormat:@"交易成功:成功的订单%@\n，失败的订单%@\n",tradeProcessResult.paySuccessOrders,tradeProcessResult.payFailedOrders];
        NSLog(@"%@",tip);
    };
    _tradeProcessFailedCallback=^(NSError *error){
        NSString *tip=[NSString stringWithFormat:@"交易失败:\n%@",error];
        NSLog(@"%@", tip);
    };
    
    _addCartCacelledCallback=^(){
        NSLog(@"加入失败");
    };
    _addCartSuccessCallback=^(){
        NSLog(@"加入成功");
    };

}
#pragma mark -初始化TableView
-(void)addTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
}
#pragma mark -UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellID=@"xxx";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text=[self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            [self showPage];
            break;
        }
        case 1:{
            [self showPageWithCallback];
            break;
        }
        default:
            break;
    }
}
#pragma mark -UITableView数据初始化
-(void)addData{
    self.dataArray=@[@"商品页(url/无回调)",@"商品页(url/有回调)"];
}
#pragma mark - 接口调用
//Page页面展示，没有回调
-(void)showPage{
    [_itemService showPage:self.navigationController isNeedPush:YES openUrl:GOOD_URL];
}
//Page页面展示，有回调
-(void)showPageWithCallback{
    TaeWebViewUISettings*settings=[[TaeWebViewUISettings alloc]init];
   // settings.titleColor=[UIColor yellowColor];
    settings.tintColor=[UIColor purpleColor];
    settings.barTintColor=[UIColor whiteColor];
    
    [_itemService showPage:self isNeedPush:NO pageUrl:GOOD_URL webViewUISettings:settings tradeProcessSuccessCallback:_tradeProcessSuccessCallback tradeProcessFailedCallback:_tradeProcessFailedCallback];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
