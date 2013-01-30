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
#include "AuctionItemFactory.h"
#include "AuctionItem.h"

using namespace bb::cascades;

AuctionItemFactory::AuctionItemFactory()
{
}

VisualNode * AuctionItemFactory::createItem(ListView* list, const QString &type)
{
    //We only have one item type so we do not need to check the type variable.
    Q_UNUSED(type);
    Q_UNUSED(list);

    AuctionItem *recipeItem = new AuctionItem();
    return recipeItem;
}

void AuctionItemFactory::updateItem(ListView* list, bb::cascades::VisualNode *listItem,
        const QString &type, const QVariantList &indexPath, const QVariant &data)
{
    Q_UNUSED(list);
    Q_UNUSED(indexPath);
    Q_UNUSED(type);

    // Update the control with the correct data.
    QVariantMap map = data.value<QVariantMap>();
    AuctionItem *recipeItem = static_cast<AuctionItem *>(listItem);
    //recipeItem->updateItem(map["fruit"].toString());

    ImageLoader *imloader = new ImageLoader();
    imloader->loadImage(map["thumburl"].toString(), recipeItem->itemImage(),"/cards/",".jpg");

    //set labels
    recipeItem->setTitle(map["description"].toString());
	if(map["lastBidUser"].toString().compare("")==0){
		recipeItem->setDescription("Opening Bid: " + map["openingbid"].toString() + "\nEnd Date: "+map["endDate"].toString());
	}else{
		recipeItem->setDescription("Current Bid: " + map["price"].toString()+" ("+map["lastBidUser"].toString()+")" + "\nEnd Date: "+map["endDate"].toString());
	}
}
