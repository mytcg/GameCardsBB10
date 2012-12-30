#ifndef _UTIL_H_
#define _UTIL_H_

#include <string>

using namespace std;

class Util
{
	public:
	static string base64_encode(unsigned char const* bytes_to_encode, unsigned int in_len);
	static string base64_decode(string encoded_string);
	static inline bool is_base64(unsigned char c);
};

#endif //_UTIL_H_
