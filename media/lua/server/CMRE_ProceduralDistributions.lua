require "Items/Distributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"

local ItemDist = {
    -- Items de cocina --
    {
        Distributions = {
            {"StoreCounterCleaning", 5},
            {"StoreKitchenDishes", 5},
            {"StoreKitchenPots", 10},
            {"StoreCounterBags", 5},
            {"StoreShelfCombo", 5},
            {"GigamartBakingMisc", 10},
            {"GigamartHousewares", 5},
            {"BakeryMisc", 2},
            {"GroceryStorageCrate1", 5},
            {"GroceryStorageCrate2", 5},
            {"GroceryStorageCrate3", 5},
        },
        Items = {
            "CrafteableMRE.MylarBag",
        }
    },
    -- Items industriales --
    {
        Distributions = {
            {"GigamartHousewares", 10},
            {"GigamartHouseElectronics", 5},
            {"StoreShelfCombo", 5},
        },
        Items = {
            "CrafteableMRE.VacuumSealer",
        }
    }
}

-- Función para añadir los items al mundo. Cortesía de stuck1a: 
-- https://theindiestone.com/forums/index.php?/topic/38165-quick-guide-how-to-mod-the-loot-distribution-system-distributionslua-proceduraldistributionslua/&do=findComment&comment=365101 --
local function getLootTable(strLootTableName)
    return ProceduralDistributions.list[strLootTableName];
end

local function insertItem(tLootTable, strItem, iWeight)
    table.insert(tLootTable.items, strItem);
    table.insert(tLootTable.items, iWeight);
end  

local function preDistributionMerge()
    for i=1, #ItemDist do
      for j=1, #(ItemDist[i].Distributions) do
        for k=1, #(ItemDist[i].Items) do
          local tLootTable = getLootTable(ItemDist[i].Distributions[j][1]);
          print(tLootTable);
          local strItem = ItemDist[i].Items[k];
          local iWeight = ItemDist[i].Distributions[j][2];

          insertItem(tLootTable, strItem, iWeight);
        end
      end
    end
end

Events.OnPreDistributionMerge.Add(preDistributionMerge);