//Original code
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}

//Since we are using new Player() to create a new player object, we need to ensure that the memory allocated by that new Player() creation is
// properly deleted/deallocated. To achieve this, everytime we no longer need the player, we can delete the player. Based on the code,
// that case happens when we fails to login the player by name (line 34 below), when the item is not exist (line 41 below), and when we reach
// the end of the function (line 53 below)

//My code
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // Delete the player if loading fails to avoid memory leak
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        delete player; // Delete the player if item creation fails to avoid memory leak
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    delete player; // Delete the player after it's no longer needed to avoid memory leak
}


