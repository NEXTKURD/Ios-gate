#import <UIKit/UIKit.h>
#include "KeyAuth.h"

// ئەم هیچ گوهۆڕینان د دروستکرنا کلاسێ دا ناکەین
// ئەم تەنێ بانگکرنا راستەوخۆ یا فانکشنا بکار دئینین

void showKeyInput() {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KeyAuth Login"
        message:@"کلیلێ بنڤێسە:"
        preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"کلیل";
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"لۆگین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *userKey = alert.textFields[0].text;
        
        // **ئەڤە کۆدێ داویێ یە**:
        // ئەگەر ev خەتا دەرکەفت، واتە لایبراریا تە `KeyAuth` نەیا تەمامە
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
    // ئەگەر ئەم ڤی کۆدی کار پێ بکەین و خەتا نەدا، ئەپ دێ ئیشت
    KeyAuth::init();
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        showKeyInput();
    });
}
