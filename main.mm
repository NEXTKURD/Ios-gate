#import <UIKit/UIKit.h>
#import "KeyAuth.h"

__attribute__((constructor)) static void init_gate() {
    // گرێدانا پڕۆژەیێ تە ب سێرڤەرێ KeyAuth
    [KeyAuth initApp:@"Hogrbarwary05's Application" 
              ownerID:@"ctPb2f2sjA" 
              secret:@"ba700459d6d81c91c44465c45f2f85939f1a4a4297d198aa112372a0010a4c2f"];
    
    // ل ڤێرێ دێ پسیار ژ بکارئینەری کەی یان هەر کارەکێ تە ڤێت ئەنجام دەی
    // ئەڤ کۆدە دێ بکارئینەری دگەل سێرڤەرێ KeyAuth گرێ دەت
}
