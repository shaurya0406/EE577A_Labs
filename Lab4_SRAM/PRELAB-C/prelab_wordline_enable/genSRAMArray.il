load("/home/viterbi/03/shuohong/work_gpdk045/myFunctions.il") ;<--your path

; basic dimensions of the SRAM cell 
cellOverlapVerticalP = 0.24
cellOverlapVerticalG = 0.14
cellOverlapHori = 0
cellHeight = 1.98
cellWidth = 1.12
boundarytoTop = cellOverlapVerticalP/2
boundarytoLeft = cellOverlapHori/2

; Power stripe cell dimension
PWRSTRIPE_cellwidth = 1.125

; Precharge cell dimension
pre_cellHeight = 1.08

; Wordline Enable cell dimension
WE_cellWidth = 1.125

; Mux cell dimention
Mux_cellHeight = 0

; initialize lib name, working cell name, and cell components names
lib_name = "PRELAB-C"           ; the library name for which includes all your memory cell components
working_cell = "SRAM_skill_test"      ; the cell name for which you are currently working on
PWRSTRIPE_cell = "PWRSTRIPE1"   ; the cell name for the power stripe
SRAM_cell = "SRAM_1bit"         ; the cell name for your SRAM bit cell
PRE_cell = "PreCharge_1bit"          ; the cell name for your precharge circuit
WE_cell = "AND2"                ; the cell name for your wordline enable circuit
ColMux_Cell = ""                ; the cell name for your column mux


procedure(genSRAMArray(row, column)
    cell = working_cell
    lib = lib_name

    cvSch=dbOpenCellViewByType(lib cell "schematic" "schematic" "r")
    ; cvLay=lxGenFromSource(cvSch ?layViewName "layout" ?extractAfterGenerateAll t ?initCreateBoundary nil )
    cvLay=dbOpenCellViewByType(lib cell "layout" "maskLayout" "a")
    
    geOpen(?lib lib ?cell cell ?view "layout" ?mode "a")
    deInstallApp(getCurrentWindow() "Virtuoso XL")
    ; Place SRAM cells
    ;placeComponentArray(row, column, 0, -boundarytoTop, SRAM_cell, PWRSTRIPE_cell, 1)
    placeComponentArrayWOpwr(row, column, 0, -boundarytoTop, SRAM_cell)

    ; Place Precharge cells
    ;placeComponentArray(1, column, 0, pre_cellHeight + cellOverlapVerticalG/2 - cellOverlapVerticalP, PRE_cell, PWRSTRIPE_cell, 0)
    placeComponentArrayWOpwr(1, column, 0, pre_cellHeight + cellOverlapVerticalG/2 - cellOverlapVerticalP, PRE_cell)

    ; Place WE cells
    placeComponentArray(row, 1, - WE_cellWidth, -boundarytoTop, WE_cell, PWRSTRIPE_cell, 0)

    ; Place MUX cells
    placeComponentArray(1, column/4, 0, -cellHeight*row-boundarytoTop, ColMux_Cell, PWRSTRIPE_cell, 0)

)

procedure(placeComponentArray(row, column, x_index, y_index, component_name, PWRSTRIPE_cell, pwr)
    oldRight = x_index
    oldBottom = y_index
    count = 0
    rowCount = 0
    colCount = 0
    for(i 1 row
        oldRight = x_index - boundarytoLeft
        isEvenRow = mod(rowCount 2)
        for(j 1 column
            if((isEvenRow ==0) cellCreate(component_name, oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalP, 0, 0))
            if((isEvenRow ==1) cellCreate(component_name, oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalG, 0, 1))

            oldRight =  car(cadr(cellInst~>bBox))
            count = count + 1
            colCount = colCount + 1
        )
        rowCount = rowCount + 1
        if(((isEvenRow == 0) && (pwr == 1)) cellCreate("PWRSTRIPE1", oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalP, 0, 0))
        if(((isEvenRow == 1) && (pwr == 1)) cellCreate("PWRSTRIPE1", oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalG, 0, 1))
        oldBottom = cadr(car(cellInst~>bBox))
    )
    
    lxUpdateBinding(cvLay ?schCV cvSch)
)

procedure(placeComponentArrayWOpwr(row, column, x_index, y_index, component_name)
    oldRight = x_index
    oldBottom = y_index
    count = 0
    rowCount = 0
    colCount = 0
    for(i 1 row
        oldRight = x_index - boundarytoLeft
        isEvenRow = mod(rowCount 2)
        for(j 1 column
            if((isEvenRow ==0) cellCreate(component_name, oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalP, 0, 0))
            if((isEvenRow ==1) cellCreate(component_name, oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalG, 0, 1))

            oldRight =  car(cadr(cellInst~>bBox))
            count = count + 1
            colCount = colCount + 1
        )
        rowCount = rowCount + 1
        ;if(((isEvenRow == 0) && (pwr == 1)) cellCreate("PWRSTRIPE1", oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalP, 0, 0))
        ;if(((isEvenRow == 1) && (pwr == 1)) cellCreate("PWRSTRIPE1", oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalG, 0, 1))
        oldBottom = cadr(car(cellInst~>bBox))
    )
    
    lxUpdateBinding(cvLay ?schCV cvSch)
)