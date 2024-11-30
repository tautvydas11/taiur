-- GORILLA LEAKS! discord.gg/GdzvtVt | BEST LEAKS SERVER

ESXMenuHandler = function(d,t,st)
  if t == "Entry" then
    if st == "Owner" then
      MenuOpen = true
      --FreezeEntityPosition(GetPlayerPed(-1),true)
      ESXEntryOwnerMenu(d)
      TriggerServerEvent('playerEnteredHouse', 1)
    elseif st == "Owned" then
      MenuOpen = true
      --FreezeEntityPosition(GetPlayerPed(-1),true)
      ESXEntryOwnedMenu(d)
    elseif st == "Empty" then
      MenuOpen = true
      --FreezeEntityPosition(GetPlayerPed(-1),true)
      ESXEntryEmptyMenu(d)
    end
  elseif t == "Garage" then
    if st == "Owner" then
      MenuOpen = true
      --FreezeEntityPosition(GetPlayerPed(-1),true)
      ESXGarageOwnerMenu(d)
    elseif st == "Owned" then
      MenuOpen = true
      --FreezeEntityPosition(GetPlayerPed(-1),true)
      ESXGarageOwnedMenu(d)
    end
  elseif t == "Exit" then
    if st == "Owner" then
      ESXExitOwnerMenu(d)
      TriggerServerEvent('playerLeftHouse')
    elseif st == "Owned" then
      ESXExitOwnedMenu(d)
    elseif st == "Empty" then
      ESXExitEmptyMenu(d)
    end
  elseif t == "Wardrobe" then
    if st == "Owner" or st == "Owned" then
      ESXWardrobeMenu(d)
    end
  elseif t == "InventoryLocation" then
    --OpenInventory(d)
    --TriggerServerEvent("namai:duoduseifa")
    --print("bandau atidaryt inventoriu")
  end
end

-- Function to check if the player is in a house
function IsPlayerInHouse()
  return exports['house_script']:IsPlayerInHouse(PlayerId())
end


ESXWardrobeMenu = function(d)
  print("Atidarau")
  TriggerEvent("fivem-appearance:browseOutfits")
end

ESXOpenInviteMenu = function(d)
  local elements = {}
  local players = GetNearbyPlayers(d.Entry, 10.0)
  
  for _, player in pairs(players) do
    if player ~= PlayerId() then
      table.insert(elements, {
        title = GetPlayerName(player) .. " [ID:" .. GetPlayerServerId(player) .. "]",
        icon = 'user',
        onSelect = function()
          InviteInside(d, GetPlayerServerId(player))
          ShowNotification("Pakvietei " .. GetPlayerName(player) .. " į vidų.")
        end
      })
    end
  end

  -- Register and display the context menu
  lib.registerContext({
    id = 'exit_invite_menu',
    title = Labels['InviteInside'],
    options = elements,
    onExit = function()
      print("Invite menu closed")
    end
  })

  lib.showContext('exit_invite_menu')
end

ESXOpenKeysMenu = function(d)
  local elements = {
    {
      title = Labels['GiveKeys'],
      icon = 'key',
      onSelect = function()
        ESXGiveKeysMenu(d)
      end
    },
    {
      title = Labels['TakeKeys'],
      icon = 'key',
      onSelect = function()
        ESXTakeKeysMenu(d)
      end
    }
  }

  -- Register and display the context menu
  lib.registerContext({
    id = 'exit_keys_menu',
    title = Labels['HouseKeys'],
    options = elements,
    onExit = function()
      print("Exit keys menu closed")
    end
  })

  lib.showContext('exit_keys_menu')
end

ESXGiveKeysMenu = function(d)
  local elements = {}

  -- Get nearby players and populate elements with them
  local players = GetNearbyPlayers(GetEntityCoords(PlayerPedId()), 10.0)
  for _, player in pairs(players) do
    if player ~= PlayerId() then
      table.insert(elements, {
        title = GetPlayerName(player) .. " [ID: " .. player .. "]",
        icon = 'key',
        onSelect = function()
          GiveKeys(d, GetPlayerServerId(player))
        end
      })
    end
  end

  -- Display a notification if no players are available to give keys
  if #elements == 0 then
    ShowNotification(Labels['NoPlayersAvailable'])
    return
  end

  -- Register and display the context menu
  lib.registerContext({
    id = 'exit_givekeys_menu',
    title = Labels['GiveKeys'],
    options = elements,
    onExit = function()
      print("Exit give keys menu closed")
    end
  })

  lib.showContext('exit_givekeys_menu')
end

ESXTakeKeysMenu = function(d)
  local elements = {}

  -- Populate elements with nearby players who have keys to the house
  for _, player in pairs(d.HouseKeys) do
    table.insert(elements, {
      title = player.name,
      icon = 'key',
      onSelect = function()
        TakeKeys(d, player)
      end
    })
  end

  -- Display a notification if no keys are available to take
  if #elements == 0 then
    ShowNotification(Labels['NoKeysAvailable'])
    return
  end

  -- Register and display the context menu
  lib.registerContext({
    id = 'exit_takekeys_menu',
    title = Labels['TakeKeys'],
    options = elements,
    onExit = function()
      print("Exit take keys menu closed")
    end
  })

  lib.showContext('exit_takekeys_menu')
