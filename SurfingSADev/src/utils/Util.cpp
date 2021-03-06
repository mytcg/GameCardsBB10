#include "Util.h"

#include <QFile>
#include <QIODevice>
#include <QTextStream>

#include <bb/data/XmlDataAccess>
#include <bb/device/DisplayInfo>

using namespace bb::data;
using namespace bb::device;

QString Util::getUsername() {
	QFile *file = new QFile("data/userdata.xml");

	if (!file->open(QIODevice::ReadOnly)) {
		qDebug() << "\n Failed to open file";
		return "Error reading file";
	}
	else {
		QTextStream fileStream(file);

		QString str = fileStream.readAll();

		file->close();

		XmlDataAccess xda;
		QVariant userData = xda.loadFromBuffer(str, "/userdetails");

		QVariantMap userMap = userData.value<QVariantMap>();

		QString username = userMap["username"].value<QString>();

		return username;
	}
}

QString Util::getEncrypt() {
	QFile *file = new QFile("data/userdata.xml");

	if (!file->open(QIODevice::ReadOnly)) {
		qDebug() << "\n Failed to open file";
		return "Error reading file";
	}
	else {
		QTextStream fileStream(file);

		QString str = fileStream.readAll();

		file->close();

		XmlDataAccess xda;
		QVariant userData = xda.loadFromBuffer(str, "/userdetails");

		QVariantMap userMap = userData.value<QVariantMap>();

		QString encrypt = userMap["encrypt"].value<QString>();

		return encrypt;
	}
}

QString Util::getHeight() {
	DisplayInfo display;
	//qDebug() << "\n height" << display.pixelSize().height();
	int height  = display.pixelSize().height();
	return QString::number(height);
}

QString Util::getWidth() {
	DisplayInfo display;
	//qDebug() << "\n width" << display.pixelSize().width();
	int width = display.pixelSize().width();
	return QString::number(width);
}

string Util::base64_encode(unsigned char const* bytes_to_encode, unsigned int in_len) {
	string base64_chars =  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"  //  0 to 25
										"abcdefghijklmnopqrstuvwxyz"  // 26 to 51
										"0123456789"				  // 52 to 61
										"+"							  // 62
										"/";


	/* Copyright (C) 2004-2008 Ren� Nyffenegger

	   This source code is provided 'as-is', without any express or implied
	   warranty. In no event will the author be held liable for any damages
	   arising from the use of this software.

	   Permission is granted to anyone to use this software for any purpose,
	   including commercial applications, and to alter it and redistribute it
	   freely, subject to the following restrictions:

	   1. The origin of this source code must not be misrepresented; you must not
		  claim that you wrote the original source code. If you use this source code
		  in a product, an acknowledgment in the product documentation would be
		  appreciated but is not required.

	   2. Altered source versions must be plainly marked as such, and must not be
		  misrepresented as being the original source code.

	   3. This notice may not be removed or altered from any source distribution.

	   Ren� Nyffenegger rene.nyffenegger@adp-gmbh.ch */

	unsigned char char_array_3[3];
	unsigned char char_array_4[4];

	string ret = "";
	int i = 0;
	int j = 0;
	while (in_len--) {
		char_array_3[i++] = *(bytes_to_encode++);
		if (i == 3) {
			char_array_4[0] = (char_array_3[0] & 0xfc) >> 2;
			char_array_4[1] = ((char_array_3[0] & 0x03) << 4) + ((char_array_3[1] & 0xf0) >> 4);
			char_array_4[2] = ((char_array_3[1] & 0x0f) << 2) + ((char_array_3[2] & 0xc0) >> 6);
			char_array_4[3] = char_array_3[2] & 0x3f;
			for(i = 0; (i <4) ; i++) {
				ret += base64_chars[char_array_4[i]];
			}
			i = 0;
		}
	}
	if (i) {
		for(j = i; j < 3; j++)
			char_array_3[j] = '\0';
			char_array_4[0] = (char_array_3[0] & 0xfc) >> 2;
			char_array_4[1] = ((char_array_3[0] & 0x03) << 4) + ((char_array_3[1] & 0xf0) >> 4);
			char_array_4[2] = ((char_array_3[1] & 0x0f) << 2) + ((char_array_3[2] & 0xc0) >> 6);
			char_array_4[3] = char_array_3[2] & 0x3f;

			for (j = 0; (j < i + 1); j++)
				ret += base64_chars[char_array_4[j]];

		while((i++ < 3))
		ret += '=';
	}
	return ret;
}

string Util::base64_decode(string encoded_string) {
	string base64_chars =  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"  //  0 to 25
										"abcdefghijklmnopqrstuvwxyz"  // 26 to 51
										"0123456789"				  // 52 to 61
										"+"							  // 62
										"/";

	int in_len = encoded_string.size();
	int i = 0;
	int j = 0;
	int in_ = 0;
	unsigned char char_array_4[4], char_array_3[3];
	string ret;
	string temp = "";

	while (in_len-- && ( encoded_string[in_] != '=') && is_base64(encoded_string[in_])) {
		char_array_4[i++] = encoded_string[in_]; in_++;
		if (i ==4) {
			for (i = 0; i <4; i++) {
				temp += char_array_4[i];
				char_array_4[i] = base64_chars.find(temp.c_str());
				temp.clear();
			}

			char_array_3[0] = (char_array_4[0] << 2) + ((char_array_4[1] & 0x30) >> 4);
			char_array_3[1] = ((char_array_4[1] & 0xf) << 4) + ((char_array_4[2] & 0x3c) >> 2);
			char_array_3[2] = ((char_array_4[2] & 0x3) << 6) + char_array_4[3];

			for (i = 0; (i < 3); i++)
				ret += char_array_3[i];
			i = 0;
		}
	}

	if (i) {
		for (j = i; j <4; j++)
			char_array_4[j] = 0;

		for (j = 0; j <4; j++) {
			temp += char_array_4[j];
			char_array_4[j] = base64_chars.find(temp.c_str());
			temp.clear();
		}

		char_array_3[0] = (char_array_4[0] << 2) + ((char_array_4[1] & 0x30) >> 4);
		char_array_3[1] = ((char_array_4[1] & 0xf) << 4) + ((char_array_4[2] & 0x3c) >> 2);
		char_array_3[2] = ((char_array_4[2] & 0x3) << 6) + char_array_4[3];

		for (j = 0; (j < i - 1); j++) ret += char_array_3[j];
	}

	return ret;
}

inline bool Util::is_base64(unsigned char c) {
	return (isalnum(c) || (c == '+') || (c == '/'));
}
