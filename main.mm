#import <UIKit/UIKit.h>
#include "KeyAuth.h"

// 1. دروستکرنا Objectـێ KeyAuth
KeyAuth App("NAVA_APP", "OWNER_ID", "SECRET");

UIViewController *getTopViewController() {
    UIWindowScene *scene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    return scene.windows.firstObject.rootViewController;
}

void showKeyInput() {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KeyAuth Login"
        message:@"کلیلێ بنڤێسە:"
        preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"کلیل";
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"لۆگین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *userKey = alert.textFields[0].text;
        
        // 2. لۆگینکرن ب `App.login`
        if (App.login([userKey UTF8String])) {
            NSLog(@"سەرکەفتن!");
        } else {
            showKeyInput();
        }
    }]];

    [getTopViewController() presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor)) static void init_gate() {
    // 3. ئینیتکرن (ئەگەر پێدڤی بیت، بەلێ زۆربەیا لایبراریان دگەل دروستکرنا `KeyAuth App` ئینیت دبن)
    App.init();
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        showKeyInput();
    });
}
