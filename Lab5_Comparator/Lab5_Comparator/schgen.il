;------------------------------------------------------------
; createNBitComparator:
;   Place HCC0 on the right and FCC1…FCCn to its left,
;   wire A/B stubs, and ripple-connect O_out→O_in.
;------------------------------------------------------------
procedure( createNBitComparator(N)
  ;;————————————————————————————————————————————————————
  ;; 1) Parameters: change these to suit your library/grid

  libName     = "Lab5_Comparator"      ; your lib
  cellName    = "Comp_8bit_skill_test" ; Target Cell Name (in which the schematic will be genrated)
  symViewName = "symbol" 
  hccName     = "HCC_D1"           
  fccName     = "FCC_D3"
  origin      = list(0 0)
  dx          = 2.5
  stubLen     = 1
  prevInst    = nil

  ;;————————————————————————————————————————————————————
  ;; 2) Open Schematic and get the Top-Level Cellview

  cv = dbOpenCellViewByType(libName cellName "schematic" "schematic" "a") 
  geOpen(?lib libName ?cell cellName ?view "schematic" ?mode "a") 

  ;;————————————————————————————————————————————————————
  ;; 3) Loop over bits from 0 to N

  for( i 0 N
    ;; decide cell & name
    if( i == 0 then
      cellName = hccName
      instName = "HCC0"
    else
      cellName = fccName
      instName = sprintf( nil "FCC%d" i )
    )

    ;; compute placement point
    pt = list( car(origin) - i*dx  cadr(origin) )

    ;; Open the Cell Symbol view
	  Curr_Cell=dbOpenCellViewByType(libName cellName symViewName "schematicSymbol" "r")
    ;; Place the symbol
    inst = dbCreateInst(
             cv
             Curr_Cell
             instName
             pt
             "R0"
           )

    ;;————————————————————————————————————————————
    ;; 4a) Wire & label A<i>

    aTerm   = dbFindTermByName( inst "A" )
    pA      = aTerm~>point                          ; pin location
    println(pA)
    pAstub  = list( car(pA)  cadr(pA) + stubLen )
    geCreateWire( cv pA pAstub )
    dbCreateLabel( cv (sprintf( nil "A<%d>" i )) pAstub )

    

    ;;————————————————————————————————————————————
    ;; 4b) Wire & label B<i>
    bTerm   = geGetInstTerminal( inst "B" )
    pB      = bTerm~>point
    pBstub  = list( car(pB)  cadr(pB) + stubLen )
    geCreateWire( cv pB pBstub )
    dbCreateLabel( cv (sprintf( nil "B<%d>" i )) pBstub )

    ;;————————————————————————————————————————————
    ;; 4c) Ripple‐connect previous cell’s O_out<*> → this cell’s O_in<*>
    when( prevInst
      ;; bit‐1
      termPrev1 = geGetInstTerminal( prevInst "O_out<1>" )
      termCur1  = geGetInstTerminal( inst    "O_in<1>"  )
      geCreateWireAndConnect( cv list(termPrev1 termCur1) )

      ;; bit‐2
      termPrev2 = geGetInstTerminal( prevInst "O_out<2>" )
      termCur2  = geGetInstTerminal( inst    "O_in<2>"  )
      geCreateWireAndConnect( cv list(termPrev2 termCur2) )
    )

    prevInst = inst
  )

  println("N‐bit comparator placed and wired!")
)
