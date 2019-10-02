profile_settings = {
    extension_npm_cache = 1,
    extension_npm = 1
}

function add_modules(path)
    local completions_dir = path .. "/"
    for _,lua_module in ipairs(clink.find_files(completions_dir..'*.lua')) do
        -- Skip files that starts with _. This could be useful if some files should be ignored

        if profile_settings["extension_" .. lua_module:match[[(.*).lua$]]] ~= -1 then
            if not string.match(lua_module, '^_.*') then
                local filename = completions_dir..lua_module
                -- use dofile instead of require because require caches loaded modules
                -- so config reloading using Alt-Q won't reload updated modules.
                dofile(filename)
            end
        end
    end
end


local script_dir = debug.getinfo(1, "S").source:match[[^@?(.*[\/])[^\/]-$]]
add_modules(script_dir .. "clink-completions")