end

ESXExitOwnerMenu = function(d)
  local elements = {}

  -- Check if house inventory is enabled in the configuration
  if Config.UseHouseInventory then
    if Config.AllowHouseSales then
      if d.Shell then
        elements = {
          {
            title = Labels["InviteInside"],
            icon = 'user-friends',
            onSelect = function()
              ESXOpenInviteMenu(d)
            end
          },
          {
            title = Labels["HouseKeys"],
            icon = 'key',
            onSelect = function()
              ESXOpenKeysMenu(d)
            end
          },
          {
            title = Labels["UpgradeShell"],
            icon = 'tools',
            onSelect = function()
              ESXUpgradeMenu(d, true)
            end
          },
          {
            title = Labels["SellHouse"],
            icon = 'home',
            onSelect = function()
              SellHouse(d)
            end
          },
          {
            title = Labels["FurniUI"],
            icon = 'chair',
            onSelect = function()
              OpenFurniture(d)
            end
          },
          {
            title = Labels["SetWardrobe"],
            icon = 'tshirt',
            onSelect = function()
              SetWardrobe(d)
            end
          },
          {
            title = Labels["SetInventory"],
            icon = 'box',
            onSelect = function()
              local zaidejas = cache.playerId
              local ident = GetPlayerIdentifier(zaidejas)
              Inventorius(ident)
            end
          },
          {
            title = (d.Unlocked and Labels["LockDoor"] or Labels["UnlockDoor"]),
            icon = (d.Unlocked and 'lock' or 'unlock'),
            onSelect = function()
              if d.Unlocked then
                LockHouse(d)
              else
                UnlockHouse(d)
              end
            end
          },
          {
            title = Labels["LeaveHouse"],
            icon = 'door-open',
            onSelect = function()
              LeaveHouse(d)
            end
          }
        }
      else -- If the house does not have a shell
        elements = {
          {
            title = Labels["HouseKeys"],
            icon = 'key',
            onSelect = function()
              ESXOpenKeysMenu(d)
            end
          },
          {
            title = Labels["SellHouse"],
            icon = 'home',
            onSelect = function()
              SellHouse(d)
            end
          },
          {
            title = Labels["FurniUI"],
            icon = 'chair',
            onSelect = function()
              OpenFurniture(d)
            end
          },
          {
            title = "Spinta", -- Replace with appropriate label or icon
            icon = 'tshirt',
            onSelect = function()
              SetWardrobe(d)
            end
          },
          {
            title = Labels["SetInventory"],
            icon = 'box',
            onSelect = function()
              local zaidejas = cache.playerId
              local ident = GetPlayerIdentifier(zaidejas)
              Inventorius(ident)
            end
          }
        }
      end

      -- Check if mortgage is owed and add option to manage mortgage
      if d.MortgageOwed and d.MortgageOwed >= 1 then
        table.insert(elements, {
          title = Labels["Mortgage"],
          icon = 'money-bill',
          onSelect = function()
            ESXPayMortgageMenu(d)
          end
        })
      end
    else -- If house sales are not allowed
      if d.Shell then
        elements = {
          {
            title = Labels["InviteInside"],
            icon = 'user-friends',
            onSelect = function()
              ESXOpenInviteMenu(d)
            end
          },
          {
            title = Labels["HouseKeys"],
            icon = 'key',
            onSelect = function()
              ESXOpenKeysMenu(d)
            end
          },
          {
            title = Labels["UpgradeShell"],
            icon = 'tools',
            onSelect = function()
              ESXUpgradeMenu(d, true)
            end
          },
          {
            title = Labels["FurniUI"],
            icon = 'chair',
            onSelect = function()
              OpenFurniture(d)
            end
          },
          {
            title = Labels["SetWardrobe"],
            icon = 'tshirt',
            onSelect = function()
              SetWardrobe(d)
            end
          },
          {
            title = (d.Unlocked and Labels["LockDoor"] or Labels["UnlockDoor"]),
            icon = (d.Unlocked and 'lock' or 'unlock'),
            onSelect = function()
              if d.Unlocked then
                LockHouse(d)
              else
                UnlockHouse(d)
              end
            end
          },
          {
            title = Labels["LeaveHouse"],
            icon = 'door-open',
            onSelect = function()
              LeaveHouse(d)
            end
          }
        }
      else -- If the house does not have a shell
        elements = {
          {
            title = Labels["HouseKeys"],
            icon = 'key',
            onSelect = function()
              ESXOpenKeysMenu(d)
            end
          },
          {
            title = Labels["FurniUI"],
            icon = 'chair',
            onSelect = function()
              OpenFurniture(d)
            end
          },
          {
            title = "Spinta", -- Replace with appropriate label or icon
            icon = 'tshirt',
            onSelect = function()
              SetWardrobe(d)
            end
          },
          {
            title = Labels["SetInventory"],
            icon = 'box',
            onSelect = function()
              local zaidejas = cache.playerId
              local ident = GetPlayerIdentifier(zaidejas)
              Inventorius(ident)
            end
          }
        }
      end

      -- Check if mortgage is owed and add option to manage mortgage
      if d.MortgageOwed and d.MortgageOwed >= 1 then
        table.insert(elements, {
          title = Labels["Mortgage"],
          icon = 'money-bill',
          onSelect = function()
            ESXPayMortgageMenu(d)
          end
        })
      end
    end
  else -- If house inventory is disabled in the configuration
    if Config.AllowHouseSales then
      if d.Shell then
        elements = {
          {
            title = Labels["InviteInside"],
            icon = 'user-friends',
            onSelect = function()
              ESXOpenInviteMenu(d)
            end
          },
          {
            title = Labels["HouseKeys"],
            icon = 'key',
            onSelect = function()
              ESXOpenKeysMenu(d)
            end
          },
          {
            title = Labels["UpgradeShell"],
            icon = 'tools',
            onSelect = function()
              ESXUpgradeMenu(d, true)
            end
          },
          {
            title = Labels["SellHouse"],
            icon = 'home',
            onSelect = function()
              SellHouse(d)
            end
          },
          {
            title = Labels["FurniUI"],
            icon = 'chair',
            onSelect = function()
              OpenFurniture(d)
            end
          },
          {
            title = Labels["Wardrobe"],
            icon = 'tshirt',
            onSelect = function()
              SetWardrobe(d)
            end
          },
          {
            title = (d.Unlocked and Labels["LockDoor"] or Labels["UnlockDoor"]),
            icon = (d.Unlocked and 'lock' or 'unlock'),
            onSelect = function()
              if d.Unlocked then
                LockHouse(d)
              else
                UnlockHouse(d)
              end
            end
          },
          {
            title = Labels["LeaveHouse"],
            icon = 'door-open',
            onSelect = function()
              LeaveHouse(d)
            end
          }
        }
      else -- If the house does not have a shell
        elements = {
          {
            title = Labels["HouseKeys"],
            icon = 'key',
            onSelect = function()
              ESXOpenKeysMenu(d)
            end
          },
          {
            title = Labels["SellHouse"],
            icon = 'home',
            onSelect = function()
              SellHouse(d)
            end
          },
          {
            title = Labels["FurniUI"],
            icon = 'chair',
            onSelect = function()
              OpenFurniture(d)
            end
          },
          {
            title = Labels["SetWardrobe"],
            icon = 'tshirt',
            onSelect = function()
              SetWardrobe(d)
            end
          }
        }
      end

      -- Check if mortgage is owed and add option to manage mortgage
      if d.MortgageOwed and d.MortgageOwed >= 1 then
        table.insert(elements, {
          title = Labels["Mortgage"],
          icon = 'money-bill',
          onSelect = function()
            ESXPayMortgageMenu(d)
          end
        })
      end
    else -- If house sales are not allowed
      if d.Shell then
        elements = {
          {
            title = Labels["InviteInside"],
            icon = 'user-friends',
            onSelect = function()
              ESXOpenInviteMenu(d)
            end
          },
          {
            title = Labels["HouseKeys"],
            icon = 'key',
            onSelect = function()
              ESXOpenKeysMenu(d)
            end
          },
          {
            title = Labels["UpgradeShell"],
            icon = 'tools',
            onSelect = function()
              ESXUpgradeMenu(d, true)
            end
          },
          {
            title = Labels["FurniUI"],
            icon = 'chair',
            onSelect = function()
              OpenFurniture(d)
            end
          },
          {
            title = Labels["Wardrobe"],
            icon = 'tshirt',
            onSelect = function()
              SetWardrobe(d)
            end
          },
          {
            title = (d.Unlocked and Labels["LockDoor"] or Labels["UnlockDoor"]),
            icon = (d.Unlocked and 'lock' or 'unlock'),
            onSelect = function()
              if d.Unlocked then
                LockHouse(d)
              else
                UnlockHouse(d)
              end
            end
          },
          {
            title = Labels["LeaveHouse"],
            icon = 'door-open',
            onSelect = function()
              LeaveHouse(d)
            end
          }
        }
      else -- If the house does not have a shell
        elements = {
          {
            title = Labels["HouseKeys"],
            icon = 'key',
            onSelect = function()
              ESXOpenKeysMenu(d)
            end
          },
          {
            title = Labels["FurniUI"],
            icon = 'chair',
            onSelect = function()
              OpenFurniture(d)
            end
          },
          {
            title = Labels["SetWardrobe"],
            icon = 'tshirt',
            onSelect = function()
              SetWardrobe(d)
            end
          }
        }
      end

      -- Check if mortgage is owed and add option to manage mortgage
      if d.MortgageOwed and d.MortgageOwed >= 1 then
        table.insert(elements, {
          title = Labels["Mortgage"],
          icon = 'money-bill',
          onSelect = function()
            ESXPayMortgageMenu(d)
          end
        })
      end
    end
  end

  -- Display notification if no elements to show
  if #elements == 0 then
    ShowNotification(Labels['NothingToDisplay'])
    return
  end

  -- Register and display the context menu
  lib.registerContext({
    id = 'exit_owner_menu',
    title = Labels['MyHouse'],
    options = elements,
    onExit = function()
      print("Exit owner menu closed")
    end
  })

  lib.showContext('exit_owner_menu')
