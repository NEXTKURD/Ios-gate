#import <UIKit/UIKit.h>
#include "KeyAuth.h"

// 1. گوهۆڕین: مە `KeyAuth` نەبیت، ئەم دێ ب "KeyAuth"ـێ دروست کەین. 
// ئەگەر تو دبینی خەتا "no member" هەیە، واتە دڤێت ئەم ب `new` بانگ کەین.

void showKeyInput() {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KeyAuth"
        message:@"کلیلێ بنڤێسە:"
        preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"کلیل";
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"لۆگین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *userKey = alert.textFields[0].text;
        
        // 2. تاقیکرنا شێوازێ pointer
        KeyAuth *api = new KeyAuth("NAVA_APP", "OWNER_ID", "SECRET");
        if (api->login([userKey UTF8String])) {
            NSLog(@"سەرکەفتن!");
        } else {
            showKeyInput();
        }
    }]];

    UIWindowScene *scene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    [scene.windows.firstObject.rootViewController presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor)) static void init_gate() {
    // 3. ئینیتکرن ب pointer
    KeyAuth *api = new KeyAuth("NAVA_APP", "OWNER_ID", "SECRET");
    api->init();
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        showKeyInput();
    });
}
