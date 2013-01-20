#include "WeatherItem.h"

#include <bb/cascades/Color>
#include <bb/cascades/Container>
#include <bb/cascades/SystemDefaults>
#include <bb/cascades/TextStyle>
#include <bb/cascades/Color>
#include <bb/cascades/StackLayout>
#include <bb/cascades/StackLayoutProperties>

using namespace bb::cascades;

WeatherItem::WeatherItem(Container *parent) :
        CustomControl(parent)
{
    // Dock layout with margins inside
    Container *itemContainer = new Container();
    StackLayout *itemLayout = new StackLayout();
    itemLayout->setOrientation( LayoutOrientation::TopToBottom );
    itemContainer->setLayout(itemLayout);
    itemContainer->setBackground(Color::LightGray);

    mTime = Label::create("");
    mTime->textStyle()->setFontSize(FontSize::XSmall);

    mWindSpeed = Label::create("");
    mWindSpeed->textStyle()->setFontSize(FontSize::XSmall);

    mTemperature = Label::create("");
    mTemperature->textStyle()->setFontSize(FontSize::XSmall);

    mCloudCover = Label::create("");
    mCloudCover->textStyle()->setFontSize(FontSize::XSmall);

    mPressure = Label::create("");
    mPressure->textStyle()->setFontSize(FontSize::XSmall);

    mHumidity = Label::create("");
    mHumidity->textStyle()->setFontSize(FontSize::XSmall);

    mSwellHeight = Label::create("");
    mSwellHeight->textStyle()->setFontSize(FontSize::XSmall);

	mConditions = ImageView::create("asset:///images/loadingthumb.png");

	mWindDirection = ImageView::create("asset:///images/arrow.png");

	mSwellDirection = ImageView::create("asset:///images/arrow.png");

    // Add the components to the full item container.
    itemContainer->add(mTime);
    itemContainer->add(mConditions);
    itemContainer->add(mWindSpeed);
    itemContainer->add(mWindDirection);
    itemContainer->add(mTemperature);
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

void WeatherItem::setTemperature(const QString temperature) {
	mTemperature->setText(temperature);
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
}

void WeatherItem::reset(bool selected, bool activated)
{
    Q_UNUSED(activated);
}

void WeatherItem::activate(bool activate)
{
}
