--[[
  Only store data you need to share across scenes that you aren't persisting in some other manner in here.
  Just add any variables you need to the table....
--]]
local json = require("json")

local Globals = {}
local FoodData = {}
local StandardData = {}
local SuperiorData = {}
local ExcellentData = {}
local FeelingLuckyData = {}

local function setDefaultValues()
  Globals = 
    {
    ["score"]        = 0,
    ["matchups"]     = 0,
    ["email"]        = "anon",
    ["fontname"]        = "SF Digital Readout",    
    ["serverpath"] = "http://deep-ice-5394.heroku.com/",
    ["Something else you care about"]    = 1200,
    ["StandardLabelColors"] = {["r"] = 200, ["g"] = 30, ["b"] = 40, ["a"] = 255},  
    }
end 

local function saveTable(t, filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
        return true
    else
        return false
    end
end
 
local function loadTable(filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local contents = ""
    --local myTable = {}
    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        Globals = json.decode(contents);
        io.close( file )
        --return myTable
    else
      --we need to setup all the defaults
      setDefaultValues()
    end
    --return nil
end	




function loadFoodData()
    local path = system.pathForFile( "data/standard.json")
    --local path = system.pathForFile( "standard.json", system.DocumentsDirectory)
    --local path = "data/standard.json"
    local contents = ""
    --local myTable = {}
    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        StandardData = json.decode(contents);
        io.close( file )
        --return myTable
    end

    local path = system.pathForFile( "data/excellent.json")
    --local path = system.pathForFile( "excellent.json", system.DocumentsDirectory)
    --local path = "data/excellent.json"
    local contents = ""
    --local myTable = {}
    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        ExcellentData = json.decode(contents);
        io.close( file )
        --return myTable
    end    

    local path = system.pathForFile( "data/superior.json")
    --local path = system.pathForFile( "superior.json", system.DocumentsDirectory)
    --local path = "data/superior.json"
    local contents = ""
    --local myTable = {}
    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        SuperiorData = json.decode(contents);
        io.close( file )
        --return myTable
    end

    local path = system.pathForFile( "data/feelinglucky.json")
    --local path = system.pathForFile( "feelinglucky.json", system.DocumentsDirectory)
    --local path = "data/feelinglucky.json"
    local contents = ""
    --local myTable = {}
    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        FeelingLuckyData = json.decode(contents);
        io.close( file )
        --return myTable
    end    

end	

function getStandardFoodData(key,index)
    local val = StandardData[key][index]
    return val
end

function getExcellentFoodData(key,index)
    local val = ExcellentData[key][index]
    return val
end

function getSuperiorFoodData(key,index)
    local val = SuperiorData[key][index]
    return val
end

function getFeelingLuckyFoodData(key,index)
    local val = FeelingLuckyData[key][index]
    return val
end

 
function getGlobal(key)
    local val = Globals[key]
    return val
end
 
function setGlobal(key, val)
    Globals[key] = val
        --anytime we set a value, persist it out to the json file...
    saveTable(Globals, "gamevals.json")
    return
end



function setupGlobals()
  loadTable("gamevals.json")
    --print("Check")
  
  --Correct the Font based on platform
  --For Android we need to reference the font file name
  --For iOS we need to reference the actual font name as recognized by an OS, easiest to tell is to register the font and view it there
  if system.getInfo("platformName") == "Android" then
    Globals["fontname"] = "customfont"
  end
  
end


function CalcDistance(lat, long)
  lat1 = 40.7143528; lon1 = -74.0059731 -- New York, USA
  lat2 = 48.8566667; lon2 = 2.3509871  -- Paris, France
 
  local earthRadius = 6371 -- km
  local dLat = math.rad(lat2-lat1)
  local dLon = math.rad(lon2-lon1)
  local a = math.sin(dLat/2) * math.sin(dLat/2) + math.cos(math.rad(lat1)) * math.cos(math.rad(lat2)) * math.sin(dLon/2) * math.sin(dLon/2); 
  local c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a)); 
  local d = earthRadius * c;
 
print("distance", d)
end

function jsonSearch(tab, query)
        for index,value in ipairs(tab) do
                if (value.id == query) then
                        return value;
                end
        end
end


--[[
CroisenedTest

Client ID
XCNU4LFL30KATE54PRZWWUQENVMQVJVKI1CEUECCMBSGW5A1

Client Secret
W55YJGNN4IMLHXVF4NWKMUKOSHRFAQ3FWAJE3EQETA5Y4H1H

Example:
https://api.foursquare.com/v2/venues/search?ll=40.7,-74&client_id=XCNU4LFL30KATE54PRZWWUQENVMQVJVKI1CEUECCMBSGW5A1&client_secret=W55YJGNN4IMLHXVF4NWKMUKOSHRFAQ3FWAJE3EQETA5Y4H1H&v=20120410

Search example...
https://api.foursquare.com/v2/venues/search?ll=41.257285356202736,-95.9345643858305&client_id=XCNU4LFL30KATE54PRZWWUQENVMQVJVKI1CEUECCMBSGW5A1&client_secret=W55YJGNN4IMLHXVF4NWKMUKOSHRFAQ3FWAJE3EQETA5Y4H1H&v=20120410

Photos example...
https://api.foursquare.com/v2/venues/4ddbbf9f3151b7f8846611e4/photos?group=venue&client_id=XCNU4LFL30KATE54PRZWWUQENVMQVJVKI1CEUECCMBSGW5A1&client_secret=W55YJGNN4IMLHXVF4NWKMUKOSHRFAQ3FWAJE3EQETA5Y4H1H&v=20120410


--]]
