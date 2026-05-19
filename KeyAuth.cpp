#include "KeyAuth.h"
#include <iostream>

KeyAuth::Response KeyAuth::response = {false, ""};

void KeyAuth::initApp(std::string name, std::string ownerid, std::string secret) {
    // ئەڤە تەنێ بۆ ئەوە کو پڕۆژە پێ ب زانیت KeyAuth هەیە
    std::cout << "App Initialized: " << name << std::endl;
}

void KeyAuth::login(std::string key) {
    // ل ڤێرێ دێ گرێدان دگەل سێرڤەری هێتە ئەنجامدان
    if(key == "test") {
        response.success = true;
    } else {
        response.success = false;
    }
}
