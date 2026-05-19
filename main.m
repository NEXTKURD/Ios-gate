#import <UIKit/UIKit.h>

__attribute__((constructor)) static void init_gate() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_to_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIViewController *root = window.rootViewController;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"🔐 سیستەمێ پاراستنێ"
                                                                       message:@"تکایە پاسۆردێ گشتی داخل بکە:"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"پاسۆرد ل ڤێرە بنڤێسە";
            textField.secureTextEntry = YES;
        }];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"چوونەژوورێ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *act) {
            UITextField *field = alert.textFields.firstObject;
            
            // پاسۆرد ل ڤێرە یێ دیارکرییە: 9999
            if ([field.text isEqualToString:@"9999"]) {
                // پاسۆرد ڕاستە
            } else {
                exit(0); 
            }
        }];
        
        [alert addAction:action];
        [root presentViewController:alert animated:YES completion:nil];
    });
}