end

Inventorius = function(ident)
    local idtendf = ident
    local stash = {
        id = 'Namai:' .. ident,
        label = 'Namai',
        slots = 1000,
        weight = 10000000,
        owner = ident
    }

    local idosik = stash.id
    local labelosik = stash.label
    local slotsik = stash.slots
    local weig = stash.weight
    local own = stash.owner
    TriggerServerEvent('erp:loadStashes', idosik, labelosik, slotsik, weig, own)

    exports.ox_inventory:openInventory('stash', {id=stash.id, owner=stash.owner})
end



ESXExitOwnedMenu = function(d)
  local elements = {}
  local identifier = GetPlayerIdentifier()
  local mort = false

  -- Check if the player has keys to the house
  for k, v in pairs(d.HouseKeys) do
    if v.identifier == identifier then
      if d.Shell then
        table.insert(elements, {
          title = Labels['InviteInside'],
          icon = 'user-friends',
          onSelect = function()
            ESXOpenInviteMenu(d)
          end
        })
      end
      
      table.insert(elements, {
        title = Labels['FurniUI'],
        icon = 'chair',
        onSelect = function()
          OpenFurniture(d)
        end
      })

      table.insert(elements, {
        title = Labels['Mortgage'],
        icon = 'money-bill',
        onSelect = function()
          ESXPayMortgageMenu(d)
        end
      })

      mort = true
      break
    end
  end

  -- Add leave option if the house has a shell
  if d.Shell then
    table.insert(elements, {
      title = Labels['LeaveHouse'],
      icon = 'door-open',
      onSelect = function()
        TriggerServerEvent("Namai:removeSeifas")
        LeaveHouse(d)
      end
    })
  end

  -- Check if mortgage information is available and allow checking if qualified
  if d.MortgageOwed and d.MortgageOwed > 0 then
    local job = GetPlayerJobName()
    if Config.CreationJobs[job] and GetPlayerJobRank() >= Config.CreationJobs[job].minRank then
      table.insert(elements, {
        title = Labels['Mortgage'],
        icon = 'money-bill',
        onSelect = function()
          ESXMortgageInfoMenu(d)
        end
      })
    end
  end

  -- Display notification if no elements to show
  if #elements == 0 then
    ShowNotification(Labels['NothingToDisplay'])
    return
  end

  -- Register and display the context menu
  lib.registerContext({
    id = 'exit_owned_menu',
    title = Labels['PlayerHouse'],
    options = elements,
    onExit = function()
      print("Exit owned menu closed")
    end
  })

  lib.showContext('exit_owned_menu')
