#import <UIKit/UIKit.h>
#include "KeyAuth.h"

// نیشاندانا لۆگینێ (هیچ گوهۆڕین د ڤێ بەشێ دا نینە)
UIViewController *getTopViewController() {
    UIWindowScene *scene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    return scene.windows.firstObject.rootViewController;
}

void showKeyInput() {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KeyAuth Login"
        message:@"تکایە کلیلێ بنڤێسە:"
        preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"کلیل";
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"لۆگین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *userKey = alert.textFields[0].text;
        
        // **ل ڤێرێ راستڤەکرن**: بکارئینانا `KeyAuth::` و `login`
        KeyAuth::login([userKey UTF8String]);
        
        // **ل ڤێرێ راستڤەکرن**: بکارئینانا `KeyAuth::response.success`
        if (KeyAuth::response.success) {
            NSLog(@"سەرکەفتن!");
        } else {
            showKeyInput();
        }
    }]];

    [getTopViewController() presentViewController:alert animated:YES completion:nil];
}

// **ل ڤێرێ راستڤەکرن**: بکارئینانا `KeyAuth::initApp`
__attribute__((constructor)) static void init_gate() {
    KeyAuth::initApp("NAVA_APP", "OWNER_ID", "SECRET");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        showKeyInput();
    });
}
