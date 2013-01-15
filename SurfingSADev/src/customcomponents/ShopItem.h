#ifndef _SHOPITEM_H_
#define _SHOPITEM_H_

#include <bb/cascades/CustomControl>
#include <bb/cascades/ListItemListener>

using namespace bb::cascades;

namespace bb
{
    namespace cascades
    {
        class ImageView;
        class Container;
        class Label;
    }
}

class ShopItem: public bb::cascades::CustomControl, public ListItemListener
{
    Q_OBJECT

public:
    ShopItem(Container *parent = 0);

    /**
     * This function updates the data of the item.
     *
     * @param imagePath The path to the image content used for the item.
     */
    void updateItem(const QString imagePath);

    void setTitle(const QString title);

    void setDescription(const QString description);


    /**
     * ListItemListener interface function called when the select state changes.
     *
     * @param select True if the item has been selected, false if unselected
     */
    void select(bool select);

    /**
     * ListItemListener interface function called when an item needs to be reset.
     * Since items are recycled, the reset function is where we have
     * to make sure that item state, defined by the arguments, is correct.
     *
     * @param selected True if the item should appear selected, false if unselected
     * @param activated True if the item should appear activated, false if de-activated
     */
    void reset(bool selected, bool activated);

    /**
     * ListItemListener interface called when an item is activated/de-activated.
     *
     * @param activate True if the item has been activated, false if inactive.
     */
    void activate(bool activate);

    ImageView* itemImage();
private:

    // Item Controls
    ImageView *mItemImage;
    Container *mHighlighContainer;
    Label *mItemTitle, *mItemDescription;
};

#endif // ifndef _SHOPITEM_H_
