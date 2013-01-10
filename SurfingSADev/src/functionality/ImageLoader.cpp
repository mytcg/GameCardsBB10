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

}

void ImageLoader::loadImage(QString imageUrl, ImageView * parent)
{
	qDebug() << "\n loadImage "+imageUrl;
	m_imageUrl = imageUrl;
	mParent = parent;

	if(QFile::exists ("data/surfingsa_"+m_imageUrl.mid(m_imageUrl.indexOf("/products/")+10,m_imageUrl.indexOf(".png")-(m_imageUrl.indexOf("/products/")+10)))){
		QFile *file = new QFile("data/surfingsa_"+m_imageUrl.mid(m_imageUrl.indexOf("/products/")+10,m_imageUrl.indexOf(".png")-(m_imageUrl.indexOf("/products/")+10)));

		qDebug() << "\n loadImage file exists";
		// Open the file and print an error if the file cannot be opened
		if (file->open(QIODevice::ReadWrite))
		{
			qDebug() << "\n loadImage loading from file";
			QTextStream fileStream(file);

			QByteArray data ( QString(fileStream.readAll()).toLocal8Bit ());

			file->close();

			QImage image;

			image.loadFromData(data);

			mParent->setImage (imageToData(image));
		}
		else {
			qDebug() << "\n loadImage 2";
			QNetworkAccessManager* netManager = new QNetworkAccessManager(this);

			const QUrl url(m_imageUrl);
			QNetworkRequest request(url);

			QNetworkReply* reply = netManager->get(request);
			connect(reply, SIGNAL(finished()), this, SLOT(onReplyFinished()));
		}
	}
	else {
		qDebug() << "\n loadImage 3";
		QNetworkAccessManager* netManager = new QNetworkAccessManager(this);

		const QUrl url(m_imageUrl);
		QNetworkRequest request(url);

		QNetworkReply* reply = netManager->get(request);
		connect(reply, SIGNAL(finished()), this, SLOT(onReplyFinished()));
	}
}

void ImageLoader::onReplyFinished()
{
	QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
	qDebug() << "\n Downloading image";
	QString response;
	if (reply) {
		if (reply->error() == QNetworkReply::NoError) {
			qDebug() << "\n Saving image";
			const int available = reply->bytesAvailable();
			if (available > 0) {
				const QByteArray data(reply->readAll());
				//save image
				QFile *file = new QFile("data/surfingsa_"+m_imageUrl.mid(m_imageUrl.indexOf("/products/")+10,m_imageUrl.indexOf(".png")-(m_imageUrl.indexOf("/cards/")+10)));

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
				qDebug() << "\n Converting image";
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
