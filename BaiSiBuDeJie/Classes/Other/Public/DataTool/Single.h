//
//  Single.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/14.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

/** 如果shareClassName 字母连接在一起用## 断开, 不然宏定义替换不了*/
/** 类的方法的声明部分 */
#define singtonInterface(ClassName)  + (instancetype)share##ClassName;

/** 类的方法的实现部分 */
#define singtonImplement(ClassName) \
\
static ClassName *_shareInstance; \
\
+ (instancetype)share##ClassName { \
\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _shareInstance = [[ClassName alloc] init]; \
    }); \
return _shareInstance; \
} \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone { \
\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _shareInstance = [super allocWithZone:zone]; \
}); \
\
    return _shareInstance; \
\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
    return _shareInstance;\
}
