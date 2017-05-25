//
//  ViewController.m
//  runtime
//
//  Created by roc on 2017/5/23.
//  Copyright © 2017年 roc. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()<UIScrollViewDelegate>
{
    int test;
}
@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSMutableArray *array;

@property(nonatomic,strong)NSDictionary *dictionary;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getPropertyList];
    
    [self getMethodList];
    
    [self getIvarList];
    
    [self getprocotolList];
}

//获取属性列表
-(void)getPropertyList{

    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    for (unsigned int i = 0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"propertyName----%@",[NSString stringWithUTF8String:propertyName]);
        
    }
}

//获取方法列表
-(void)getMethodList{

    unsigned int count;
    Method *methodList = class_copyMethodList([self class], &count);
    for ( unsigned int i = 0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---%@",NSStringFromSelector(method_getName(method)));
    }
    
}

//获取成员变量列表
-(void)getIvarList{

    unsigned int count ;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    
    for (unsigned int i = 0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char * ivarName = ivar_getName(myIvar);
        NSLog(@"ivar----%@",[NSString stringWithUTF8String:ivarName]);
        
    }
    
}

//获取协议列表
-(void)getprocotolList{

    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Protocol *myProtocol = protocolList[i];
        const char *protocolName = protocol_getName(myProtocol);
        NSLog(@"protocol----%@",[NSString stringWithUTF8String:protocolName]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
