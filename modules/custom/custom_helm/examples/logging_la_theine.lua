-----------------------------------
-- (LOGGING) La Theine Plateau
-----------------------------------


local customHelm = require('modules/custom/custom_helm/custom_helm')
-----------------------------------
local m = Module:new('logging_la_theine')

xi.helm.helmInfo[xi.helmType.LOGGING].zone[xi.zone.LA_THEINE_PLATEAU] =
{
    dynamic = true,

    drops =
    {
        { customHelm.rate.VERY_COMMON, xi.item.ASH_LOG,                 'an ash log'                }, -- Ash Log           (24%)
        { customHelm.rate.COMMON,      xi.item.ARROWWOOD_LOG,           'an arrowwood log'          }, -- Arrowwood Log     (15%)
        { customHelm.rate.COMMON,      xi.item.MAPLE_LOG,               'a maple log'               }, -- Maple Log         (15%)
        { customHelm.rate.COMMON,      xi.item.CHESTNUT_LOG,            'a chestnut log'            }, -- Chestnut Log      (15%)
        { customHelm.rate.UNCOMMON,    xi.item.RONFAURE_CHESTNUT,       'a Ronfaure Chestnut'       }, -- Ronfaure Chestnut (10%)
        { customHelm.rate.UNCOMMON,    xi.item.BEECH_LOG,               'a beech log'               }, -- Beech Log         (10%)
        { customHelm.rate.RARE,        xi.item.BAG_OF_TREE_CUTTINGS,    'a bag of tree cuttings'    }, -- Tree Cuttings     ( 5%)
        { customHelm.rate.VERY_RARE,   xi.item.LANCEWOOD_LOG,           'a lancewood log'           }, -- Lance Wood Log    ( 1%)
    },

    points =
    {
        { -559.600, -0.408,  474.425 },
        { -501.531, -4.385,  426.270 },
        { -537.706, -4.983,  322.652 },
        { -483.112, -8.224,  242.392 },
        { -589.566, -9.653,  188.739 },

        { -374.182,-16.314,  -25.551 },
        { -285,766  -8.080,  -22.267 },
        { -354.630,-16.086,  -86.428 },
        { -102.629, -5.183,  -77.961 },
        {  26.730,   8.522, -201.566 },

        {  189.590, 14.195, -202.706 },
        {  273.782, 23.897, -274.483 },
        {  339.941, 24.843, -278.861 },
        {  122.292, 24.054,   -5.117 },
        {   58.177, 16.345,   77.151 },
    }
}

m:addOverride('xi.zones.La_Theine_Plateau.Zone.onInitialize', function(zone)
    super(zone)
    xi.helm.initZone(zone, xi.helmType.LOGGING)
end)

return m