end

ESXExitEmptyMenu = function(d)
  local elements = {}

  if d.Shell then
    table.insert(elements, {
      title = Labels['LeaveHouse'],
      icon = 'door-open',
      onSelect = function()
        LeaveHouse(d)
      end
    })

    if d.Owned then
      local certifiedPolice = false
      local job = GetPlayerJobName()
      
      if Config.PoliceJobs[job] and GetPlayerJobRank() >= Config.PoliceJobs[job].minRank then
        certifiedPolice = true
      end

      if Config.PoliceCanRaid and certifiedPolice then
        if d.Unlocked then
          table.insert(elements, {
            title = Labels['LockHouse'],
            icon = 'lock',
            onSelect = function()
              LockHouse(d)
            end
          })
        else
          table.insert(elements, {
            title = Labels['UnlockHouse'],
            icon = 'unlock',
            onSelect = function()
              UnlockHouse(d)
            end
          })
        end
      end
    end
  end

  if #elements == 0 then
    ShowNotification(Labels['NothingToDisplay'])
    return
  end

  lib.registerContext({
    id = 'exit_empty_menu',
    title = Labels['EmptyHouse'],
    options = elements,
    onExit = function()
      print("Exit empty menu closed")
    end
  })

  lib.showContext('exit_empty_menu')
end

