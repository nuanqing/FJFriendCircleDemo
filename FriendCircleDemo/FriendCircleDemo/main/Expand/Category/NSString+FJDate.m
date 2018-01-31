//
//  NSString+FJDate.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/31.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "NSString+FJDate.h"

@implementation NSString (FJDate)
//毫秒转换成日期
+ (NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //当前时间
    NSDate *nowDate=[NSDate date];
    NSLog(@"当前时间---%@",nowDate);
    //需要转换的时间
    NSDate *needDate=[[NSDate alloc]initWithTimeIntervalSince1970:timeInterval];
    //[dateFormatter dateFromString:dateString];
    //比较当前时间与需要转换的时间
    NSTimeInterval time =[nowDate timeIntervalSinceDate:needDate];
    NSLog(@"间隔--- %f",time);
    //替换间隔的秒数
    NSString *dateStr=[[NSString alloc]init];
    //1分钟之内
    if (time<=60) {
        dateStr=@"刚刚";
        //1小时内
    }else if (time<=60*60){
        int mins = time/60;
        dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        //2天内
    }else if (time<=60*60*24*2){
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString * needStr = [dateFormatter stringFromDate:needDate];
        NSString *nowStr = [dateFormatter stringFromDate:nowDate];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([needStr isEqualToString:nowStr]) {
            //在同一天
            dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needDate]];
        }else{
            //昨天
            dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needDate]];
        }
    }else {
        
        [dateFormatter setDateFormat:@"yyyy"];
        NSString * yearStr = [dateFormatter stringFromDate:needDate];
        NSString *nowYear = [dateFormatter stringFromDate:nowDate];
        
        if ([yearStr isEqualToString:nowYear]) {
            //在同一年
            [dateFormatter setDateFormat:@"MM-dd"];
            dateStr = [dateFormatter stringFromDate:needDate];
        }else{
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            dateStr = [dateFormatter stringFromDate:needDate];
        }
    }
    return dateStr;
}
//日期判断
+ (NSString *)stringWithDateString:(NSString *)dateString{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //当前时间
    NSDate *nowDate=[NSDate date];
    NSLog(@"当前时间---%@",nowDate);
    NSDate *needDate=[dateFormatter dateFromString:dateString];
    //比较当前时间与需要转换的时间
    NSTimeInterval time =[nowDate timeIntervalSinceDate:needDate];
    NSLog(@"间隔--- %f",time);
    //转换后的输出字符
    NSString *outDateStr=[[NSString alloc]init];
    //1分钟之内
    if (time<=60) {
        outDateStr=@"刚刚";
        //1小时内
    }else if (time<=60*60){
        int mins = time/60;
        outDateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        //2天内
    }else if (time<=60*60*24*2){
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString * needStr = [dateFormatter stringFromDate:needDate];
        NSString * nowStr = [dateFormatter stringFromDate:nowDate];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([needStr isEqualToString:nowStr]) {
            //在同一天
            outDateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needDate]];
        }else{
            //昨天
            outDateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needDate]];
        }
    }else {
        [dateFormatter setDateFormat:@"yyyy"];
        NSString * yearStr = [dateFormatter stringFromDate:needDate];
        NSString *nowYear = [dateFormatter stringFromDate:nowDate];
        
        if ([yearStr isEqualToString:nowYear]) {
            //在同一年
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            outDateStr = [dateFormatter stringFromDate:needDate];
        }else{
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            outDateStr = [dateFormatter stringFromDate:needDate];
        }
    }
    
    return outDateStr;
}

@end
