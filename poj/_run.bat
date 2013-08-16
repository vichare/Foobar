if "%1"=="" (
    #.exe < #.in > #.out
) else (
    #.exe < %1.in > %1.out
)

