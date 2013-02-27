#include "ScoreItem.h"

#include <bb/cascades/Color>
#include <bb/cascades/Container>
#include <bb/cascades/SystemDefaults>
#include <bb/cascades/TextStyle>
#include <bb/cascades/Color>
#include <bb/cascades/StackLayout>
#include <bb/cascades/DockLayout>
#include <bb/cascades/StackLayoutProperties>
#include <bb/cascades/ImagePaint>

#include <bb/cascades/ImagePaint>

using namespace bb::cascades;

ScoreItem::ScoreItem(Container *parent) :
        CustomControl(parent)
{
	Container *outerContainer = new Container();
	DockLayout *outerItemLayout = new DockLayout();
	outerContainer->setLayout(outerItemLayout);
	outerContainer->setRightPadding(5);
	outerContainer->setHorizontalAlignment(HorizontalAlignment::Fill);
	outerContainer->setVerticalAlignment(VerticalAlignment::Center);

    // Dock layout with margins inside
	Container *itemContainer = new Container();
    StackLayout *itemLayout = new StackLayout();
    itemLayout->setOrientation(LayoutOrientation::TopToBottom);
    itemContainer->setBackground(ImagePaint(QUrl("asset:///images/scoring/big label.png"), RepeatPattern::Fill));
    itemContainer->setLayout(itemLayout);
    itemContainer->setTopPadding(10);
    itemContainer->setLeftPadding(10);
    itemContainer->setRightPadding(10);
    itemContainer->setBottomPadding(10);
    itemContainer->setRightMargin(10);
    itemContainer->setPreferredWidth(200);

    mHeader = Label::create("");
    mHeader->textStyle()->setFontSize(FontSize::XSmall);
    mHeader->textStyle()->setTextAlign(TextAlign::Center);
    mHeader->textStyle()->setColor(Color::Black);
    mHeader->setHorizontalAlignment(HorizontalAlignment::Center);
    mHeader->setMultiline(true);

    mScoresContainer = new Container();
    StackLayout *subItemLayout = new StackLayout();
    subItemLayout->setOrientation(LayoutOrientation::TopToBottom);
    mScoresContainer->setLayout(subItemLayout);
    mScoresContainer->setHorizontalAlignment(HorizontalAlignment::Fill);

    // Add the components to the full item container.
    itemContainer->add(mHeader);
    itemContainer->add(mScoresContainer);

    outerContainer->add(itemContainer);

    setRoot(outerContainer);
}

void ScoreItem::setHeader(const QString header) {
	mHeader->setText(header);
}

void ScoreItem::setScores(QVariantList scoreList) {
	mScoresContainer->removeAll();
	for (int i = 0; i < scoreList.size(); i++) {
		Container *waveContainer = new Container();
		DockLayout *itemLayout = new DockLayout();
		waveContainer->setBackground(ImagePaint(QUrl("asset:///images/scoring/cell.png"), RepeatPattern::Fill));
		waveContainer->setLayout(itemLayout);
		waveContainer->setHorizontalAlignment(HorizontalAlignment::Fill);
		waveContainer->setVerticalAlignment(VerticalAlignment::Center);

		Label *waveLabel = Label::create(scoreList[i].toString());
		waveLabel->textStyle()->setFontSize(FontSize::XSmall);
		waveLabel->textStyle()->setColor(Color::Black);
		waveLabel->setHorizontalAlignment(HorizontalAlignment::Center);

		waveContainer->add(waveLabel);
		mScoresContainer->add(waveContainer);
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
