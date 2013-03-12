#include "ShopItem.h"

#include <bb/cascades/Color>
#include <bb/cascades/Container>
#include <bb/cascades/DockLayout>
#include <bb/cascades/ImageView>
#include <bb/cascades/Label>
#include <bb/cascades/SystemDefaults>
#include <bb/cascades/TextStyle>
#include <bb/cascades/Color>
#include <bb/cascades/StackLayout>
#include <bb/cascades/StackLayoutProperties>
#include <bb/cascades/ImagePaint>

using namespace bb::cascades;

ShopItem::ShopItem(Container *parent) :
        CustomControl(parent)
{
    // Dock layout with margins inside
    Container *itemContainer = new Container();
    DockLayout *itemLayout = new DockLayout();
    itemContainer->setLayout(itemLayout);
    itemContainer->setBackground(ImagePaint(QUrl("asset:///images/customcomponents/list_background.png"), RepeatPattern::XY));
	itemContainer->setHorizontalAlignment(HorizontalAlignment::Center);
	itemContainer->setMinHeight(180);
	itemContainer->setPreferredWidth(740);

	// Sub item container
	Container *subItemContainer = Container::create();
	StackLayout *stackLayout = new StackLayout();
	stackLayout->setOrientation( LayoutOrientation::LeftToRight );
	subItemContainer->setLayout(stackLayout);
	subItemContainer->setTopPadding(10);
	subItemContainer->setLeftPadding(10);
	subItemContainer->setRightPadding(10);
	subItemContainer->setBottomPadding(13);
	subItemContainer->setHorizontalAlignment(HorizontalAlignment::Fill);
	subItemContainer->setVerticalAlignment(VerticalAlignment::Fill);

    // A Colored Container will be used to show if an item is highlighted
    mHighlighContainer = Container::create().background(Color::fromARGB(0xff75b5d3)).opacity(0.0);
    mHighlighContainer->setHorizontalAlignment(HorizontalAlignment::Fill);
    mHighlighContainer->setVerticalAlignment(VerticalAlignment::Fill);

    // The list item image, the actual image is set in updateItem
    mItemImage = ImageView::create("asset:///images/loading.jpg");
    mItemImage->setHorizontalAlignment(HorizontalAlignment::Left);
    mItemImage->setVerticalAlignment(VerticalAlignment::Top);
    mItemImage->setPreferredSize(144.0, 192.0);

    // Sub item container
	Container *textContainer = Container::create();
	StackLayout *textLayout = new StackLayout();
	textLayout->setOrientation( LayoutOrientation::TopToBottom );
	textContainer->setLayout(textLayout);

    mItemTitle = Label::create("Title");
    mItemTitle->textStyle()->setColor(Color::DarkGray);
	mItemTitle->setHorizontalAlignment(HorizontalAlignment::Left);

	mItemDescription = Label::create("Description");
	mItemDescription->textStyle()->setColor(Color::DarkGray);
	mItemDescription->textStyle()->setBase(SystemDefaults::TextStyles::subtitleText());
	mItemDescription->setHorizontalAlignment(HorizontalAlignment::Left);
	mItemDescription->setMultiline(true);

	//add the labels to textContainer
	textContainer->add(mItemTitle);
	textContainer->add(mItemDescription);

    // Add the shopitem details to the subitem container
    subItemContainer->add(mItemImage);
    subItemContainer->add(textContainer);

    // Add the background image and the content to the full item container.
    itemContainer->add(mHighlighContainer);
    itemContainer->add(subItemContainer);

    setRoot(itemContainer);
}

void ShopItem::updateItem(const QString imagePath)
{
    // Update image and text for the current item.
    mItemImage->setImage(Image(imagePath));
}

void ShopItem::setTitle(const QString title) {
	mItemTitle->setText(title);
}

void ShopItem::setDescription(const QString description) {
	mItemDescription->setText(description);
}

void ShopItem::select(bool select)
{
    // When an item is selected, show the colored highlight Container.
    if (select) {
        mHighlighContainer->setOpacity(0.9f);
    } else {
        mHighlighContainer->setOpacity(0.0f);
    }
}

void ShopItem::reset(bool selected, bool activated)
{
    Q_UNUSED(activated);

    // Since items are recycled the reset function is where we have
    // to make sure that item state, defined by the arguments, is correct.
    select(selected);
}

void ShopItem::activate(bool activate)
{
    // There is no special activate state, select and activate looks the same.
    select(activate);
}

ImageView* ShopItem::itemImage() {
	return  mItemImage;
}