ESXUpgradeMenu = function(d, owner)
  local elements = {}
  local c = 0
  local dataTable = {}
  local sortedTable = {}

  for k, v in pairs(d.Shells) do
    local price = ShellPrices[k]
    if price then
      dataTable[price .. "_" .. k] = {
        available = v,
        price = price,
        shell = k,
      }
      table.insert(sortedTable, price .. "_" .. k)
    end
  end
  table.sort(sortedTable)

  for _, price in ipairs(sortedTable) do
    local data = dataTable[price]
    if data.available and d.Shell ~= data.shell then
      table.insert(elements, {
        title = data.shell .. " [€" .. data.price .. "]",
        icon = 'home',
        onSelect = function()
          UpgradeHouse(d, data)
        end
      })
      c = c + 1
    end
  end

  if c == 0 then
    ShowNotification(Labels['NoUpgrades'])
    return
  end

  lib.registerContext({
    id = 'owner_upgrade_menu',
    title = Labels['UpgradeHouse2'],
    options = elements,
    onExit = function()
      print("Upgrade menu closed")
    end
  })

  lib.showContext('owner_upgrade_menu')
end

DoOpenESXGarage = function(d)
  local vehicles = GetVehiclesAtHouse(d)
  local elements = {}

  if #vehicles > 0 then
    for _, vehData in pairs(vehicles) do
      table.insert(elements, {
        title = "[" .. vehData.vehicle.plate .. "] " .. GetVehicleLabel(vehData.vehicle.model),
        icon = 'car',
        onSelect = function()
          TriggerServerEvent('Allhousing:VehicleSpawned', vehData.vehicle.plate)
          SpawnVehicle(d.Garage, vehData.vehicle.model, vehData.vehicle)
        end
      })
    end
  else
    table.insert(elements, {
      title = Labels['NoVehicles'],
      icon = 'info-circle'
    })
  end

  lib.registerContext({
    id = 'entry_owner_menu',
    title = "Player Garage",
    options = elements,
    onExit = function()
      print("Garage menu closed")
      MenuOpen = false
      ----FreezeEntityPosition(GetPlayerPed(-1), false)
    end
  })

  lib.showContext('entry_owner_menu')
end

ESXGarageOwnerMenu = function(d)
  local ped = GetPlayerPed(-1)
  
  if IsPedInAnyVehicle(ped, false) then
    local veh = GetVehiclePedIsUsing(ped)
    local props = GetVehicleProperties(veh)
    local ownerInfo = Callback("Allhousing:GetVehicleOwner", props.plate)
    local canStore = false
    
    if ownerInfo.owned and ownerInfo.owner then
      canStore = true
    elseif ownerInfo.owned and Config.StoreStolenPlayerVehicles then
      canStore = true
    end
    
    if canStore then
      TaskEveryoneLeaveVehicle(veh)
      SetEntityAsMissionEntity(veh, true, true)
      DeleteVehicle(veh)  
      TriggerServerEvent("Allhousing:VehicleStored", d.Id, props.plate, props)
      ShowNotification(Labels["VehicleStored"])
    else
      ShowNotification(Labels["CantStoreVehicle"])
    end
    
    --FreezeEntityPosition(GetPlayerPed(-1), false)
  else
    local vehicles = GetVehiclesAtHouse(d)
    local elements = {}
    
    if #vehicles > 0 then
      for _, vehData in pairs(vehicles) do
        table.insert(elements, {
          title = "[" .. vehData.vehicle.plate .. "] " .. GetVehicleLabel(vehData.vehicle.model),
          icon = 'car',
          onSelect = function()
            TriggerServerEvent('Allhousing:VehicleSpawned', vehData.vehicle.plate)
            SpawnVehicle(d.Garage, vehData.vehicle.model, vehData.vehicle)
          end
        })
      end
    else
      table.insert(elements, {
        title = Labels['NoVehicles'],
        icon = 'info-circle'
      })
    end
    
    lib.registerContext({
      id = 'own_gara',
      title = Labels['Garage'],
      options = elements,
      onExit = function()
        print("Garage menu closed")
        MenuOpen = false
        --FreezeEntityPosition(GetPlayerPed(-1), false)
      end
    })
    
    lib.showContext('own_gara')
  end
end

