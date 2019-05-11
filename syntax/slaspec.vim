" Vim syntax file
" Language: Ghidra SLEIGH spec file
" Maintainer: Philipp Joram
" Latest Revision: 08/03/2019

if exists("b:current_syntax")
  finish
endif

syn match slaComment '\v(:\w+.*)@<!#.*$' contains=NONE
syn match slaConstant '\v(\w)@!<[0-9]+'
syn match slaConstant '\v(\w)@!<0x[0-9a-fA-F]+'
syn match slaConstant '\v(\w)@!<0b[01]+'

syn region slaString start=/\v"/ skip=/\v\\./ end=/\v"/

syn match slaPreDefine '\v^\@\s*define'
syn match slaPreIfDef '\v^\@\s*ifn?def'
syn match slaPreCondit '\v^\@\s*(if|elif)'
syn match slaPreConditEnd '\v^\@\s*(else|endif)'

syn match slaTableHeader '\v^:\w+'
syn match slaTableHeader '\v^\s*\w*:\w*'

syn region slaSemantics start=/{/ end=/}/

syn keyword slaDefine define nextgroup=slaDefineOp
syn keyword slaDefineOp endian alignment space token context

syn keyword slaAttach attach nextgroup=slaAttachOp
syn keyword slaAttachOp names values variables

syn match slaOpArg '\v\w+(\s*\=)@='

syn match slaLabel '\v\<\w+\>'

syn keyword slaFuncs zext sext inst_next inst_start delayslot

syn keyword slaKeywords is unimpl macro
syn keyword slaKeywords const export local if goto call return build
syn keyword slaEps epsilon
syn match slaOperator '\(&\||\|;\|<<\|>>\|<\|>\|\^\|*\)'

hi def link slaComment Comment

hi def link slaConstant Constant
hi def link slaString String

hi def link slaPreDefine Define
hi def link slaPreIfDef PreCondit
hi def link slaPreCondit PreCondit
hi def link slaPreConditEnd PreCondit

hi def link slaFuncs Function
hi def link slaLabel Label

hi def link slaDefine Keyword
hi def link slaDefineOp Function
hi def link slaOpArg Special

hi def link slaAttach Keyword
hi def link slaAttachOp Function

hi def link slaKeywords Keyword
hi def link slaEps Special
hi def link slaOperator Operator

hi def link slaTableHeader Identifier

let b:current_syntax = "slaspec"
