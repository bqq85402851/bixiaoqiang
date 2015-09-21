//
//  Model.m
//  Demo
//
//  Created by 杨汉池 on 15/9/18.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import "Model.h"

@implementation Model
+(void)post:(NSString *)url with:(NSDictionary *)parame sucess:(void (^)(Model *))sucess fail:(void (^)(NSError *))fail{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    [manager POST:url parameters:parame success:^(NSURLSessionDataTask *task, id responseObject) {
        if(sucess){
           /**自己处理下--------------*/
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}
@end