ESXGarageOwnedMenu = function(d)
  local plyPed = GetPlayerPed(-1)  
  if IsPedInAnyVehicle(plyPed,false) then
    local veh = GetVehiclePedIsUsing(plyPed)
    local props = GetVehicleProperties(veh)
    local ownerInfo = Callback("Allhousing:GetVehicleOwner",props.plate)
    local canStore = false
    if ownerInfo.owned and ownerInfo.owner then
      canStore = true
    elseif ownerInfo.owned and Config.StoreStolenPlayerVehicles then
      canStore = true
    else
      canStore = false
    end

    if canStore then
      TaskEveryoneLeaveVehicle(veh)
      SetEntityAsMissionEntity(veh,true,true)
      DeleteVehicle(veh)  
      TriggerServerEvent("Allhousing:VehicleStored",d.Id,props.plate,props)
      ShowNotification(Labels["VehicleStored"])
    else
      ShowNotification(Labels["CantStoreVehicle"])
    end
    --FreezeEntityPosition(GetPlayerPed(-1),false)
  else
    local myId = GetPlayerIdentifier()
    for k,v in pairs(d.HouseKeys) do
      if v.identifier == myId then
        DoOpenESXGarage(d)
        return
      end
    end

    if not Config.GarageTheft then 
      --FreezeEntityPosition(GetPlayerPed(-1),false)
      return
    end

    if Config.LockpickRequired then
      local hasItem = CheckForLockpick()
      if not hasItem then
        ShowNotification(Labels['NoLockpick'])
        --FreezeEntityPosition(GetPlayerPed(-1),false)
        return
      end
    end

    while not HasAnimDictLoaded("mini@safe_cracking") do RequestAnimDict("mini@safe_cracking"); Citizen.Wait(0); end
    TaskPlayAnim(plyPed, "mini@safe_cracking", "idle_base", 1.0, 1.0, -1, 1, 0, 0, 0, 0 ) 
    Wait(2000)

    -- GORILLA LEAKS! discord.gg/GdzvtVt | BEST LEAKS SERVER

    if Config.UsingLockpickV1 then
      TriggerEvent("lockpicking:StartMinigame",4,function(didWin)
        if didWin then
          ClearPedTasksImmediately(plyPed)
          DoOpenESXGarage(d)
        else
          ClearPedTasksImmediately(plyPed)
          TriggerServerEvent("Allhousing:BreakLockpick")
        end
        --FreezeEntityPosition(GetPlayerPed(-1),false)
      end)
    elseif Config.UsingLockpickV2 then
      exports["lockpick"]:Lockpick(function(didWin)
        if didWin then
          ClearPedTasksImmediately(plyPed)
          DoOpenESXGarage(d)
          ShowNotification(Labels["LockpickSuccess"])
        else
          ClearPedTasksImmediately(plyPed)
          TriggerServerEvent("Allhousing:BreakLockpick")
          ShowNotification(Labels["LockpickFailed"])
        end
        --FreezeEntityPosition(GetPlayerPed(-1),false)
      end)
    else
      if Config.UsingProgressBars then
        lib.progressCircle({
          duration = 5000,
          position = 'bottom',
          useWhileDead = false,
          canCancel = true,
          disable = {
              car = true,
              move = true,
          },
      })
      end
      --Wait(Config.LockpickTime * 1000)
      if math.random(100) < Config.LockpickFailChance then
        local plyPos = GetEntityCoords(GetPlayerPed(-1))
        local zoneName = GetNameOfZone(plyPos.x,plyPos.y,plyPos.z)
        if Config.LockpickBreakOnFail then
          TriggerServerEvent("Allhousing:BreakLockpick")
        end
        ShowNotification(Labels["LockpickFailed"])
        for k,v in pairs(Config.PoliceJobs) do
          TriggerServerEvent("Allhousing:NotifyJobs",k,"Someone is attempting to break into a garage at "..zoneName)
        end
        ClearPedTasksImmediately(plyPed)
      else
        ShowNotification(Labels["LockpickSuccess"])
        ClearPedTasksImmediately(plyPed)
        DoOpenESXGarage(d)
      end
      --FreezeEntityPosition(GetPlayerPed(-1),false)
    end
  end
end

