				db      "g GCE NOT ", $80       ; 'g' is copyright sign
                dw      music1                  ; music from the rom
                db      $F8, $50, $20, -$50     ; height, width, rel y, rel x
                                                ; (from 0,0)
                db      "STORM STORM",$80  ; some game information,
                                                ; ending with $80
                db      0                       ; end of game header