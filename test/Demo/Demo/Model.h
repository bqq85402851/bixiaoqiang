//
//  Model.h
//  Demo
//
//  Created by 杨汉池 on 15/9/18.
//  Copyright (c) 2015年 杨汉池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface Model : NSObject
+(void)post:(NSString*)url with:(NSDictionary*)parame sucess:(void (^)(Model *model))sucess fail:(void (^)(NSError*error))fail;
@end