ESXEntryOwnerMenu = function(d)
  local elements

  if Config.AllowHouseSales then
    if d.Garage and Config.AllowGarageMovement then
      if d.Shell then
        elements = {
          {
            title = Labels['EnterHouse'],
            icon = 'door-open',
            onSelect = function()
              EnterHouse(d)
            end
          },
          {
            title = Labels['UpgradeHouse2'],
            icon = 'arrow-up',
            onSelect = function()
              ESXUpgradeMenu(d, true)
            end
          },
          {
            title = (d.Unlocked and Labels['LockDoor'] or Labels['UnlockDoor']),
            icon = (d.Unlocked and 'lock' or 'unlock'),
            onSelect = function()
              if d.Unlocked then
                LockHouse(d)
              else
                UnlockHouse(d)
              end
            end
          },
          {
            title = Labels['MoveGarage'],
            icon = 'car',
            onSelect = function()
              MoveGarage(d)
            end
          },
          {
            title = Labels['SellHouse'],
            icon = 'dollar-sign',
            onSelect = function()
              SellHouse(d)
            end
          }
        }
      else
        elements = {
          {
            title = Labels['MoveGarage'],
            icon = 'car',
            onSelect = function()
              MoveGarage(d)
            end
          },
          {
            title = Labels['SellHouse'],
            icon = 'dollar-sign',
            onSelect = function()
              SellHouse(d)
            end
          }
        }
      end
    else
      if d.Shell then
        elements = {
          {
            title = Labels['EnterHouse'],
            icon = 'door-open',
            onSelect = function()
              EnterHouse(d)
            end
          },
          {
            title = Labels['UpgradeHouse2'],
            icon = 'arrow-up',
            onSelect = function()
              ESXUpgradeMenu(d, true)
            end
          },
          {
            title = (d.Unlocked and Labels['LockDoor'] or Labels['UnlockDoor']),
            icon = (d.Unlocked and 'lock' or 'unlock'),
            onSelect = function()
              if d.Unlocked then
                LockHouse(d)
              else
                UnlockHouse(d)
              end
            end
          },
          {
            title = Labels['SellHouse'],
            icon = 'dollar-sign',
            onSelect = function()
              SellHouse(d)
            end
          }
        }
      else
        elements = {
          {
            title = Labels["SellHouse"],
            icon = 'dollar-sign',
            onSelect = function()
              SellHouse(d)
            end
          }
        }
      end
    end
  else
    if d.Garage and Config.AllowGarageMovement then
      if d.Shell then
        elements = {
          {
            title = Labels['EnterHouse'],
            icon = 'door-open',
            onSelect = function()
              EnterHouse(d)
            end
          },
          {
            title = Labels['UpgradeHouse2'],
            icon = 'arrow-up',
            onSelect = function()
              ESXUpgradeMenu(d, true)
            end
          },
          {
            title = (d.Unlocked and Labels['LockDoor'] or Labels['UnlockDoor']),
            icon = (d.Unlocked and 'lock' or 'unlock'),
            onSelect = function()
              if d.Unlocked then
                LockHouse(d)
              else
                UnlockHouse(d)
              end
            end
          },
          {
            title = Labels['MoveGarage'],
            icon = 'car',
            onSelect = function()
              MoveGarage(d)
            end
          }
        }
      else
      end
    else
      if d.Shell then
        elements = {
          {
            title = Labels['EnterHouse'],
            icon = 'door-open',
            onSelect = function()
              EnterHouse(d)
            end
          },
          {
            title = Labels['UpgradeHouse2'],
            icon = 'arrow-up',
            onSelect = function()
              ESXUpgradeMenu(d, true)
            end
          },
          {
            title = (d.Unlocked and Labels['LockDoor'] or Labels['UnlockDoor']),
            icon = (d.Unlocked and 'lock' or 'unlock'),
            onSelect = function()
              if d.Unlocked then
                LockHouse(d)
              else
                UnlockHouse(d)
              end
            end
          }
        }
      else
        elements = {
          {
            title = Labels["NothingToDisplay"],
            icon = 'info-circle'
          }
        }
      end
    end
  end

  lib.registerContext({
    id = 'entry_own',
    title = Labels['MyHouse'],
    options = elements,
    onExit = function()
      print("Owner menu closed")
      MenuOpen = false
      --FreezeEntityPosition(GetPlayerPed(-1), false)
    end
  })

  lib.showContext('entry_own')
end

ESXConfirmSaleMenu = function(d, floored)
  local elements = {
    {
      title = Labels['ConfirmSale'],
      icon = 'check',
      onSelect = function()
        ShowNotification(string.format(Labels["SellingHouse"], floored))
        d.Owner = ""
        d.Owned = false

        if InsideHouse then 
          LeaveHouse(d)
        end
        
        TriggerServerEvent("Allhousing:SellHouse", d, floored)
        lib.closeContext('esx_verify_sell')
      end
    },
    {
      title = Labels['CancelSale'],
      icon = 'times',
      onSelect = function()
        lib.closeContext('esx_verify_sell')
      end
    }
  }

  lib.registerContext({
    id = 'esx_verify_sell',
    title = string.format(Labels["SellingHouse"], floored),
    options = elements,
    onExit = function()
      print("Sale confirmation menu closed")
    end
  })

  lib.showContext('esx_verify_sell')
end

ESXEntryOwnedMenu = function(d)
  local hasKeys = false
  local identifier = GetPlayerIdentifier()
  for k, v in pairs(d.HouseKeys) do
    if v.identifier == identifier then
      hasKeys = true
      break
    end
  end

  local certifiedPolice = false
  local job = GetPlayerJobName()
  if Config.PoliceJobs[job] then
    if GetPlayerJobRank() >= Config.PoliceJobs[job].minRank then
      certifiedPolice = true
    end
  end

  local certifiedRealestate = false
  if Config.CreationJobs[job] then
    if GetPlayerJobRank() >= Config.CreationJobs[job].minRank then
      certifiedRealestate = true
    end
  end

  local elements = {}

  if d.Shell then
    if hasKeys or d.Unlocked then
      table.insert(elements, {
        title = Labels['EnterHouse'],
        icon = 'home',
        onSelect = function()
          EnterHouse(d, (not hasKeys and true or false))
        end
      })
    elseif certifiedPolice then
      table.insert(elements, {
        title = Labels['KnockHouse'],
        icon = 'bell',
        onSelect = function()
          KnockOnDoor(d)
        end
      })
      if Config.PoliceCanRaid then
        table.insert(elements, {
          title = Labels['RaidHouse'],
          icon = 'shield-alt',
          onSelect = function()
            RaidHouse(d)
          end
        })
      end
    else
      table.insert(elements, {
        title = Labels['KnockHouse'],
        icon = 'bell',
        onSelect = function()
          KnockOnDoor(d)
        end
      })
      if Config.HouseTheft then
        table.insert(elements, {
          title = Labels['BreakIn'],
          icon = 'crowbar',
          onSelect = function()
            BreakInHouse(d)
          end
        })
      end
    end
  end

  if certifiedRealestate and d.MortgageOwed and d.MortgageOwed > 0 then
    table.insert(elements, {
      title = Labels['Mortgage'],
      icon = 'dollar-sign',
      onSelect = function()
        ESXMortgageInfoMenu(d)
      end
    })
  end

  if #elements <= 0 then
    --FreezeEntityPosition(GetPlayerPed(-1), false)
    return
  end

  lib.registerContext({
    id = 'wner_menu',
    title = Labels['PlayerHouse'],
    options = elements,
    onExit = function()
      print("Owner menu closed")
      MenuOpen = false
      --FreezeEntityPosition(GetPlayerPed(-1), false)
    end
  })

  lib.showContext('wner_menu')
