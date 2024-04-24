--Original code
function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    local guildName = result.getString("name")
    print(guildName)
end

-- First, I will add checker to make sure that the resultId is exist. And second, I notice that in line 6
-- it use "result" instead of resultId. And third, there is possibilities that we will have more than 1 guild in return
-- of resultId, so I will do a loop to print guild that are selected. As well as adding error handler in case that the database
-- is failed (no return or maybe no database exist)

--My code
function printSmallGuildNames(memberCount)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < ?;"
    local resultId = db.storeQuery(selectGuildQuery, memberCount)
    
    -- Check if resultId return correctly
    if resultId ~= nil then
        -- Iterate over the results using a for loop
        for row in resultId do
            local guildName = row.name
            print(guildName)
        end
        
    else
        -- Handle query execution failure
        print("Error executing SQL query")
    end
end
    