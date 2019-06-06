//
//  main.m
//  TestAppLifeCycle
//
//  Created by niuyulong on 2019/6/5.
//  Copyright © 2019 nyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BLStopwatch.h"

const char * c_str = "const string";
int main(int argc, char * argv[]) {
    @autoreleasepool {
        char *str = "private string";

        printf("%s",c_str);
        
        printf("%s",str);
        
        int xs =  213;
        BLStopwatch *timer = [BLStopwatch sharedStopwatch];
        [timer start];
        [timer splitWithDescription: [NSString stringWithFormat:@"冷启动优化 main"]];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
