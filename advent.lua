langs = {}
langs.asm = {}
langs.c = {}
langs.d = {}
langs.go = {}
langs.python = {}
langs.csharp = {}
langs.fsharp = {}
langs.lua = {}
langs.ts = {}

-- Helpers

function genericScaffold(folder, language)
    folder = sh.path.buildPath({folder, language})
    if not sh.fs.exists(folder) then
        sh.fs.mkdirRecurse(folder)
        sh:cp("-r", "templates/"..language, sh.path.buildPath({folder, ".."}))
        sh:cp("templates/input.txt", folder)
    end
end

function timeSolution(exe)
    local output = sh.proc.executeEnforceZero("./solution", {}).output
    local match = sh.regex.matchFirst(output, "__TIME__ = (\\d+)")
    assert(match.matched, "Regex failed?")
    return tonumber(match.captures[2]) -- Microseconds
end

function mesonRun(folder, language)
    folder = sh.path.buildPath({folder, language})

    local cdir = sh.path.getcwd()
    sh.fs.chdir(folder)
    sh.proc.executeShell('meson', {'build'})
    sh.fs.chdir('build')
    sh:ninja()
    sh:cp("./solution", "..")
    sh.fs.chdir("..")
    local result = timeSolution("./solution")
    sh.fs.chdir(cdir)
    return result
end

function makeRun(folder, language)
    folder = sh.path.buildPath({folder, language})

    local cdir = sh.path.getcwd()
    sh.fs.chdir(folder)
    sh:make('-B')
    local result = timeSolution("./solution")
    sh.fs.chdir(cdir)
    return result
end

-- Languages

function langs.asm.run(folder) return makeRun(folder, 'asm') end
function langs.asm.scaffold(folder) genericScaffold(folder, 'asm') end

function langs.d.run(folder) return mesonRun(folder, 'd') end
function langs.d.scaffold(folder) genericScaffold(folder, 'd') end

-- Commands

if LUMARSH_ARGS and LUMARSH_ARGS[1] == "test" then
    if sh.fs.exists("test") then
        sh:rm("-rf", "test")
    end
    for lang,v in pairs(langs) do
        if v.scaffold then
            v.scaffold("test")
            v.run("test")
        end
    end
elseif LUMARSH_ARGS and LUMARSH_ARGS[1] == "scaffold" then
    local day = LUMARSH_ARGS[2]
    assert(day, "Please provide which day to scaffold")

    for lang,v in pairs(langs) do
        if v.scaffold then
            v.scaffold(day)
            v.run(day) -- Ensure it compiles
        end
    end
end