end

ESXMortgageInfoMenu = function(d)
  local mortgage_info = Callback("Allhousing:GetMortgageInfo", d)
  local elements = {
    {
      title = string.format(Labels["MoneyOwed"], tostring(mortgage_info.MortgageOwed)),
      icon = 'dollar-sign'
    },
    {
      title = string.format(Labels['LastRepayment'], tostring(mortgage_info.LastRepayment)),
      icon = 'calendar'
    },
    {
      title = "Revoke Tenancy",
      icon = 'ban',
      onSelect = function()
        RevokeTenancy(d)
      end
    }
  }

  lib.registerContext({
    id = 'mortgage_info_menu',
    title = Labels['MortgageInfo'],
    options = elements,
    onExit = function()
      print("Mortgage info menu closed")
    end
  })

  lib.showContext('mortgage_info_menu')
end

ESXPayMortgageMenu = function(d)
  local mortgage_info = Callback("Allhousing:GetMortgageInfo", d)
  local elements = {
    {
      title = string.format(Labels["MoneyOwed"], tostring(mortgage_info.MortgageOwed)),
      icon = 'dollar-sign'
    },
    {
      title = string.format(Labels['LastRepayment'], tostring(mortgage_info.LastRepayment)),
      icon = 'calendar'
    },
    {
      title = Labels['PayMortgage'],
      icon = 'credit-card',
      onSelect = function()
        RepayMortgage(d)
      end
    }
  }

  lib.registerContext({
    id = 'mortgage_menu',
    title = Labels['MortgageInfo'],
    options = elements,
    onExit = function()
      print("Mortgage menu closed")
    end
  })

  lib.showContext('mortgage_menu')
end

ESXEntryEmptyMenu = function(d)
  local elements = {}
  if d.ResaleJob and d.ResaleJob:len() > 0 and Config.AllowMortgage then
    if d.Shell then
      elements = {
        {
          title = Labels['Buy'] .. " [€" .. d.Price .. "]",
          icon = 'circle',
          onSelect = function()
            BuyHouse(d)
          end
        },
        {
          title = Labels['Mortgage'] .. " [€" .. math.floor((d.Price / 100) * Config.MortgagePercent) .. "]",
          icon = 'circle',
          onSelect = function()
            MortgageHouse(d)
          end
        },
        {
          title = Labels['View'],
          icon = 'circle',
          onSelect = function()
            ViewHouse(d)
          end
        },
        {
          title = Labels['Upgrades'],
          icon = 'circle',
          onSelect = function()
            ESXUpgradeMenu(d, false)
          end
        }
      }
    else
      elements = {
        {
          title = Labels['Buy'] .. " [€" .. d.Price .. "]",
          icon = 'circle',
          onSelect = function()
            BuyHouse(d)
          end
        },
        {
          title = Labels['Mortgage'] .. " [€" .. math.floor((d.Price / 100) * Config.MortgagePercent) .. "]",
          icon = 'circle',
          onSelect = function()
            MortgageHouse(d)
          end
        }
      }
    end
  else
    if d.Shell then
      elements = {
        {
          title = Labels['Buy'] .. " [€" .. d.Price .. "]",
          icon = 'circle',
          onSelect = function()
            BuyHouse(d)
          end
        },
        {
          title = Labels['View'],
          icon = 'circle',
          onSelect = function()
            ViewHouse(d)
          end
        },
        {
          title = Labels['Upgrades'],
          icon = 'circle',
          onSelect = function()
            ESXUpgradeMenu(d, false)
          end
        }
      }
    else
      elements = {
        {
          title = Labels['Buy'] .. " [€" .. d.Price .. "]",
          icon = 'circle',
          onSelect = function()
            BuyHouse(d)
          end
        }
      }
    end
  end

  lib.registerContext({
    id = 'entry_empty_menu',
    title = Labels['EmptyHouse'],
    options = elements,
    onExit = function()
      print("Unfreeze?")
      MenuOpen = false
      --FreezeEntityPosition(GetPlayerPed(-1), false)
    end
  })

  lib.showContext('entry_empty_menu')
end

-- GORILLA LEAKS! discord.gg/GdzvtVt | BEST LEAKS SERVER