--[[
  v0.2
--]]

--[[ MODIFIED ITEMS ]]--
--- Torch
--- HandTorch
--- Battery
--- Lighter
--- Matches
--- Lightbulb
--- Colored Lightbulbs [x9] (TAG:ColoredLightbulbConsumption)
--- CandleLit
--- Generator
--- CarBattery1, CarBattery2, CarBattery3 (TAG:CarBatteryConsumption)
--- PetrolCan
--- BlowTorch
--- WeldingRods
--- PropaneTank
--- DuctTape
--- Woodglue
--- Glue
--- Wire
--- Twine
--- Thread
--- Soap
--- Cleaning Liquid
--- Bleach
--- DishCloth, BathTowel (TAG:TowelsConsumption)
--- Pills
--- PillsAntiDep
--- PillsBeta
--- PillsSleepingTablets
--- PillsVitamins
--- Disinfectant
--- AlcoholWipes
--- Colored Paints [x15] (TAG:ColoredPaintsConsumption)
--- Gravelbag
--- Dirtbag
--- Sandbag
--- CompostBag
--- BucketPlasterFull
--- BucketWaterFull
--- WaterPaintbucket
--- WateredCanFull
--- GardeningSprayMilk, GardeningSprayCigarettes (TAG:GardeningSprayConsumption)
--- Fertilizer
--- Charcoal
--- Extinguisher
--- FishingLine
--- GunPowder
--- Hair Dyes [x10] (TAG:HairDyesConsumption)
--- Flour, Cornflour (TAG:FlourConsumption)
--- BakingSoda
--- Yeast
--- Vinegar
--- PancakeMix
--- GravyMix
--- RadioRed, RadioBlack, RadioMakeShift (TAG:RadiosConsumption)
--- HamRadio1, HamRadio2, HamRadioMakeShift (TAG:HamRadiosConsumption)
--- WalkieTalkie1, WalkieTalkie2, WalkieTalkie3, WalkieTalkie4, WalkieTalkie5, WalkieTalkieMakeShift (TAG:WalkieTalkieConsumption)

local debugMode = false

local function setLocalSandboxVars()
  local vars = {
    TorchConsumption = 1,
    BatteryConsumption = 1,
    SoapConsumption = 1,
    LighterConsumption = 1,
    MatchesConsumption = 1,
    LightbulbConsumption = 1,
    ColoredLightbulbConsumption = 1,
    BlowTorchConsumption = 1,
    WeldingRodsConsumption = 1,
    GeneratorConsumption = 1,
    DuctTapeConsumption = 1,
    GlueConsumption = 1,
    WoodGlueConsumption = 1,
    CleaningLiquidConsumption = 1,
    BleachConsumption = 1,
    FishingLineConsumption = 1,
    TwineConsumption = 1,
    WireConsumption = 1,
    ThreadConsumption = 1,
    TowelsConsumption = 1,
    PlasterBucketConsumption = 1,
    BucketWaterConsumption = 1,    
    PaintBucketWaterConsumption = 1,
    CandleLitConsumption = 1,
    GravelBagConsumption = 1,
    SandBagConsumption = 1,
    DirtBagConsumption = 1,
    CompostBagConsumption = 1,
    ColoredPaintsConsumption = 1,
    PetrolCanConsumption = 1,
    PropaneTankConsumption = 1,
    CharcoalConsumption = 1,
    PillsConsumption = 1,
    PillsAntiDepConsumption = 1,
    PillsBetaConsumption = 1,
    PillsSleepingTabletsConsumption = 1,
    PillsVitaminsConsumption = 1,
    FertilizerConsumption = 1,
    GunPowderConsumption = 1,
    ExtinguisherConsumption = 1,
    DisinfectantConsumption = 1,
    AlcoholWipesConsumption = 1,
    HairDyesConsumption = 1,
    WateredCanFullConsumption = 1,
    GardeningSprayConsumption = 1,
    CarBatteryConsumption = 1,
    FlourConsumption = 1,
    BakingSodaConsumption = 1,
    YeastConsumption = 1,
    VinegarConsumption = 1,
    PancakeMixConsumption = 1,
    GravyMixConsumption = 1,
    RadiosConsumption = 1,
    HamRadiosConsumption = 1,
    WalkieTalkieConsumption = 1,
    SubCategory = 0,
  }
  for key, value in pairs(SandboxVars.CustomConsumption) do
    local defaultValue = vars[key]
    vars[key] = value or defaultValue
  end
  return vars
