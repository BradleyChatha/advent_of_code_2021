project('solution', 'd')

custom_target('copy-input',
    input: 'input.txt',
    output: 'input.txt',
    command: ['cp', '@INPUT@', '@OUTPUT@'],
    install: false,
    build_by_default: true
)

srcs = [
    'app.d'
]

exe = executable('solution', srcs)