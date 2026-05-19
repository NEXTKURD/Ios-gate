#import <UIKit/UIKit.h>
#include "KeyAuth.h"

using namespace KeyAuth; // ئەڤە دێ ڕێگریێ ل خەتا "no member" کەت

UIViewController *getTopViewController() {
    UIWindowScene *scene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    return scene.windows.firstObject.rootViewController;
}

void showKeyInput() {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KeyAuth"
        message:@"کلیلێ بنڤێسە:"
        preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"کلیل";
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"لۆگین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *userKey = alert.textFields[0].text;
        
        // **گوهۆڕینا گرنگ**: بەرهەمێ `login`ـێ راستەوخۆ وەرگرە
        if (api.login([userKey UTF8String])) {
            NSLog(@"سەرکەفتن!");
        } else {
            showKeyInput();
        }
    }]];

    [getTopViewController() presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor)) static void init_gate() {
    // ئەگەر APIـێ تە وەک `api` هاتییە نڤێسین ل `KeyAuth.h`
    api.initApp("NAVA_APP", "OWNER_ID", "SECRET");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        showKeyInput();
    });
}
