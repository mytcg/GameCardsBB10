#include "ImageLoader.h"
#include "../utils/Util.h"

#include <bb/data/XmlDataAccess>
#include <bb/cascades/GroupDataModel>

using namespace bb::cascades;
using namespace bb::data;
using namespace bb;

ImageLoader::ImageLoader(AbstractPane *root): root(root)
{
	qDebug() << "\n ImageLoader ";
	mNetworkAccessManager = new QNetworkAccessManager(this);

	bool result = connect(mNetworkAccessManager,
			SIGNAL(finished(QNetworkReply*)),
			this, SLOT(onReplyFinished(QNetworkReply*)));

	// Displays a warning message if there's an issue connecting the signal
	// and slot. This is a good practice with signals and slots as it can
	// be easier to mistype a slot or signal definition
	Q_ASSERT(result);
	Q_UNUSED(result);
}

void ImageLoader::loadImage(QString imageUrl, QObject * parent)
{
	qDebug() << "\n loadImage "+imageUrl;
	m_imageUrl = imageUrl;
	mParent = ((StandardListItem *)parent);

	if(QFile::exists ("data/surfingsa_"+m_imageUrl.mid(m_imageUrl.indexOf("/cards/")+7,m_imageUrl.indexOf(".jpg")-(m_imageUrl.indexOf("/cards/")+7)))){
		QFile *file = new QFile("data/surfingsa_"+m_imageUrl.mid(m_imageUrl.indexOf("/cards/")+7,m_imageUrl.indexOf(".jpg")-(m_imageUrl.indexOf("/cards/")+7)));

		// Open the file and print an error if the file cannot be opened
		if (file->open(QIODevice::ReadWrite))
		{
			QTextStream fileStream(file);

			QByteArray data ( QString(fileStream.readAll()).toLocal8Bit ());

			file->close();

			QImage image;

			image.loadFromData(data);

			mParent->setImage (imageToData(image));
		}
		else {
			mNetworkAccessManager = new QNetworkAccessManager(this);

			QNetworkRequest request = QNetworkRequest();
			request.setUrl(QUrl(m_imageUrl));

			mNetworkAccessManager->get(request);
		}
	}
	else {
		mNetworkAccessManager = new QNetworkAccessManager(this);

		QNetworkRequest request = QNetworkRequest();
					request.setUrl(QUrl(m_imageUrl));

		mNetworkAccessManager->get(request);
	}
}

void ImageLoader::onReplyFinished(QNetworkReply* reply)
{
	QString response;
	if (reply) {
		if (reply->error() == QNetworkReply::NoError) {
			const int available = reply->bytesAvailable();
			if (available > 0) {
				const QByteArray data(reply->readAll());
				//save image
				QFile *file = new QFile("data/surfingsa_"+m_imageUrl.mid(m_imageUrl.indexOf("/cards/")+7,m_imageUrl.length()-(m_imageUrl.indexOf("/cards/")+7)));

				// Open the file and print an error if the file cannot be opened
				if (file->open(QIODevice::ReadWrite))
				{
					QTextStream fileStream(file);

					fileStream << data;

					file->close();
				}else{
					qDebug() << "\n Failed to open file";
				}
				QImage image;

				image.loadFromData(data);

				mParent->setImage (imageToData(image));
			}
		} else {

		}

		reply->deleteLater();
	} else {

	}
}

bb::ImageData ImageLoader::imageToData(QImage & qImage) {
	bb::ImageData imageData(bb::PixelFormat::RGBA_Premultiplied, qImage.width(), qImage.height());

	unsigned char *dstLine = imageData.pixels();
	for (int y = 0; y < imageData.height(); y++) {
		unsigned char * dst = dstLine;
		for (int x = 0; x < imageData.width(); x++) {
			QRgb srcPixel = qImage.pixel(x, y);
			*dst++ = qRed(srcPixel);
			*dst++ = qGreen(srcPixel);
			*dst++ = qBlue(srcPixel);
			*dst++ = qAlpha(srcPixel);
		}
		dstLine += imageData.bytesPerLine();
	}

	return imageData;
}
