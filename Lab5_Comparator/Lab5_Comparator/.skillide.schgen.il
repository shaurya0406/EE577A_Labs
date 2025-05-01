;------------------------------------------------------------
; create8BitComparator (db-only version)
;   Place HCC0 on the right and FCC1FCC7 to its left,
;   wire A/B stubs, and ripple-connect O_outO_in
;   using only dbCreate* and dbGet* calls.
;------------------------------------------------------------
procedure( schgen() 
  

  ;; 1) Parameters: change these to suit your library/grid
  libName     = "Lab5_Comparator"      ; your lib
  cellName    = "Comp_8bit_skill_test"
  symViewName = "symbol"        ; view name  
  hccName     = "HCC_D3"           
  fccName     = "FCC_D3"
  origin      = list(0 0)
  dx          = 2.5
  stubLen     = 1
  prevInst    = nil

  ;; 2) Get your open schematic (this one is still the built-in call)
  cv = dbOpenCellViewByType(libName cellName "schematic" "schematic" "a") 
  geOpen(?lib libName ?cell cellName ?view "schematic" ?mode "a") 

  ;; 3) Loop over bits 07
  for( i 0 7
    ;; pick cell & instance name
    if( i == 0 then
      cellName = hccName
      instName = "HCC0"
    else
      cellName = fccName
      instName = sprintf(nil "FCC%d" i)
    )

    ;; compute where to place it
    pt = list( car(origin) - i*dx  cadr(origin) )
	
	Curr_Cell=dbOpenCellViewByType(libName cellName symViewName "schematicSymbol" "r")
    ;; place the symbol
    inst = dbCreateInst(
             cv
             Curr_Cell
             instName
             pt
             "R0"
           )
	print("InstID: ")
	println(inst)
	
	aTerm   = dbFindTermByName(Curr_Cell "A")
	print("aTerm: ")
    println(aTerm)
	Net_String = " "
	Net_String = sprintf( Net_String "A<%d>" i )
	inNet = dbCreateNet(cv  Net_String)
	print("inNet: ")
    println(inNet)
	instTerm = dbCreateInstTerm(inNet inst aTerm)
	print("instTerm: ")
    println(instTerm)
	
	

    prevInst = inst
  )

  println("8-bit comparator placed and wired!")
)
