#import <UIKit/UIKit.h>

__attribute__((constructor)) static void init_gate() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        
        // دیتنا پەنجەرا سەرەکی (Window) ب شێوازێ ستاندار
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    window = scene.windows.firstObject;
                    break;
                }
            }
        }
        
        if (!window) {
            window = [UIApplication sharedApplication].windows.firstObject;
        }
        
        UIViewController *root = window.rootViewController;
        if (!root) return;
        
        // دروستکرنا سندوقا پاسۆردێ
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Security System"
                                                                       message:@"Please enter the access password:"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Password";
            textField.secureTextEntry = YES;
        }];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction *act) {
            UITextField *field = alert.textFields.firstObject;
            // تاقیکرنا پاسۆردێ
            if ([field.text isEqualToString:@"telegram-next_8ball"]) {
                // پاسۆرد یا دروستە، ئەپ دێ کار کەت
                NSLog(@"Access Granted");
            } else {
                // پاسۆرد یا خەلەتە، ئەپ دێ ژێ دەرکەڤیت
                exit(0);
            }
        }];
        
        [alert addAction:action];
        [root presentViewController:alert animated:YES completion:nil];
    });
}
