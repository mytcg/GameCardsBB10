#ifndef _SCOREITEMFACTORY_H_
#define _SCOREITEMFACTORY_H_

#include <bb/cascades/ListItemProvider>

using namespace bb::cascades;

namespace bb
{
    namespace cascades
    {
        class ListView;
    }
}

/**
 * ShopItemFactory Description:
 *
 * Item manager for the sheet recipe, provides list items for selection
 * a new fruit in the second level drill down sheet navigation.
 * An item manager supplies item Controls for a list and updates
 * the contents of the items based on the data supplied in the list model.
 */
class ScoreItemFactory: public bb::cascades::ListItemProvider
{
public:
	ScoreItemFactory();

    /**
     * Creates a VisualNode for list to be used as a list item.
     *
     * @param list ListView for which the item should be created.
     * @param type List item type, the cookbook only have one type of item.
     * @return A VisualNode pointer to the created item.
     */
    VisualNode * createItem(ListView* list, const QString &type);

    /**
     * Updates a listItem based on the provided type, indexPath, and data.
     *
     * This function is called whenever an item is about to be shown, and also
     * when the data representation of the item (in the DataModel) has changed.
     *
     * @param list ListView holding the item to be updated.
     * @param listItem The List item to be updated.
     * @param type List item type, the list only have one type of item
     * @param indexPath Index path to the item that is to be updated.
     * @param data Data from the DataModel that corresponds to listItem.
     */
    void updateItem(ListView* list, VisualNode *listItem, const QString &type,
            const QVariantList &indexPath, const QVariant &data);
};

#endif // ifndef _SCOREITEMFACTORY_H_
