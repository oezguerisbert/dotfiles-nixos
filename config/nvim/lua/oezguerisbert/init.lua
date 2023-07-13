local function init()
    require 'oezguerisbert.vim'.init()
    require 'oezguerisbert.theme'.init()
    require 'oezguerisbert.languages'.init()
    require 'oezguerisbert.chatgpt'.init()
    require 'oezguerisbert.floaterm'.init()
    require 'oezguerisbert.noice'.init()
    require 'oezguerisbert.telescope'.init()
end

return {
    init = init,
}
