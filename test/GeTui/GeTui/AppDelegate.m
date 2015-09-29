//
//  AppDelegate.m
//  GeTui
//
//  Created by 杨汉池 on 15/9/21.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "AppDelegate.h"
#import "GeTuiSdk.h"
#import "GeTuiSdkError.h"
#import "ViewController.h"

#define app_id @"Lg6fXrC8Gy8JsFqH5rYIgA"
#define app_key @"nhtg8MnnTS9FUOwXjkaEe7"
#define app_secret @"oih1Q5w81y6T38JJr0teu1"

NSString* const NotificationCategoryIdent  = @"ACTIONABLE";
NSString* const NotificationActionOneIdent = @"ACTION_ONE";
NSString* const NotificationActionTwoIdent = @"ACTION_TWO";
@interface AppDelegate ()<GeTuiSdkDelegate>
{
    ViewController*_viewController;
    NSString*_deviceToken;
    NSString*_clientId;
    NSString*_payloadId;
}
@end

@implementation AppDelegate
- (void)registerRemoteNotification {
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //IOS8 新的通知机制category注册
        UIMutableUserNotificationAction *action1;
        action1 = [[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeBackground];
        [action1 setTitle:@"取消"];
        [action1 setIdentifier:NotificationActionOneIdent];
        [action1 setDestructive:NO];
        [action1 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationAction *action2;
        action2 = [[UIMutableUserNotificationAction alloc] init];
        [action2 setActivationMode:UIUserNotificationActivationModeBackground];
        [action2 setTitle:@"回复"];
        [action2 setIdentifier:NotificationActionTwoIdent];
        [action2 setDestructive:NO];
        [action2 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationCategory *actionCategory;
        actionCategory = [[UIMutableUserNotificationCategory alloc] init];
        [actionCategory setIdentifier:NotificationCategoryIdent];
        [actionCategory setActions:@[action1, action2]
                        forContext:UIUserNotificationActionContextDefault];
        
        NSSet *categories = [NSSet setWithObject:actionCategory];
        UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                        UIUserNotificationTypeSound|
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|
                                                                       UIRemoteNotificationTypeSound|
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|
                                                                   UIRemoteNotificationTypeSound|
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    _viewController=[[ViewController alloc]init];
    self.window.rootViewController=_viewController;
    [self.window makeKeyAndVisible];
    
    [self startSdkWith:app_id appKey:app_key appSecret:app_secret];
    [self registerRemoteNotification];

    NSDictionary*message=[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        NSString*payloadMsg=[message objectForKey:@"payload"];
        NSString*record=[NSString stringWithFormat:@"APN%@,%@",[NSDate date],payloadMsg];
        [_viewController showRecord:record];
    }
    return YES;
}
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret {
    NSError *err = nil;
    //[1-1]:通过 AppId、 appKey 、appSecret 启动 SDK
    [GeTuiSdk startSdkWithAppId:appID appKey:appKey appSecret:appSecret delegate:self error:&err];
    //[1-2]:设置是否后台运行开关
    [GeTuiSdk runBackgroundEnable:YES];
    //[1-3]:设置地理围栏功能,开启 LBS 定位服务和是否允许 SDK 弹出用户定位请求,请求
   // NSLocationAlwaysUsageDescription 权限,如果 UserVerify 设置为 NO,需第三方负责提示用户定位授权。 [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    if (err) {
        NSLog(@"error:%@",[err localizedDescription]);
     //   [_viewController logMsg:[NSString stringWithFormat:@"%@", [err localizedDescription]]];
    }
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString*token=[[deviceToken description]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    if (token) {
        _viewController.token=token;
    }
    _deviceToken=[token stringByReplacingOccurrencesOfString:@"" withString:@"" ];
    NSLog(@"deviceToke:%@",_deviceToken);
    [GeTuiSdk registerDeviceToken:_deviceToken];
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSString*payloadMsg=[userInfo objectForKey:@"payload"];
    if (payloadMsg) {
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        NSLog(@"成功接收:%@",record);
    }
}
-(void)applicationDidEnterBackground:(UIApplication *)application{
    [GeTuiSdk enterBackground];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [GeTuiSdk registerDeviceToken:@""];
}
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}
//SDK 启动成功返回 cid
-(void)GeTuiSdkDidRegisterClient:(NSString *)clientId{
    _viewController.clientId=clientId;
    
    if (_deviceToken) {
        [GeTuiSdk registerDeviceToken:_deviceToken];
    }
}
//SDK 收到透传消息回调
-(void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId fromApplication:(NSString *)appId{
    NSData*payload=[GeTuiSdk retrivePayloadById:payloadId];
    NSString*payloadMsg=nil;
    if (payload) {
        payloadMsg=[[NSString alloc]initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
    }
  //  NSString *record = [NSString stringWithFormat:@"%d, %@, %@", ++_lastPaylodIndex, [self formateTime:[NSDate date]], payloadMsg];
    NSLog(@"task id : %@, messageId:%@", taskId, aMsgId);
}
//SDK 收到 sendMessage 消息回调
-(void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result{
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d",messageId, result];
    NSLog(@"%@",record);
}
-(void)GeTuiSdkDidOccurError:(NSError *)error{
    NSLog(@"%@",[error localizedDescription]);
}
-(void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus{
    NSLog(@"%u",aStatus);
}
-(void)applicationDidBecomeActive:(UIApplication *)application{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [self startSdkWith:app_id appKey:app_key appSecret:app_secret];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
