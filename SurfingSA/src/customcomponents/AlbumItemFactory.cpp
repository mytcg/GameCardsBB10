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
#include "AlbumItemFactory.h"
#include "AlbumItem.h"

using namespace bb::cascades;

AlbumItemFactory::AlbumItemFactory()
{
}

VisualNode * AlbumItemFactory::createItem(ListView* list, const QString &type)
{
    //We only have one item type so we do not need to check the type variable.
    Q_UNUSED(type);
    Q_UNUSED(list);

    AlbumItem *recipeItem = new AlbumItem();
    return recipeItem;
}

void AlbumItemFactory::updateItem(ListView* list, bb::cascades::VisualNode *listItem,
        const QString &type, const QVariantList &indexPath, const QVariant &data)
{
    Q_UNUSED(list);
    Q_UNUSED(indexPath);
    Q_UNUSED(type);

    // Update the control with the correct data.
    QVariantMap map = data.value<QVariantMap>();
    AlbumItem *recipeItem = static_cast<AlbumItem *>(listItem);
    //recipeItem->updateItem(map["fruit"].toString());
    if(map["quantity"].toString().compare("0")==0){
    	recipeItem->updateItem("asset:///images/emptythumb.png");
    }else{
    	ImageLoader *imloader = new ImageLoader();
    	imloader->loadImage(map["thumburl"].toString(), recipeItem->itemImage(),"/cards/",".jpg");
    }
    //set labels
    recipeItem->setTitle(map["description"].toString()+" ("+map["quantity"].toString()+")");

    recipeItem->setDescription("");
}
