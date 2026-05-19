#ifndef KEYAUTH_H
#define KEYAUTH_H

#include <string>

class KeyAuth {
public:
    static void initApp(std::string name, std::string ownerid, std::string secret);
};

#endif
