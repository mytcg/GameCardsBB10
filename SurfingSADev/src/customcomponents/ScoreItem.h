#ifndef _SCOREITEM_H_
#define _SCOREITEM_H_

#include <bb/cascades/CustomControl>
#include <bb/cascades/ListItemListener>
#include <bb/cascades/ImageView>
#include <bb/cascades/Label>

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

class ScoreItem: public bb::cascades::CustomControl, public ListItemListener
{
    Q_OBJECT

public:
    ScoreItem(Container *parent = 0);

    void setHeader(const QString header);

    void setScores(QVariantList scoreList);

    void addScore(const QString score);

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
private:

    // Item Controls
	Container *mScoresContainer;
    Label *mHeader;
};

#endif // ifndef _SCOREITEM_H_
