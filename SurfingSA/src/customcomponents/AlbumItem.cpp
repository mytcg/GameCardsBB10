#include "AlbumItem.h"

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

AlbumItem::AlbumItem(Container *parent) :
        CustomControl(parent)
{
    // Dock layout with margins inside
    Container *itemContainer = new Container();
    DockLayout *itemLayout = new DockLayout();
    itemContainer->setLayout(itemLayout);
    itemContainer->setBackground(ImagePaint(QUrl("asset:///images/customcomponents/title_gui_buffet_empty_box.amd"), RepeatPattern::XY));
    itemContainer->setHorizontalAlignment(HorizontalAlignment::Center);
    itemContainer->setMinHeight(150);
    itemContainer->setPreferredWidth(740);

    // Sub item container
	Container *subItemContainer = Container::create();
	subItemContainer->setLayout(new DockLayout());
	subItemContainer->setTopPadding(25);
	subItemContainer->setLeftPadding(25);
	subItemContainer->setRightPadding(25);
	subItemContainer->setHorizontalAlignment(HorizontalAlignment::Fill);
	subItemContainer->setVerticalAlignment(VerticalAlignment::Fill);

    // A Colored Container will be used to show if an item is highlighted
    mHighlighContainer = Container::create().background(Color::fromARGB(0xff75b5d3)).opacity(0.0);
    mHighlighContainer->setHorizontalAlignment(HorizontalAlignment::Fill);
    mHighlighContainer->setVerticalAlignment(VerticalAlignment::Fill);

    // The list item image, the actual image is set in updateItem
    mItemImage = ImageView::create("asset:///images/loadingthumb.png");
    mItemImage->setHorizontalAlignment(HorizontalAlignment::Left);
    mItemImage->setVerticalAlignment(VerticalAlignment::Top);

    mItemTitle = Label::create("Title");
    mItemTitle->setLayoutProperties(StackLayoutProperties::create().spaceQuota(1));
    mItemTitle->setHorizontalAlignment(HorizontalAlignment::Center);
    mItemTitle->setVerticalAlignment(VerticalAlignment::Top);

    mItemDescription = Label::create("Description");
    mItemDescription->textStyle()->setBase(SystemDefaults::TextStyles::subtitleText());
    mItemDescription->setHorizontalAlignment(HorizontalAlignment::Center);
    mItemDescription->setVerticalAlignment(VerticalAlignment::Center);
    mItemDescription->setMultiline(true);

    // Add the shopitem details to the subitem container
    subItemContainer->add(mItemImage);
    subItemContainer->add(mItemTitle);
    subItemContainer->add(mItemDescription);

    // Add the background image and the content to the full item container.
    itemContainer->add(mHighlighContainer);
    itemContainer->add(subItemContainer);

    setRoot(itemContainer);
}

void AlbumItem::updateItem(const QString imagePath)
{
    // Update image and text for the current item.
    mItemImage->setImage(Image(imagePath));
}

void AlbumItem::setTitle(const QString title) {
	mItemTitle->setText(title);
}

void AlbumItem::setDescription(const QString description) {
	mItemDescription->setText(description);
}

void AlbumItem::select(bool select)
{
    // When an item is selected, show the colored highlight Container.
    if (select) {
        mHighlighContainer->setOpacity(0.9f);
    } else {
        mHighlighContainer->setOpacity(0.0f);
    }
}

void AlbumItem::reset(bool selected, bool activated)
{
    Q_UNUSED(activated);

    // Since items are recycled the reset function is where we have
    // to make sure that item state, defined by the arguments, is correct.
    select(selected);
}

void AlbumItem::activate(bool activate)
{
    // There is no special activate state, select and activate looks the same.
    select(activate);
}

ImageView* AlbumItem::itemImage() {
	return  mItemImage;
}
