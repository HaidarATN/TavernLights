function onSay(creature, words, param)

	local title = "I'm a moving button"
    local message = "Press me!"

    --local window = ModalWindow(1000, title, message)
    local window = ModalWindow(1000, title, message)
    window:addButton(100, "Confirm")
    window:setDefaultEnterButton(100)

    window:sendToPlayer(creature)
	   
	
	return false
	   
end

	