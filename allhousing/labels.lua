local labels = {
  ['en'] = {
    ['Entry']               = "Įėjimas",
    ['Exit']                = "Išėjimas",
    ['Garage']              = "Garažas",
    ['Wardrobe']            = "Spinta",
    ['Inventory']           = "Seifas",
    ['InventoryLocation']   = "Seifas",
    
    ['LeavingHouse']        = "Išeiti iš namo",
    
    ['AccessHouseMenu']     = "Namas",
    
    ['InteractDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']    = "~INPUT_PICKUP~ ",
    
    ['AcceptDrawText']      = "["..Config.TextColors[Config.MarkerSelection].."G~s~] ",
    ['AcceptHelpText']      = "~INPUT_DETONATE~ ",
    
    ['FurniDrawText']       = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']      = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    
    ['VehicleStored']       = "Tr. priemone įvaryta",
    ['CantStoreVehicle']    = "Si tr. priemone negali buti įvaryta",
    
    ['HouseNotOwned']       = "Tai nera tavo namas",
    ['InvitedInside']       = "Priimti svečius",
    ['MovedTooFar']         = "Nuejai nuo durų",
    ['KnockAtDoor']         = "Kažkas beldžiasi",
    
    ['TrackMessage']        = "Track message",
    
    ['Unlocked']            = "Namas atrakintas",
    ['Locked']              = "Namas uzrakintas",
    
    ['WardrobeSet']         = "Spinta pastatyta",
    ['InventorySet']        = "Seifas pastatytas",
    
    ['ToggleFurni']         = "Dekoruoti namus",
    
    ['GivingKeys']          = "Duoti raktus",
    ['TakingKeys']          = "Atimti raktus",
    
    ['GarageSet']           = "Garazo vieta nustatyta",
    ['GarageTooFar']        = "Garazas negali buti taip toli",
    
    ['PurchasedHouse']      = "Nusipirkai nama uz €%d",
    ['CantAffordHouse']     = "Neisiperki sio namo",
    
    ['MortgagedHouse']      = "Jus uzstatete nama uz €%d",
    
    ['NoLockpick']          = "Neturi lockpicko",
    ['LockpickFailed']      = "Tau nepavyko",
    ['LockpickSuccess']     = "Tau pavyko",
    
    ['NotifyRobbery']       = "Namo apiplesimas %s",
    
    ['ProgressLockpicking'] = "Isilauziama...",
    
    ['InvalidShell']        = "Invalid house shell: %s, please report to your server owner.",
    ['ShellNotLoaded']      = "Shell would not load: %s, please report to your server owner.",
    ['BrokenOffset']        = "Offset is messed up for house with ID %s, please report to your server owner.",
    
    ['UpgradeHouse']        = "Renovuoti namą į: %s",
    ['CantAffordUpgrade']   = "Neturi pakankamai pinigu",
    
    ['SetSalePrice']        = "Pardavimo kaina",
    ['InvalidAmount']       = "Negalima suma",
    ['InvalidSale']         = "Negalite parduoti namo, uz kuri vis dar esate skolingi",
    ['InvalidMoney']        = "Neturi tiek pinigu",
    
    ['EvictingTenants']     = "Nuomininku iskeldinimas",
    
    ['NoOutfits']           = "Neturi rubu",
    
    ['EnterHouse']          = "Įeiti į namą",
    ['KnockHouse']          = "Pasibelsti",
    ['RaidHouse']           = "Reiduoti namą",
    ['BreakIn']             = "Įsilaužti",
    ['InviteInside']        = "Pakviesti svečius",
    ['HouseKeys']           = "Namo raktai",
    ['UpgradeHouse2']       = "Renovuoti namą",
    ['UpgradeShell']        = "Renovuoti namą",
    ['SellHouse']           = "Parduoti namą",
    ['FurniUI']             = "Dekoruoti namą",
    ['SetWardrobe']         = "Nustatyti spintą",
    ['SetInventory']        = "Inventorius",
    ['SetGarage']           = "Nustatyti garažą",
    ['LockDoor']            = "Užrakinti namą",
    ['UnlockDoor']          = "Atrakinti namą",
    ['LeaveHouse']          = "Išeiti iš namo",
    ['Mortgage']            = "Užstatyti",
    ['Buy']                 = "Pirkti",
    ['View']                = "Apžiūrėti",
    ['Upgrades']            = "Galimos renovacijos",
    ['MoveGarage']          = "Pakeisti garaž vietą",
    
    ['GiveKeys']            = "Duoti raktus",
    ['TakeKeys']            = "Atimti raktus",
    
    ['MyHouse']             = "<font face=\'Roboto\'>Mano namas",
    ['PlayerHouse']         = "Player House",
    ['EmptyHouse']          = "<font face=\'Roboto\'>Laisvas namas",
    
    ['NoUpgrades']          = "Šio namo renovuoti negalima",
    ['NoVehicles']          = "Neturite mašinų",
    ['NothingToDisplay']    = "Čia nieko nėra",
    
    ['ConfirmSale']         = "Taip parduoti namą",
    ['CancelSale']          = "Ne, noriu pasilikti namą",
    ['SellingHouse']        = "Parduoti namą (€%d)",
    
    ['MoneyOwed']           = "Skolingi: €%s",
    ['LastRepayment']       = "Paskutinis susimokėjimas: %s",
    ['PayMortgage']         = "Mokėti užstatą",
    ['MortgageInfo']        = "Užstato informacija",
    
    ['SetEntry']            = "Įėjimas bus:",
    ['CancelGarage']        = "Garažo nereikia",
    ['UseInterior']         = "Šito mes nenaudojam",
    ['UseShell']            = "Dizainas",
    ['InteriorType']        = "Šito mes nenaudojam",
    ['SetInterior']         = "Dabartinis dizainas",
    ['SelectDefaultShell']  = "Default dizainas",
    ['ToggleShells']        = "Dizainu pagerinimai",
    ['AvailableShells']     = "Galimi dizainai",
    ['Enabled']             = "Įjungta",
    ['Disabled']            = "Išjungta",
    ['NewDoor']             = "Add New Door",
    ['Done']                = "Done",
    ['Doors']               = "Doors",
    ['Interior']            = "Sito mes nenaudojam",
    
    ['CreationComplete']    = "Namas buvo sukurtas.",
    
    ['HousePurchased']      = "Nusipirkai namą už €%d",
    ['HouseEarning']        = ", tu gavai €%d, nes pardavei nama."
  }
}

Labels = labels[Config.Locale]