#import <UIKit/UIKit.h>
#include "KeyAuth.h"

// 1. فانکشنی بۆ دیتنا پەنجەرا ئەپێ یا نوو (بێ کێشە)
UIViewController *getTopViewController() {
    return [UIApplication sharedApplication].windows.firstObject.rootViewController;
}

// 2. فانکشنی بۆ نیشاندانا سندوقا لۆگینێ
void showKeyInput() {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KeyAuth Login"
        message:@"تکایە کلیلێ ل ڤێرێ بنڤێسە:"
        preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"کلیل";
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"لۆگین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *userKey = alert.textFields[0].text;
        
        // رەوانەکرنا کلیلێ بۆ سێرڤەری
        KeyAuth::login([userKey UTF8String]);
        
        if (KeyAuth::response.success) {
            NSLog(@"سەرکەفتن: لۆگین یا ب سەرکەفتن هات!");
        } else {
            // ئەگەر کلیل نەیا دروست بوو، جارەکا دی دەرێخە
            showKeyInput();
        }
    }]];

    [getTopViewController() presentViewController:alert animated:YES completion:nil];
}

// 3. کۆدێ سەرەکی (Constructor)
__attribute__((constructor)) static void init_gate() {
    // ل ڤێرێ زانیاریێن ئەکاونتێ خۆ دابنێ (OwnerID و Secret)
    KeyAuth::initApp("NAVA_APP", "OWNER_ID", "SECRET");
    
    // چاوەڕێ بکە تا ئەپ یێ حازر بیت پاشێ نیشان بدە
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        showKeyInput();
    });
}
