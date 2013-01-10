/* Copyright (c) 2012 Research In Motion Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "ShopItemFactory.h"
#include "ShopItem.h"

using namespace bb::cascades;

ShopItemFactory::ShopItemFactory(ImageLoader *loader): imageLoader(loader)
{
}

VisualNode * ShopItemFactory::createItem(ListView* list, const QString &type)
{
    //We only have one item type so we do not need to check the type variable.
    Q_UNUSED(type);
    Q_UNUSED(list);

    ShopItem *recipeItem = new ShopItem();
    return recipeItem;
}

void ShopItemFactory::updateItem(ListView* list, bb::cascades::VisualNode *listItem,
        const QString &type, const QVariantList &indexPath, const QVariant &data)
{
    Q_UNUSED(list);
    Q_UNUSED(indexPath);
    Q_UNUSED(type);

    // Update the control with the correct data.
    QVariantMap map = data.value<QVariantMap>();
    ShopItem *recipeItem = static_cast<ShopItem *>(listItem);
    //recipeItem->updateItem(map["fruit"].toString());
    ImageLoader *imloader = new ImageLoader();
    imloader->loadImage(map["productthumb"].toString(), recipeItem->itemImage());
}
