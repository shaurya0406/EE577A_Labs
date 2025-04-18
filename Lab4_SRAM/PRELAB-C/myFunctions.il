; This script includes the two functions that places the pins/cells to a certain coordinate
; The cell placement function gives the option to flip horizontally or vertically
procedure(pinPlacement(pinName, x_index, y_index, metalLayer)
    hsmSelect(?type 'pin ?name pinName)
    pin = car(geGetSelSet())
    pin~>layerName = metalLayer
    hsmDeselect(?type 'pin ?name pinName)
    bBoxLeft=car(car(pin~>bBox))
    bBoxRight=car(cadr(pin~>bBox))
    bBoxTop=cadr(cadr(pin~>bBox))
    bBoxBottom=cadr(car(pin~>bBox))
    delta_x = - bBoxLeft + x_index
    delta_y = - bBoxTop - y_index
    dbMoveFig(pin nil list(list(delta_x delta_y) "R0" 1.0))
)

procedure(cellPlacement(Inst, x_index, y_index, flipHori, flipVertical)
    bBoxLeft = car(car(Inst~>bBox))
	bBoxRight = car(cadr(Inst~>bBox))
	bBoxTop = cadr(cadr(Inst~>bBox))
	bBoxBottom = cadr(car(Inst~>bBox))
    ;flip horizontally or vertically
    if((flipHori == 1) dbMoveFig(Inst nil list((bBoxLeft+bBoxRight):0 "MY")))
    if((flipVertical == 1) dbMoveFig(Inst nil list(0:(bBoxTop+bBoxBottom) "MX")))
	delta_x = -bBoxLeft + x_index
	delta_y = -bBoxTop + y_index
	dbMoveFig(Inst nil list(list(delta_x delta_y) "R0"))
)

procedure(pinDelete(pinName)
    hsmSelect(?type 'pin ?name pinName)
    pin = car(geGetSelSet())
    dbDeleteObject(pin)
)

procedure(cellCreate(Inst, x_index, y_index, flipHori, flipVertical)
    pwrStripeCell=dbOpenCellViewByType(lib Inst "layout" "maskLayout" "r")
    cellInst=dbCreateInst(cvLay pwrStripeCell nil list(0 0) "R0")
    cellPlacement(cellInst, x_index, y_index, flipHori, flipVertical)
)

procedure(labelCreate(pinName, x_index, y_index, metalLayer)
    dbCreateLabel(cvLay list(metalLayer "pin") x_index:-y_index pinName "centerCenter" "R0" "stick" 0.05)
)

procedure(createVia(x_index, y_index, viaLayer) ; viaLayer sample: "M4_M3"
    tf=techGetTechFile(cvLay)
    viaDef=techFindViaDefByName(tf viaLayer)
    dbCreateVia(cvLay viaDef x_index:y_index "R0") ; could also pass parameterList
)

