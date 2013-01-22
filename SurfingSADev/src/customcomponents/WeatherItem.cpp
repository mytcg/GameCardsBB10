#include "WeatherItem.h"

#include <bb/cascades/Color>
#include <bb/cascades/Container>
#include <bb/cascades/SystemDefaults>
#include <bb/cascades/TextStyle>
#include <bb/cascades/Color>
#include <bb/cascades/StackLayout>
#include <bb/cascades/StackLayoutProperties>
#include <bb/cascades/ImagePaint>

using namespace bb::cascades;

WeatherItem::WeatherItem(Container *parent) :
        CustomControl(parent)
{
    // Dock layout with margins inside
    Container *itemContainer = new Container();
    StackLayout *itemLayout = new StackLayout();
    itemLayout->setOrientation( LayoutOrientation::TopToBottom );
    itemContainer->setLayout(itemLayout);
    itemContainer->setRightMargin(20);

    mTime = Label::create("");
    mTime->textStyle()->setFontSize(FontSize::XXSmall);
	mTime->setHorizontalAlignment(HorizontalAlignment::Center);

    mWindSpeed = Label::create("");
    mWindSpeed->textStyle()->setFontSize(FontSize::XXSmall);
	mWindSpeed->setHorizontalAlignment(HorizontalAlignment::Center);
	
	mTemperatureBackground = Container::create();
	mTemperatureBackground->setHorizontalAlignment(HorizontalAlignment::Center);
	
    mTemperature = Label::create("");
    mTemperature->textStyle()->setFontSize(FontSize::XXSmall);
	mTemperature->setHorizontalAlignment(HorizontalAlignment::Center);
	
	mTemperatureBackground->add(mTemperature);

    mCloudCover = Label::create("");
    mCloudCover->textStyle()->setFontSize(FontSize::XXSmall);
	mCloudCover->setHorizontalAlignment(HorizontalAlignment::Center);

    mPressure = Label::create("");
    mPressure->textStyle()->setFontSize(FontSize::XXSmall);
	mPressure->setHorizontalAlignment(HorizontalAlignment::Center);

    mHumidity = Label::create("");
    mHumidity->textStyle()->setFontSize(FontSize::XXSmall);
	mHumidity->setHorizontalAlignment(HorizontalAlignment::Center);

    mSwellHeight = Label::create("");
    mSwellHeight->textStyle()->setFontSize(FontSize::XXSmall);
	mSwellHeight->setHorizontalAlignment(HorizontalAlignment::Center);

	mConditions = ImageView::create("asset:///images/conditions.png");

	mWindDirection = ImageView::create("asset:///images/wind_arrow.png");

	mSwellDirection = ImageView::create("asset:///images/swell_arrow.png");

    // Add the components to the full item container.
    itemContainer->add(mTime);
    itemContainer->add(mConditions);
    itemContainer->add(mWindSpeed);
    itemContainer->add(mWindDirection);
    itemContainer->add(mTemperatureBackground);
    itemContainer->add(mCloudCover);
    itemContainer->add(mPressure);
    itemContainer->add(mHumidity);
    itemContainer->add(mSwellHeight);
    itemContainer->add(mSwellDirection);

    setRoot(itemContainer);
}

void WeatherItem::setWindDirection(float direction) {
	mWindDirection->setRotationZ(direction);
}

void WeatherItem::setSwellDirection(float direction) {
	mSwellDirection->setRotationZ(direction);
}

ImageView* WeatherItem::getConditionsImage() {
	return mConditions;
}

void WeatherItem::setTime(const QString time) {
	mTime->setText(time);
}

void WeatherItem::setWindSpeed(const QString windSpeed) {
	mWindSpeed->setText(windSpeed);
}

void WeatherItem::setTemperature(QVariant temperature) {
	qDebug() << "\n WeatherItem temperature.toInt(): " << temperature.toInt();
	qDebug() << "\n WeatherItem getTempBackground: " << getTempBackground(temperature.toInt());

	mTemperature->setText(temperature.toString());
	
	ImagePaint paint(QUrl(getTempBackground(temperature.toInt())));
    mTemperatureBackground->setBackground(paint);
}

void WeatherItem::setCloudCover(const QString cloudCover) {
	mCloudCover->setText(cloudCover);
}

void WeatherItem::setPressure(const QString pressure) {
	mPressure->setText(pressure);
}

void WeatherItem::setHumidity(const QString humidity) {
	mHumidity->setText(humidity);
}

void WeatherItem::setSwellHeight(const QString swellHeight) {
	mSwellHeight->setText(swellHeight);
}

void WeatherItem::select(bool select)
{
	Q_UNUSED(select);
}

void WeatherItem::reset(bool selected, bool activated)
{
    Q_UNUSED(activated);
    Q_UNUSED(selected);
}

void WeatherItem::activate(bool activate)
{
	Q_UNUSED(activate);
}

QString WeatherItem::getTempBackground(int temperature) {
	if (temperature <= -10) {
		return QString("asset:///images/temperatures/1.png");
	}
	else if (temperature <= -7) {
		return QString("asset:///images/temperatures/2.png");
	}
	else if (temperature <= -5) {
		return QString("asset:///images/temperatures/3.png");
	}
	else if (temperature <= -2) {
		return QString("asset:///images/temperatures/4.png");
	}
	else if (temperature <= 0) {
		return QString("asset:///images/temperatures/5.png");
	}
	else if (temperature <= 3) {
		return QString("asset:///images/temperatures/6.png");
	}
	else if (temperature <= 5) {
		return QString("asset:///images/temperatures/7.png");
	}
	else if (temperature <= 8) {
		return QString("asset:///images/temperatures/8.png");
	}
	else if (temperature <= 10) {
		return QString("asset:///images/temperatures/9.png");
	}
	else if (temperature <= 13) {
		return QString("asset:///images/temperatures/10.png");
	}
	else if (temperature <= 15) {
		return QString("asset:///images/temperatures/11.png");
	}
	else if (temperature <= 18) {
		return QString("asset:///images/temperatures/12.png");
	}
	else if (temperature <= 20) {
		return QString("asset:///images/temperatures/13.png");
	}
	else if (temperature <= 23) {
		return QString("asset:///images/temperatures/14.png");
	}
	else if (temperature <= 25) {
		return QString("asset:///images/temperatures/15.png");
	}
	else if (temperature <= 28) {
		return QString("asset:///images/temperatures/16.png");
	}
	else if (temperature <= 30) {
		return QString("asset:///images/temperatures/17.png");
	}
	else if (temperature <= 33) {
		return QString("asset:///images/temperatures/18.png");
	}
	else if (temperature <= 35) {
		return QString("asset:///images/temperatures/19.png");
	}
	else if (temperature <= 38) {
		return QString("asset:///images/temperatures/20.png");
	}
	else if (temperature <= 40) {
		return QString("asset:///images/temperatures/21.png");
	}
	else if (temperature <= 43) {
		return QString("asset:///images/temperatures/22.png");
	}
	else if (temperature <= 45) {
		return QString("asset:///images/temperatures/23.png");
	}
	else if (temperature <= 48) {
		return QString("asset:///images/temperatures/24.png");
	}
	else {
		return QString("asset:///images/temperatures/25.png");
	}
}
