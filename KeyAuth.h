#ifndef KEYAUTH_H
#define KEYAUTH_H

#include <string>
#include <vector>

class KeyAuth {
public:
    static void initApp(std::string name, std::string ownerid, std::string secret);
    static void login(std::string key);
    struct Response {
        bool success;
        std::string message;
    };
    static Response response;
};

#endif
