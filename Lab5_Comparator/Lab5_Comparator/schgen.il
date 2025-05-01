;------------------------------------------------------------
; create8BitComparator:
;   Place HCC0 on the right and FCC1…FCC7 to its left,
;   wire A/B stubs, and ripple-connect O_out→O_in.
;------------------------------------------------------------
procedure( create8BitComparator( / cv libName symViewName
                                 / hccName fccName origin dx stubLen
                                 / prevInst inst pt instName cellName
                                 / aTerm bTerm pA pB pAstub pBstub
                                 / termPrev1 termCur1 termPrev2 termCur2
                               )
  ;;————————————————————————————————————————————————————
  ;; 1) Init
  cv           = geGetEditCellView()           ; your active schematic
  libName      = "Lab5_Comparator"                    ; <-- change to your library
  symViewName  = "symbol"                      ; view name of HCC/FCC symbols
  hccName      = "HCC_D3"    
  fccName      = "FCC_D3"
  origin       = list( 0:um  0:um )            ; lower‐right corner of HCC0
  dx           = 5:um                          ; horizontal pitch between cells
  stubLen      = 1:um                          ; length of A/B stubs
  prevInst     = nil
  ;; HCC_width = 1.6875
  ;; HCC_height = 0.625
  ;; FCC_width = 2.5
  ;; FCC_height = 1.1875

  ;;————————————————————————————————————————————————————
  ;; 2) Loop over bits 0…7

  for( i 0 7
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

    ;; place the instance
    inst = dbCreateInst( cv 
                         libName       ; library
                         cellName      ; cell master name
                         symViewName   ; view (symbol)
                         pt            ; placement point
                         "R0"          ; orientation 
                         instName      ; instance name
                       )

    ;;————————————————————————————————————————————
    ;; 3) Wire & label A<i>
    aTerm   = dbFindTermByName( inst "A" )
    pA      = aTerm~>point                          ; pin location
    println(pA)
    pAstub  = list( car(pA)  cadr(pA) + stubLen )
    geCreateWire( cv pA pAstub )
    dbCreateLabel( cv (sprintf( nil "A<%d>" i )) pAstub )

    

    ;;————————————————————————————————————————————
    ;; 4) Wire & label B<i>
    bTerm   = geGetInstTerminal( inst "B" )
    pB      = bTerm~>point
    pBstub  = list( car(pB)  cadr(pB) + stubLen )
    geCreateWire( cv pB pBstub )
    dbCreateLabel( cv (sprintf( nil "B<%d>" i )) pBstub )

    ;;————————————————————————————————————————————
    ;; 5) Ripple‐connect previous cell’s O_out<*> → this cell’s O_in<*>
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

  println("8‐bit comparator placed and wired!")
)
