#include "ScoreItem.h"

#include <bb/cascades/Color>
#include <bb/cascades/Container>
#include <bb/cascades/SystemDefaults>
#include <bb/cascades/TextStyle>
#include <bb/cascades/Color>
#include <bb/cascades/StackLayout>
#include <bb/cascades/StackLayoutProperties>
#include <bb/cascades/ImagePaint>

#include <bb/cascades/ImagePaint>

using namespace bb::cascades;

ScoreItem::ScoreItem(Container *parent) :
        CustomControl(parent)
{
    // Dock layout with margins inside
	Container *itemContainer = new Container();
    StackLayout *itemLayout = new StackLayout();
    itemLayout->setOrientation(LayoutOrientation::TopToBottom);
    itemContainer->setBackground(ImagePaint(QUrl("asset:///images/customcomponents/title_gui_buffet_empty_box.amd"), RepeatPattern::XY));
    itemContainer->setLayout(itemLayout);
    itemContainer->setTopPadding(20);
    itemContainer->setLeftPadding(20);
    itemContainer->setRightPadding(20);
    itemContainer->setBottomPadding(20);
    itemContainer->setPreferredWidth(200);

    mHeader = Label::create("Name!!!");
    mHeader->textStyle()->setFontSize(FontSize::XSmall);
    mHeader->textStyle()->setTextAlign(TextAlign::Center);
    mHeader->textStyle()->setColor(Color::Black);
    mHeader->setHorizontalAlignment(HorizontalAlignment::Center);
    mHeader->setMultiline(true);

    mScoresContainer = new Container();
    StackLayout *subItemLayout = new StackLayout();
    subItemLayout->setOrientation(LayoutOrientation::TopToBottom);
    mScoresContainer->setLayout(subItemLayout);
    mScoresContainer->setHorizontalAlignment(HorizontalAlignment::Center);

    // Add the components to the full item container.
    itemContainer->add(mHeader);
    itemContainer->add(mScoresContainer);

    setRoot(itemContainer);
}

void ScoreItem::setHeader(const QString header) {
	mHeader->setText(header);
}

void ScoreItem::setScores(QVariantList scoreList) {
	mScoresContainer->removeAll();
	for (int i = 0; i < scoreList.size(); i++) {
		Label *waveLabel = Label::create(scoreList[i].toString());
		waveLabel->textStyle()->setFontSize(FontSize::XSmall);
		waveLabel->textStyle()->setColor(Color::Black);
		waveLabel->setHorizontalAlignment(HorizontalAlignment::Center);

		mScoresContainer->add(waveLabel);
	}
}

void ScoreItem::addScore(const QString score) {
	qDebug() << "\n ScoreItemFactory score: " << score;
}

void ScoreItem::select(bool select)
{
	Q_UNUSED(select);
}

void ScoreItem::reset(bool selected, bool activated)
{
    Q_UNUSED(activated);
    Q_UNUSED(selected);
}

void ScoreItem::activate(bool activate)
{
	Q_UNUSED(activate);
}
