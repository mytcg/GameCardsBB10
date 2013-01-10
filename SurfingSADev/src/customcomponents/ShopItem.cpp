#include "ShopItem.h"

#include <bb/cascades/Color>
#include <bb/cascades/Container>
#include <bb/cascades/DockLayout>
#include <bb/cascades/ImageView>

using namespace bb::cascades;

ShopItem::ShopItem(Container *parent) :
        CustomControl(parent)
{
    // Dock layout with margins inside
    Container *itemContainer = new Container();
    DockLayout *itemLayout = new DockLayout();
    itemContainer->setLayout(itemLayout);

    // The white background item image with drop shadow
    ImageView *bkgImage = ImageView::create("asset:///images/customcomponents/title_gui_buffet_empty_box.amd");
    bkgImage->setHorizontalAlignment(HorizontalAlignment::Fill);
    bkgImage->setVerticalAlignment(VerticalAlignment::Fill);

    // A Colored Container will be used to show if an item is highlighted
    mHighlighContainer = Container::create().background(Color::fromARGB(0xff75b5d3)).opacity(0.0);
    mHighlighContainer->setHorizontalAlignment(HorizontalAlignment::Fill);
    mHighlighContainer->setVerticalAlignment(VerticalAlignment::Fill);

    // The list item image, the actual image is set in updateItem
    mItemImage = ImageView::create("asset:///images/customcomponents/white_photo.png");
    mItemImage->setHorizontalAlignment(HorizontalAlignment::Center);
    mItemImage->setVerticalAlignment(VerticalAlignment::Center);

    // Add the background image and the content to the full item container.
    itemContainer->add(bkgImage);
    itemContainer->add(mHighlighContainer);
    itemContainer->add(mItemImage);

    setRoot(itemContainer);
}

void ShopItem::updateItem(const QString imagePath)
{
    // Update image and text for the current item.
    mItemImage->setImage(Image(imagePath));
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
