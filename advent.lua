#!/usr/local/bin/lumarsh

langs = {}
langs.asm = {}
langs.c = {}
langs.d = {}
langs.go = {}
langs.python = {}
langs.csharp = {}
langs.fsharp = {}

-- Helpers

function genericScaffold(folder, language)
    folder = sh.path.buildPath({folder, language})
    if not sh.fs.exists(folder) then
        sh.fs.mkdirRecurse(folder)
        sh:cp("-r", "templates/"..language, sh.path.buildPath({folder, ".."}))
        sh:cp("templates/input.txt", folder)
    end
end

function timeSolution(exe, args)
    local output = sh.proc.executeEnforceZero(exe, args or {}).output
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

function genericRun(folder, lang, exe, args)
    folder = sh.path.buildPath({folder, lang})

    local cdir = sh.path.getcwd()
    sh.fs.chdir(folder)
    local result = timeSolution(exe, args)
    sh.fs.chdir(cdir)
    return result
end

-- Languages

function langs.asm.run(folder) return makeRun(folder, 'asm') end
function langs.asm.scaffold(folder) genericScaffold(folder, 'asm') end

function langs.c.run(folder) return mesonRun(folder, 'c') end
function langs.c.scaffold(folder) genericScaffold(folder, 'c') end

function langs.d.run(folder) return mesonRun(folder, 'd') end
function langs.d.scaffold(folder) genericScaffold(folder, 'd') end

function langs.go.run(folder) return genericRun(folder, 'go', 'go', {'run', '.'}) end
function langs.go.scaffold(folder) genericScaffold(folder, 'go') end

function langs.python.run(folder) return genericRun(folder, 'python', 'python', {'./app.py'}) end
function langs.python.scaffold(folder) genericScaffold(folder, 'python') end

function langs.csharp.run(folder) return genericRun(folder, 'csharp', 'dotnet', {'run'}) end
function langs.csharp.scaffold(folder) genericScaffold(folder, 'csharp') end

function langs.fsharp.run(folder) return genericRun(folder, 'fsharp', 'dotnet', {'run'}) end
function langs.fsharp.scaffold(folder) genericScaffold(folder, 'fsharp') end

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