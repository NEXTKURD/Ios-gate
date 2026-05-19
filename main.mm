#import <UIKit/UIKit.h>
#include "KeyAuth.h"

// ئەڤ فانکشنە یا دروستکرنا سندوقا کلیلێ یە
void showKeyInput() {
    // 1. دروستکرنا Alert-ەکێ
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KeyAuth Login"
        message:@"تکایە کلیلێ بنڤێسە:"
        preferredStyle:UIAlertControllerStyleAlert];

    // 2. زێدەکرنا سندوقا TextField
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"کلیلێ ل ڤێرێ بنڤێسە";
    }];

    // 3. دوگمەیا لۆگینێ
    [alert addAction:[UIAlertAction actionWithTitle:@"لۆگین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *userKey = alert.textFields[0].text;
        
        // 4. ڤەگوێستنا کلیلێ بۆ KeyAuth
        KeyAuth::login([userKey UTF8String]);
        
        if (KeyAuth::response.success) {
            NSLog(@"سەرکەفتن!");
        } else {
            // ئەگەر کلیل خەلەت بوو، جارەکا دی بێخە ڤە
            showKeyInput();
        }
    }]];

    // نیشاندانا Alertـێ ل سەر شاشێ
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    [root presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor)) static void init_gate() {
    KeyAuth::initApp("NAVA_APP", "OWNER_ID", "SECRET");
    
    // چاوەڕێ بکە تا ئەپ یێ حازر بیت پاشێ نیشان بدە
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        showKeyInput();
    });
}
