#import <UIKit/UIKit.h>
#include "KeyAuth.h"

// 1. چارەسەرا Deprecated دگەل شێوازێ نوو
UIViewController *getTopViewController() {
    UIWindowScene *scene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    return scene.windows.firstObject.rootViewController;
}

// 2. فانکشنی بۆ نیشاندانا سندوقا لۆگینێ
void showKeyInput() {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KeyAuth Login"
        message:@"تکایە کلیلێ بنڤێسە:"
        preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"کلیل";
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"لۆگین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *userKey = alert.textFields[0].text;
        
        // **ل ڤێرێ گوهۆڕین هەیە**: بکارئینانا `KeyAuthApp` و بانگکرنا `login`
        // ئەگەر `KeyAuth` ناڤێ کلاسا تە بیت، دڤێت ب `KeyAuthApp::` یان `KeyAuth::` بێژین
        // ل دويڤ وێ خەتایێ، دبیت ناڤێ فانکشنێ یێ جودا بیت. 
        // ڤی کۆدی تاقی بکە:
        
        KeyAuthApp::login([userKey UTF8String]);
        
        // تاقیکرنا سەرکەفتنێ
        if (KeyAuthApp::success) {
            NSLog(@"سەرکەفتن!");
        } else {
            showKeyInput();
        }
    }]];

    [getTopViewController() presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor)) static void init_gate() {
    // ئەگەر لایبراریا تە ب ناڤێ KeyAuthApp بیت
    KeyAuthApp::init("NAVA_APP", "OWNER_ID", "SECRET");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        showKeyInput();
    });
}