end

local function adjustItem(Name, Property, Value)
  local Item = ScriptManager.instance:getItem(Name)
  print(Item)
  Item:DoParam(Property.." = "..Value)
end

local function round(number, decimals)
  local power = 10^decimals
  return math.ceil(number * power) / power
end


local function initCustomConsumption()
  local vars = setLocalSandboxVars()
  --[[
  Modifies Torch (= Flashlight) consumption from 0.0009 (Default)
  --]]
  adjustItem("Base.Torch", "UseDelta", 0.0009 / vars.TorchConsumption)
  --[[
  Modifies HandTorch consumption from 0.0004 (Default)
  --]]
  adjustItem("Base.HandTorch", "UseDelta", 0.0004 / vars.HandTorchConsumption)
  --[[
  Modifies Battery consumption from 0.00001 (Default)
  --]]
  adjustItem("Base.Battery", "UseDelta", 0.00001 / vars.BatteryConsumption)
  --[[
  Modifies Soap2 consumption from 0.05 (Default)
  --]]
  adjustItem("Base.Soap2", "UseDelta", 0.05 / vars.SoapConsumption)
  --[[
  Modifies Lighter consumption [from 0.03 (estimate)]
  Modifies Lighter "ticksPerEquipUse" [as a light source] from 110 (Default)
  --]]
  adjustItem("Base.Lighter", "UseDelta", 0.03 / vars.LighterConsumption)
  adjustItem("Base.Lighter", "ticksPerEquipUse", math.ceil(110 * vars.LighterConsumption))
  --[[
  Modifies Matches consumption from 0.1
  --]]
  adjustItem("Base.Matches", "UseDelta", 0.1 / vars.MatchesConsumption)
  --[[
  Modifies lightbulb "ConditionMax" from 100 (Default)
  --]]
  adjustItem("Base.LightBulb", "ConditionMax", math.ceil(100 * vars.LightbulbConsumption))
  --[[
  Modifies colored lightbulbs "ConditionMax" from 10 (Default)
  --]]
  adjustItem("Base.LightBulbRed", "ConditionMax", math.ceil(10 * vars.ColoredLightbulbConsumption))
  adjustItem("Base.LightBulbGreen", "ConditionMax", math.ceil(10 * vars.ColoredLightbulbConsumption))
  adjustItem("Base.LightBulbBlue", "ConditionMax", math.ceil(10 * vars.ColoredLightbulbConsumption))
  adjustItem("Base.LightBulbYellow", "ConditionMax", math.ceil(10 * vars.ColoredLightbulbConsumption))
  adjustItem("Base.LightBulbCyan", "ConditionMax", math.ceil(10 * vars.ColoredLightbulbConsumption))
  adjustItem("Base.LightBulbMagenta", "ConditionMax", math.ceil(10 * vars.ColoredLightbulbConsumption))
  adjustItem("Base.LightBulbOrange", "ConditionMax", math.ceil(10 * vars.ColoredLightbulbConsumption))
  adjustItem("Base.LightBulbPurple", "ConditionMax", math.ceil(10 * vars.ColoredLightbulbConsumption))
  adjustItem("Base.LightBulbPink", "ConditionMax", math.ceil(10 * vars.ColoredLightbulbConsumption))
  --[[
  Modifies BlowTorch consumption from 0.1 (Default)
  --]]
  adjustItem("Base.BlowTorch", "UseDelta", 0.1 / vars.BlowTorchConsumption)
  --[[
  Modifies WeldingRods consumption from 0.05 (Default)
  --]]
  adjustItem("Base.WeldingRods", "UseDelta", 0.05 / vars.WeldingRodsConsumption)
  --[[
  Modifies Generator "ConditionMax" from 100 (Default)
  --]]
  adjustItem("Base.Generator", "ConditionMax", math.ceil(100 * vars.GeneratorConsumption))
  --[[
  Modifies DuctTape consumption from 0.25 (Default)
  --]]
  adjustItem("Base.DuctTape", "UseDelta", 0.25 / vars.DuctTapeConsumption)
  --[[
  Modifies Woodglue consumption from 0.2 (Default)
  --]]
  adjustItem("Base.Woodglue", "UseDelta", 0.2 / vars.WoodGlueConsumption)
  --[[
  Modifies Glue consumption from 0.2 (Default)
  --]]
  adjustItem("Base.Glue", "UseDelta", 0.2 / vars.GlueConsumption)
  --[[
  Modifies Bleach "ThirstChange" from -60 (Default)
  --]]
  adjustItem("Base.Bleach", "ThirstChange", -60 * vars.BleachConsumption)
  --[[
  Modifies CleaningLiquid2 consumption from 0.02 (Default)
  --]]
  adjustItem("Base.CleaningLiquid2", "UseDelta", 0.02 / vars.CleaningLiquidConsumption)
  --[[
  Modifies FishingLine consumption from 0.1 (Default)
  --]]
  adjustItem("Base.FishingLine", "UseDelta", 0.1 / vars.FishingLineConsumption)
  --[[
  Modifies Twine consumption from 0.2 (Default)
  --]]
  adjustItem("Base.Twine", "UseDelta", 0.2 / vars.TwineConsumption)
  --[[
  Modifies Wire consumption from 0.2 (Default)
  --]]
  adjustItem("Base.Wire", "UseDelta", 0.2 / vars.WireConsumption)
  --[[
  Modifies Thread consumption from 0.1 (Default)
  --]]
  adjustItem("Base.Thread", "UseDelta", 0.1 / vars.ThreadConsumption)
  --[[
  Modifies DishCloth consumption from 0.1 (Default)
  Modifies BathTowel consumption from 0.1 (Default)
  --]]
  adjustItem("Base.DishCloth", "UseDelta", 0.1 / vars.TowelsConsumption)
  adjustItem("Base.BathTowel", "UseDelta", 0.1 / vars.TowelsConsumption)
  --[[
  Modifies BucketPlasterFull consumption from 0.1 (Default)
  --]]
  adjustItem("Base.BucketPlasterFull", "UseDelta", 0.1 / vars.PlasterBucketConsumption)
  --[[
  Modifies BucketWaterFull consumption from 0.04 (Default)
  --]]
  adjustItem("Base.BucketWaterFull", "UseDelta", 0.04 / vars.BucketWaterConsumption)
  --[[
  Modifies WaterPaintbucket consumption from 0.04 (Default)
  --]]
  adjustItem("Base.WaterPaintbucket", "UseDelta", 0.04 / vars.PaintBucketWaterConsumption)
  --[[
  Modifies CandleLit consumption from 0.003 (Default)
  --]]
  adjustItem("Base.CandleLit", "UseDelta", 0.003 / vars.CandleLitConsumption)
  --[[
  Modifies Gravelbag consumption from 0.25 (Default)
  --]]
  adjustItem("Base.Gravelbag", "UseDelta", 0.25 / vars.GravelBagConsumption)
  --[[
  Modifies Dirtbag consumption from 0.25 (Default)
  --]]
  adjustItem("Base.Dirtbag", "UseDelta", 0.25 / vars.DirtBagConsumption)
  --[[
  Modifies Sandbag consumption from 0.25 (Default)
  --]]
  adjustItem("Base.Sandbag", "UseDelta", 0.25 / vars.SandBagConsumption)
  --[[
  Modifies CompostBag consumption from 0.25 (Default)
  --]]
  adjustItem("Base.CompostBag", "UseDelta", 0.25 / vars.CompostBagConsumption)
  --[[
  Modifies colored paints consumption from 0.1 (Default)
  --]]
  adjustItem("Base.PaintRed", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintBlack", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintBlue", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintBrown", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintCyan", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintGreen", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintGrey", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintLightBlue", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintLightBrown", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintOrange", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintPink", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintPurple", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintTurquoise", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintWhite", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  adjustItem("Base.PaintYellow", "UseDelta", 0.1 / vars.ColoredPaintsConsumption)
  --[[
  Modifies PetrolCan (=gas can) consumption from 0.125 (Default)
  --]]
  adjustItem("Base.PetrolCan", "UseDelta", 0.125 / vars.PetrolCanConsumption)
  --[[
  Modifies PropaneTank consumption from 0.0625 (Default)
  --]]
  adjustItem("Base.PropaneTank", "UseDelta", 0.0625 / vars.PropaneTankConsumption)
  --[[
  Modifies Charcoal consumption from 0.1 (Default)
  --]]
  adjustItem("Base.Charcoal", "UseDelta", 0.1 / vars.CharcoalConsumption)
  --[[
  Modifies Pills consumption from 0.1 (Default)
  --]]
  adjustItem("Base.Pills", "UseDelta", 0.1 / vars.PillsConsumption)
  --[[
  Modifies PillsAntiDep consumption from 0.1 (Default)
  --]]
  adjustItem("Base.PillsAntiDep", "UseDelta", 0.1 / vars.PillsAntiDepConsumption)
  --[[
  Modifies PillsBeta consumption from 0.1 (Default)
  --]]
  adjustItem("Base.PillsBeta", "UseDelta", 0.1 / vars.PillsBetaConsumption)
  --[[
  Modifies PillsSleepingTablets consumption from 0.1 (Default)
  --]]
  adjustItem("Base.PillsSleepingTablets", "UseDelta", 0.1 / vars.PillsSleepingTabletsConsumption)
  --[[
  Modifies PillsVitamins consumption from 0.1 (Default)
  --]]
  adjustItem("Base.PillsVitamins", "UseDelta", 0.1 / vars.PillsVitaminsConsumption)
  --[[
  Modifies Fertilizer consumption from 0.25 (Default)
  --]]
  adjustItem("Base.Fertilizer", "UseDelta", 0.25 / vars.FertilizerConsumption)
  --[[
  Modifies GunPowder consumption from 0.1 (Default)
  --]]
  adjustItem("Base.GunPowder", "UseDelta", 0.1 / vars.GunPowderConsumption)
  --[[
  Modifies Extinguisher consumption from 0.1 (Default)
  --]]
  adjustItem("Base.Extinguisher", "UseDelta", 0.1 / vars.ExtinguisherConsumption)
  --[[
  Modifies Disinfectant consumption from 0.1 (Default)
  --]]
  adjustItem("Base.Disinfectant", "UseDelta", 0.1 / vars.DisinfectantConsumption)
  --[[
  Modifies AlcoholWipes consumption from 0.2 (Default)
  --]]
  adjustItem("Base.AlcoholWipes", "UseDelta", 0.2 / vars.AlcoholWipesConsumption)
  --[[
  Modifies hair dyes consumption from 0.5 (Default)
  --]]
  adjustItem("Base.HairDyeBlonde", "UseDelta", 0.5 / vars.HairDyesConsumption)
  adjustItem("Base.HairDyeBlack", "UseDelta", 0.5 / vars.HairDyesConsumption)
  adjustItem("Base.HairDyeWhite", "UseDelta", 0.5 / vars.HairDyesConsumption)
  adjustItem("Base.HairDyePink", "UseDelta", 0.5 / vars.HairDyesConsumption)
  adjustItem("Base.HairDyeYellow", "UseDelta", 0.5 / vars.HairDyesConsumption)
  adjustItem("Base.HairDyeRed", "UseDelta", 0.5 / vars.HairDyesConsumption)
  adjustItem("Base.HairDyeGinger", "UseDelta", 0.5 / vars.HairDyesConsumption)
  adjustItem("Base.HairDyeLightBrown", "UseDelta", 0.5 / vars.HairDyesConsumption)
  adjustItem("Base.HairDyeGreen", "UseDelta", 0.5 / vars.HairDyesConsumption)
  adjustItem("Base.HairDyeBlue", "UseDelta", 0.5 / vars.HairDyesConsumption)
  --[[
  Modifies WateredCanFull consumption from 0.025 (Default)
  --]]
  adjustItem("farming.WateredCanFull", "UseDelta", 0.025 / vars.WateredCanFullConsumption)
  --[[
  Modifies GardeningSprayMilk consumption from 0.1 (Default)
  Modifies GardeningSprayCigarettes consumption from 0.1 (Default)
  --]]
  adjustItem("farming.GardeningSprayMilk", "UseDelta", 0.1 / vars.GardeningSprayConsumption)
  adjustItem("farming.GardeningSprayCigarettes", "UseDelta", 0.1 / vars.GardeningSprayConsumption)
  --[[
  Modifies CarBattery1 consumption from 0.00001 (Default)
  Modifies CarBattery2 consumption from 0.00001 (Default)
  Modifies CarBattery3 consumption from 0.00001 (Default)
  --]]
  adjustItem("Base.CarBattery1", "UseDelta", 0.00001 / vars.CarBatteryConsumption)
  adjustItem("Base.CarBattery2", "UseDelta", 0.00001 / vars.CarBatteryConsumption)
  adjustItem("Base.CarBattery3", "UseDelta", 0.00001 / vars.CarBatteryConsumption)
  --[[
  Modifies Flour consumption from 0.1 (Default)
  Modifies Cornflour consumption from 0.1 (Default)
  --]]
  adjustItem("Base.Flour", "UseDelta", 0.1 / vars.FlourConsumption)
  adjustItem("Base.Cornflour", "UseDelta", 0.1 / vars.FlourConsumption)
  --[[
  Modifies BakingSoda consumption from 0.1 (Default)
  --]]
  adjustItem("Base.BakingSoda", "UseDelta", 0.1 / vars.BakingSodaConsumption)
  --[[
  Modifies Yeast consumption from 0.2 (Default)
  --]]
  adjustItem("Base.Yeast", "UseDelta", 0.2 / vars.YeastConsumption)
  --[[
  Modifies Vinegar consumption from 0.1 (Default)
  --]]
  adjustItem("Base.Vinegar", "UseDelta", 0.1 / vars.VinegarConsumption)
  --[[
  Modifies PancakeMix consumption from 0.25 (Default)
  --]]
  adjustItem("Base.PancakeMix", "UseDelta", 0.25 / vars.PancakeMixConsumption)
  --[[
  Modifies GravyMix consumption from 0.5 (Default)
  --]]
  adjustItem("Base.GravyMix", "UseDelta", 0.5 / vars.GravyMixConsumption)
  --[[
  Modifies HamRadio1 consumption from 0.01 (Default)
  Modifies HamRadio2 consumption from 0.014 (Default)
  Modifies HamRadioMakeShift consumption from 0.01 (Default)
  --]]
  adjustItem("Radio.HamRadio1", "UseDelta", 0.01 / vars.HamRadiosConsumption)
  adjustItem("Radio.HamRadio2", "UseDelta", 0.014 / vars.HamRadiosConsumption)
  adjustItem("Radio.HamRadioMakeShift", "UseDelta", 0.01 / vars.HamRadiosConsumption)
  --[[
  Modifies RadioRed consumption from 0.009 (Default)
  Modifies RadioBlack consumption from 0.007 (Default)
  Modifies RadioMakeShift consumption from 0.007 (Default)
  --]]
  adjustItem("Radio.RadioRed", "UseDelta", 0.009 / vars.RadiosConsumption)
  adjustItem("Radio.RadioBlack", "UseDelta", 0.007 / vars.RadiosConsumption)
  adjustItem("Radio.RadioMakeShift", "UseDelta", 0.007 / vars.RadiosConsumption)
  --[[
  Modifies WalkieTalkie1 consumption from 0.007 (Default)
  Modifies WalkieTalkie2 consumption from 0.008 (Default)
  Modifies WalkieTalkie3 consumption from 0.009 (Default)
  Modifies WalkieTalkie4 consumption from 0.01 (Default)
  Modifies WalkieTalkie5 consumption from 0.014 (Default)
  Modifies WalkieTalkieMakeShift consumption from 0.007 (Default)
  --]]
  adjustItem("Radio.WalkieTalkie1", "UseDelta", 0.007 / vars.WalkieTalkieConsumption)
  adjustItem("Radio.WalkieTalkie2", "UseDelta", 0.008 / vars.WalkieTalkieConsumption)
  adjustItem("Radio.WalkieTalkie3", "UseDelta", 0.009 / vars.WalkieTalkieConsumption)
  adjustItem("Radio.WalkieTalkie4", "UseDelta", 0.01 / vars.WalkieTalkieConsumption)
  adjustItem("Radio.WalkieTalkie5", "UseDelta", 0.014 / vars.WalkieTalkieConsumption)
  adjustItem("Radio.WalkieTalkieMakeShift", "UseDelta", 0.007 / vars.WalkieTalkieConsumption)

  ---DEBUG
  if debugMode then
    print("INIT_END_CUSTOMCONSUMTION")
    for key, value in pairs(vars) do
      print(key .. ": " .. value)
    end
  end
end

Events.OnInitGlobalModData.Add(initCustomConsumption)