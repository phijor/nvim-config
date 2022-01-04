call TexNewMathZone("E","align",1)
call TexNewMathZone("F","alignat",1)
call TexNewMathZone("G","equation",1)
call TexNewMathZone("H","flalign",1)
call TexNewMathZone("I","gather",1)
call TexNewMathZone("J","multline",1)
call TexNewMathZone("K","xalignat",1)
call TexNewMathZone("L","xxalignat",0)

syntax match TexCommentNoSpell /\\\w\+/ contains=@NoSpell
