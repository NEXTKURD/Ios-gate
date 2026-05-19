#import <UIKit/UIKit.h>
#include "KeyAuth.h"

// 1. ئەڤە دێ لۆگینێ کەت (بێ دروستکرنا کلاسێ)
void showKeyInput() {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KeyAuth"
        message:@"کلیلێ بنڤێسە:"
        preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"کلیل";
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"لۆگین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *userKey = alert.textFields[0].text;
        
        // **تاقیکرنا ڤی شێوازێ**: ل دەرڤەی کلاسێ
        if (KeyAuth::login([userKey UTF8String])) {
            NSLog(@"سەرکەفتن!");
        } else {
            showKeyInput();
        }
    }]];

    UIWindowScene *scene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    [scene.windows.firstObject.rootViewController presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor)) static void init_gate() {
    // 2. تاقیکرنا `init` ب ڤی شێوەی
    KeyAuth::init("NAVA_APP", "OWNER_ID", "SECRET");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        showKeyInput();
    });
}
