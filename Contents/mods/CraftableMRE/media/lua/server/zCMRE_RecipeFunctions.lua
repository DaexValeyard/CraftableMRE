require "recipecode"

-- Based on Recipe.OnCreate.MakeBowlOfStew4
function Recipe.OnCreate.LowCalorieMREOpen(items, result, player)
    for i=0,items:size() - 1 do
        local item = items:get(i)

        if item:getType() == "PotOfStew" then
            result:setBaseHunger(item:getBaseHunger());
            result:setHungChange(item:getHungChange() * 3 / 4);
            result:setThirstChange(item:getThirstChangeUnmodified() * 3 / 4);
            result:setBoredomChange(item:getBoredomChangeUnmodified() - 25);
            result:setUnhappyChange(item:getUnhappyChangeUnmodified() - 25);
            result:setCarbohydrates(item:getCarbohydrates());
            result:setLipids(item:getLipids());
            result:setProteins(item:getProteins());
            result:setCalories(item:getCalories());
            result:setTaintedWater(item:isTaintedWater());
        end
    end
    player:getInventory():AddItem("Base.Pot");
end

function Recipe.OnCreate.HighCalorieMREOpen(items, result, player)
    local validFoods = ArrayList.new();

    for i=0,items:size() - 1 do
        local item = items:get(i);
        if item:getType() == "PotOfStew" or item:getType() == "Salad" or item:getType() == "PanFriedVegetables" or
           item:getType() == "PanFriedVegetables2" or item:getType() == "GriddlePanFriedVegetables" then
            validFoods:add(item);
        end
    end

    -- Calculating the Result's properties --
    local BaseHunger = 0.0;
    local HungChange = 0.0;
    local ThirstChange = 0.0;
    local BoredomChange = 0.0;
    local UnhappyChange = 0.0;
    local Carbohydrates = 0.0;
    local Lipids = 0.0;
    local Proteins = 0.0;
    local Calories = 0.0;
    local TaintedWater = false;

    for i = 0, validFoods:size() - 1 do
        BaseHunger = BaseHunger + validFoods:get(i):getBaseHunger();
        HungChange = HungChange + validFoods:get(i):getHungChange();
        ThirstChange = ThirstChange + validFoods:get(i):getThirstChangeUnmodified();
        BoredomChange = BoredomChange + validFoods:get(i):getBoredomChangeUnmodified();
        UnhappyChange = UnhappyChange + validFoods:get(i):getUnhappyChangeUnmodified();
        Carbohydrates = Carbohydrates + validFoods:get(i):getCarbohydrates();
        Lipids = Lipids + validFoods:get(i):getLipids();
        Proteins = Proteins + validFoods:get(i):getProteins();
        Calories = Calories + validFoods:get(i):getCalories();
        TaintedWater = TaintedWater or validFoods:get(i):isTaintedWater();
    end

    result:setBaseHunger(BaseHunger);
    result:setHungChange(HungChange);
    result:setThirstChange(ThirstChange);
    result:setBoredomChange(BoredomChange - 50);
    result:setUnhappyChange(UnhappyChange - 50);
    result:setCarbohydrates(Carbohydrates);
    result:setLipids(Lipids);
    result:setProteins(Proteins);
    result:setCalories(Calories);
    result:setTaintedWater(TaintedWater);

    -- Adding Base Items to Player's inventory --
    for i=0,validFoods:size() - 1 do
        if validFoods:get(i):getType() == "PanFriedVegetables2" then 
            player:getInventory():AddItem("Base.RoastingPan");
        else if validFoods:get(i):getType() == "GriddlePanFriedVegetables" then 
            player:getInventory():AddItem("Base.GridlePan");
        else if validFoods:get(i):getType() == "PanFriedVegetables" then 
            player:getInventory():AddItem("Base.Pan");
            end
          end
        end
    end
    player:getInventory():AddItem("Base.Pot");
    player:getInventory():AddItem("Base.Bowl");
end

-- Sellando los MRE --
function Recipe.OnCreate.LowCalorieMRE(items, result, player)
    for i=0,items:size() - 1 do
        local item = items:get(i);

        if item:getType() == "HighCalorieMREOpen" or item:getType() == "LowCalorieMREOpen" then
            result:setBaseHunger(item:getBaseHunger());
            result:setHungChange(item:getHungChange());
            result:setThirstChange(item:getThirstChangeUnmodified());
            result:setBoredomChange(item:getBoredomChangeUnmodified());
            result:setUnhappyChange(item:getUnhappyChangeUnmodified());
            result:setCarbohydrates(item:getCarbohydrates());
            result:setLipids(item:getLipids());
            result:setProteins(item:getProteins());
            result:setCalories(item:getCalories());
            result:setTaintedWater(item:isTaintedWater());
            result:setRottenTime(item:getRottenTime());
        end
    end
end

function Recipe.OnTest.LowCalorieMREOpen(item)
    -- Funcion para determinar si se ha cocinado antes de sellar --
    if instanceof(item, "Food") then
        return item:isCooked();
    end

    return true;
end

-- Abriendo los MRE --
function Recipe.OnCreate.LowCalorieMREOpened(items, result, player)
    for i=0,items:size() - 1 do
        local item = items:get(i);

        if item:getType() == "HighCalorieMRE" or item:getType() == "LowCalorieMRE" then
            result:setBaseHunger(item:getBaseHunger());
            result:setHungChange(item:getHungChange());
            result:setThirstChange(item:getThirstChangeUnmodified());
            result:setBoredomChange(item:getBoredomChangeUnmodified());
            result:setUnhappyChange(item:getUnhappyChangeUnmodified());
            result:setCarbohydrates(item:getCarbohydrates());
            result:setLipids(item:getLipids());
            result:setProteins(item:getProteins());
            result:setCalories(item:getCalories());
            result:setTaintedWater(item:isTaintedWater());
            result:setRottenTime(item:getRottenTime());
            result:setCooked(true);
        end
    end
end