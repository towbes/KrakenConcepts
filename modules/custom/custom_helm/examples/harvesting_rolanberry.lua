-----------------------------------
-- (Harvesting) Rolanberry Fields
-----------------------------------


local customHelm = require("modules/custom/custom_helm/custom_helm")
-----------------------------------
local m = Module:new("harvesting_rolanberry")

xi.helm.helmInfo[xi.helm.type.HARVESTING].zones[xi.zone.ROLANBERRY_FIELDS] =
{
    dynamic = true,

    drops =
    {
        { customHelm.rate.VERY_COMMON, xi.item.INSECT_WING,                "an insect wing"                 }, -- Insect Wing     (24%)
        { customHelm.rate.COMMON,      xi.item.FLAX_FLOWER,                "a flax flower"                  }, -- Flax Flower     (15%)
        { customHelm.rate.COMMON,      xi.item.TREANT_BULB,                "a treant bulb"                  }, -- Treant Bulb     (15%)
        { customHelm.rate.COMMON,      xi.item.PIECE_OF_CRAWLER_COCOON,    "a piece of crawler cocoon"      }, -- Crawler Cocoon  (15%)
        { customHelm.rate.COMMON,      xi.item.BUNCH_OF_SAN_DORIAN_GRAPES, "a bunch of San D'orian grapes " }, -- SanDorian Grape (15%)
        { customHelm.rate.COMMON,      xi.item.ROLANBERRY,                 "a rolanberry"                   }, -- Rolanberry      (15%)
        { customHelm.rate.UNCOMMON,    xi.item.DAHLIA,                     "a dahlia"                       }, -- Dahlia          (10%)
        { customHelm.rate.UNCOMMON,    xi.item.WIJNRUIT,                   "a wijnruit"                     }, -- Wijnruit        (10%)
        { customHelm.rate.RARE,        xi.item.BUNCH_OF_ROYAL_GRAPES,      "a bunch of royal grapes "       }, -- Royal Grapes    ( 5%)
        { customHelm.rate.RARE,        xi.item.JUG_OF_HUMUS,               "a jug of humus"                 }, -- Humus           ( 5%)
        { customHelm.rate.VERY_RARE,   xi.item.BAG_OF_FRUIT_SEEDS,         "a bag of fruit seeds"           }, -- Fruit Seeds     ( 1%)
    },

    points =
    {
        { -341.450,  8.000,  161.26  },
        { -352.470,  8.070,  135.610 },
        { -415.230,  0.702,  160.237 },
        { -419.249,  0.756,  186.814 },
        { -390.252,  0.286,  -41.834 },
        { -362.128,  0.837,  -58.494 },
        { -191.456,  0.180, -127.792 },
        { -165.406,  0.503, -134.729 },

        { -181.594,  0.465, -257.763 },
        {  -86.456,  0.321, -276.604 },
        {  -93.725,  0.416, -318.256 },
        { -312.948, -7.907, -406.049 },
        { -343.012, -7.915, -414.648 },
        { -291.117, -7.616, -439.575 },
        { -287.413, -8.113, -465.131 },
        { -169.896,  0.115, -534.460 },

        { -118.986, -7.675, -629.980 },
        {  -84.792,  0.050, -584.552 },
        {   51.886, -7.600, -715.641 },
        {   -6.366, -8.123, -741.908 },
        {  -54.335,  0.342, -502.790 },
        {  -71.335,  0.342, -502.790 },
        {  -74.478,  0.286, -484.602 },
        {  -81.489,  0.000, -281.448 },
    }
}

m:addOverride("xi.zone.Rolanberry_Fields.Zone.onInitialize", function(zone)
    super(zone)
    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
end)

m:addOverride("xi.zone.Rolanberry Fields.Zone.onZoneWeatherChange", function(weatherType)
    super(onZoneWeatherChange)

    local drops = xi.helm.helmInfo[xi.helm.type.HARVESTING].zone[xi.zone.ROLANBERRY_FIELDS].drops

    -- loop through table and delete all matches
    for k, item in pairs(drops) do
        if
            item[2] == xi.item.RUSTY_PICK or
            item[2] == xi.item.BROKEN_HALCYON_FISHING_ROD or
            item[2] == xi.item.BROKEN_HUME_FISHING_ROD
        then
            table.remove(drops, k)
        end
    end

    -- if raining, add it back in
    if weatherType == xi.weather.RAIN or weatherType == xi.weather.SQUALL then
        table.insert(drops, { customHelm.rate.RARE,      xi.item.RUSTY_PICK,                 "a rusty pick"                 }) ---Rusty Pick         (5%)
        table.insert(drops, { customHelm.rate.VERY_RARE, xi.item.BROKEN_HALCYON_FISHING_ROD, "a broken halcyon fishing rod" }) -- Broken Halcyon Rod (1%)
    end
end)


m:addOverride("xi.zone.Pashhow_Marshlands.Zone.onGameDay", function()
    super()

    local drops = xi.helm.helmInfo[xi.helm.type.HARVESTING].zone[xi.zone.ROLANBERRY_FIELDS].drops

    -- loop through table and delete all matches
    for k, item in pairs(drops) do
        if
            item[2] == xi.item.WATER_CLUSTER or
            item[2] == xi.item.AQUAMARINE
        then
            table.remove(drops, k)
        end
    end

    -- Only available on Watersday
    if VanadielDayOfTheWeek() == xi.day.WATERSDAY then
        table.insert(drops, { customHelm.rate.RARE, xi.item.WATER_CLUSTER, "a water cluster" }) -- Water Cluster (5%)
    end

    -- Only available on New Moon
    if IsMoonNew() then
        table.insert(drops, { customHelm.rate.SUPER_RARE, xi.item.AQUAMARINE, "an aquamarine" }) -- Aquamarine (0.5%)
    end
end)

return m
