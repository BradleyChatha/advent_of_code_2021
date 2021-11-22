project('solution', 'c')

custom_target('copy-input',
    input: 'input.txt',
    output: 'input.txt',
    command: ['cp', '@INPUT@', '@OUTPUT@'],
    install: false,
    build_by_default: true
)

srcs = [
    'app.c',
    'solution.c',
]

exe = executable('solution', srcs)