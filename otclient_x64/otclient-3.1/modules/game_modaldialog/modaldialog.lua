modalDialog = focusNextChild
myLoopEventId = 0

function init()
    g_ui.importStyle('modaldialog')

    connect(g_game, {
        onModalDialog = onModalDialog,
        onGameEnd = destroyDialog
    })

    local dialog = rootWidget:recursiveGetChildById('modalDialog')
    if dialog then
        modalDialog = dialog
    end
end

function terminate()
    disconnect(g_game, {
        onModalDialog = onModalDialog,
        onGameEnd = destroyDialog
    })
end

function destroyDialog()
    if modalDialog then
        modalDialog:destroy()
        modalDialog = nil
    end
end

function moveButton(button)
    -- if(button:getMarginLeft() > 1000)
    --     return
    -- end
    local randomMargin = math.random(100,200)

    if button:getMarginLeft() + randomMargin < 900 then
        button:setMarginLeft(button:getMarginLeft() + randomMargin)
    else
        button:setMarginLeft(0)
    end
    

    --myLoopEventId = scheduleEvent(moveButton, 200, button)
    
end

function onModalDialog(id, title, message, buttons, enterButton, escapeButton, choices, priority)
    -- priority parameter is unused, not sure what its use is.
    if modalDialog then
        return
    end

    modalDialog = g_ui.createWidget('ModalDialog', rootWidget)

    local messageLabel = modalDialog:getChildById('messageLabel')
    local choiceList = modalDialog:getChildById('choiceList')
    local choiceScrollbar = modalDialog:getChildById('choiceScrollBar')
    local buttonsPanel = modalDialog:getChildById('buttonsPanel')

    modalDialog:setText(title)
    messageLabel:setText(message)

    --choices
    local labelHeight
    for i = 1, #choices do
        local choiceId = choices[i][1]
        local choiceName = choices[i][2]

        local label = g_ui.createWidget('ChoiceListLabel', choiceList)
        label.choiceId = choiceId
        label:setText(choiceName)
        label:setPhantom(false)
        if not labelHeight then
            labelHeight = label:getHeight()
        end
    end
    choiceList:focusChild(choiceList:getFirstChild())

    g_keyboard.bindKeyPress('Down', function()
        choiceList:focusNextChild(KeyboardFocusReason)
    end, modalDialog)
    g_keyboard.bindKeyPress('Up', function()
        choiceList:focusPreviousChild(KeyboardFocusReason)
    end, modalDialog)

    --Buttons
    local buttonsWidth = 0
    for i = 1, #buttons do
        local buttonId = buttons[i][1]
        local buttonText = buttons[i][2]

        local button = g_ui.createWidget('ModalButton', buttonsPanel)
        --button = g_ui.createWidget('ModalButton', buttonsPanel)
        button:setText(buttonText)
        --set button size
        --button:setWidth(100)
        --

        -- addEvent(function()
        --     moveButton(button)
        --     end
        -- ,3000)
        
        --print("hehe")
        --moveButton(button)
        
        button.onClick = function(self)
            -- local focusedChoice = choiceList:getFocusedChild()
            -- local choice = 0xFF
            -- if focusedChoice then
            --     choice = focusedChoice.choiceId
            -- end
            -- g_game.answerModalDialog(id, buttonId, choice)
            -- destroyDialog()
            -- local random = math.random(-50, 50)
            -- button:setMarginLeft(button:getMarginLeft() + random)
            -- button:setMarginTop(button:getMarginTop() + random)
            moveButton(button)
            addEvent(function(self)
                moveButton(button)
                end
            ,3000)
        end
        buttonsWidth = buttonsWidth + button:getWidth() + button:getMarginLeft() + button:getMarginRight()
    end

    

    local additionalHeight = 0
    if #choices > 0 then
        choiceList:setVisible(true)
        choiceScrollbar:setVisible(true)

        additionalHeight = math.min(modalDialog.maximumChoices, math.max(modalDialog.minimumChoices, #choices)) *
                               labelHeight
        additionalHeight = additionalHeight + choiceList:getPaddingTop() + choiceList:getPaddingBottom()
    end

    local horizontalPadding = modalDialog:getPaddingLeft() + modalDialog:getPaddingRight()
    buttonsWidth = buttonsWidth + horizontalPadding

    --Set window width
    modalDialog:setWidth(math.min(modalDialog.maximumWidth,
                                   math.max(buttonsWidth, messageLabel:getWidth(), modalDialog.minimumWidth)))
    --modalDialog:setWidth(1000)
    messageLabel:setWidth(math.min(modalDialog.maximumWidth,
                                   math.max(buttonsWidth, messageLabel:getWidth(), modalDialog.minimumWidth)) -
                              horizontalPadding)
    --Set window height?                          
    --modalDialog:setHeight(modalDialog:getHeight() + additionalHeight + messageLabel:getHeight() - 8)
    modalDialog:setHeight(500)

    local enterFunc = function()
        local focusedChoice = choiceList:getFocusedChild()
        local choice = 0xFF
        if focusedChoice then
            choice = focusedChoice.choiceId
        end
        g_game.answerModalDialog(id, enterButton, choice)
        destroyDialog()
    end

    local escapeFunc = function()
        local focusedChoice = choiceList:getFocusedChild()
        local choice = 0xFF
        if focusedChoice then
            choice = focusedChoice.choiceId
        end
        g_game.answerModalDialog(id, escapeButton, choice)
        destroyDialog()
    end

    choiceList.onDoubleClick = enterFunc

    modalDialog.onEnter = enterFunc
    modalDialog.onEscape = escapeFunc
end
