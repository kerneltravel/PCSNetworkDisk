//
//  PCSMacroDefine.h
//  PCSNetDisk
//
//  Created by wangzz on 13-3-7.
//  Copyright (c) 2013年 hisunsray. All rights reserved.
//

#ifndef PCSNetDisk_PCSMacroDefine_h
#define PCSNetDisk_PCSMacroDefine_h

//数据类型


//字符串
#define PCS_STRING_MOBWIN_UNIT_ID           @"A495798C12C030F28E7711F3613DFC1B"
#define PCS_STRING_BAIDU_API_KEY            @"L6g70tBRRIXLsY0Z3HwKqlRE"
#define PCS_STRING_DEFAULT_PATH             @"/apps/pcstest_oauth/"

#define PCS_STRING_EVER_LAUNCHED            @"everLaunched"
#define PCS_STRING_FIRST_LAUNCH             @"firstLaunch"
#define PCS_STRING_IS_LOGIN                 @"isLogin"
#define PCS_STRING_ACCESS_TOKEN             @"accessToken"



//省略字符串
#define PCS_APP_DELEGATE    ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//方法

//判断字符串是否为nil
#define PCS_FUNC_SENTENCED_EMPTY(string)    (string = ((string == nil) ? @"":string))

//安全释放Object
#define PCS_FUNC_SAFELY_RELEASE(_POINTER_VAR) {[_POINTER_VAR release];_POINTER_VAR = nil;}

#if DEBUG==1
#define PCSLog(format,...)  NSLog((@"%s [Line %d] " format),__FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define PCSLog(format,...)
#endif


#endif