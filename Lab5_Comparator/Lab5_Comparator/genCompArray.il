load("/home/viterbi/04/shauryac/work_gpdk045/SCRIPTS/myFunctions.il") ;<--your path

libName     = "Lab5_Comparator"      ; your lib
working_cell    = "Comp_16bit_skill_test"
symViewName = "symbol"        ; view name  
hccName     = "HCC_D1"           
fccName     = "FCC_D2"
fccCellWidth = 5.6
prevInst    = nil

procedure(genCompArray(N)
    cell = working_cell
    lib = libName

    cvSch=dbOpenCellViewByType(lib cell "schematic" "schematic" "r")
    ; cvLay=lxGenFromSource(cvSch ?layViewName "layout" ?extractAfterGenerateAll t ?initCreateBoundary nil )
    cvLay=dbOpenCellViewByType(lib cell "layout" "maskLayout" "a")
    
    geOpen(?lib lib ?cell cell ?view "layout" ?mode "a")
    deInstallApp(getCurrentWindow() "Virtuoso XL")

    x_index = 0
    y_index = 0

    for( i 0 N-1
    ;; pick cell & instance name
    if( i == 0 then
      cellName = hccName
      instName = "HCC0"
      cellCreate(cellName, x_index, y_index, 0, 0)
      x_index = x_index - fccCellWidth
    else
      cellName = fccName
      instName = sprintf(nil "FCC%d" i)
      cellCreate(cellName, x_index, y_index, 0, 0)
      x_index = x_index - fccCellWidth
    )

    lxUpdateBinding(cvLay ?schCV cvSch)
    )
)
