"=============================================================================
"    Description: QFixHowm option convert function
"         Author: fuenor <fuenor@gmail.com>
"                 http://sites.google.com/site/fudist/Home  (Japanese)
"  Last Modified: 0000-00-00 00:00
"=============================================================================
let s:Version = 1.00
scriptencoding utf-8

if exists('g:QFixHowm_Convert') && g:QFixHowm_Convert == 0
  finish
endif

"-----------------------------------------------------------------------------
" このファイルでオプションのコンバートを行っているため、QFixMemoはQFixHowmとオ
" プション互換のプラグインとして動作しています。
"
" .vimrcに以下を設定するとQFixHowmオプションのコンバートを行わなくなります。
"
" " QFixHowmとのオプションコンバートを行わない
" let QFixHowm_Convert = 0
"
" コンバートを切ったとしても基本的なコマンドや動作はほぼ同一に扱えます。
" メモファイル名などのオプションは一部異なっていますが、予定・TODOについては
" QFixHowmのオプションがそのまま適用されます。
"
" ドキュメントについては以下を参照してください。
" doc/qfixmemo.txt
" (Vimで閲覧するとヘルプとしてハイライトされます)
" http://github.com/fuenor/qfixmemo/blob/master/doc/qfixmemo.txt
"-----------------------------------------------------------------------------

" BufEnter
function! QFixMemoBufEnterPre()
  call QFixHowmSetup()
endfunction

" VimEnter
function! QFixMemoVimEnter()
  call QFixHowmSetup()
endfunction

" 初期化
function! QFixMemoInit()
  call QFixHowmSetup()
endfunction

let s:howmsuffix        = 'howm'
if !exists('howm_dir')
  let howm_dir          = '~/howm'
endif
if !exists('howm_filename')
  let howm_filename     = '%Y/%m/%Y-%m-%d-%H%M%S.'.s:howmsuffix
endif
" howmファイルの拡張子
if !exists('loaded_MyHowmChEnv')
  let QFixHowm_FileExt  = fnamemodify(g:howm_filename,':e')
endif
if !exists('howm_fileencoding')
  let howm_fileencoding = &enc
endif
if !exists('howm_fileformat')
  let howm_fileformat   = &ff
endif
" howmファイルタイプ
if !exists('QFixHowm_FileType')
  let QFixHowm_FileType = 'howm_memo'
endif

" クイックメモファイル名
if !exists('g:QFixHowm_QuickMemoFile')
  let g:QFixHowm_QuickMemoFile = 'Qmem-00-0000-00-00-000000.'.g:QFixHowm_FileExt
endif
" 日記メモファイル名
if !exists('g:QFixHowm_DiaryFile')
  let g:QFixHowm_DiaryFile = fnamemodify(g:howm_filename, ':h').'/%Y-%m-%d-000000.'.g:QFixHowm_FileExt
endif

" ペアリンクされたhowmファイルの保存場所
if !exists('g:QFixHowm_PairLinkDir')
  let g:QFixHowm_PairLinkDir = 'pairlink'
endif

" ファイル読込の際に、ファイルエンコーディングを強制する
if !exists('g:QFixHowm_ForceEncoding')
  let g:QFixHowm_ForceEncoding = 1
endif

"最近更新ファイル検索日数
if !exists('g:QFixHowm_RecentDays')
  let g:QFixHowm_RecentDays = 5
endif

" 折りたたみのパターン
if !exists('g:QFixHowm_FoldingPattern')
  let g:QFixHowm_FoldingPattern = '^[=.*]'
endif
" 検索時にカーソル位置の単語を拾う
if !exists('g:QFixHowm_DefaultSearchWord')
  let g:QFixHowm_DefaultSearchWord = 1
endif

" ランダム表示保存ファイル
if !exists('g:QFixHowm_RandomWalkFile')
  let g:QFixHowm_RandomWalkFile = '~/.howm-random'
endif
" ランダム表示保存ファイル更新間隔
if !exists('g:QFixHowm_RandomWalkUpdate')
  let g:QFixHowm_RandomWalkUpdate = 10
endif
" ランダム表示数
if !exists('g:QFixHowm_RandomWalkColumns')
  let g:QFixHowm_RandomWalkColumns = 10
endif
" ランダム表示しない正規表現
if !exists('g:QFixHowm_RandomWalkExclude')
  let g:QFixHowm_RandomWalkExclude = ''
endif

" スプリットで開く
if !exists('g:QFixHowm_SplitMode')
  let g:QFixHowm_SplitMode = 0
endif

" howmテンプレート
if !exists('g:QFixHowm_Template')
  let g:QFixHowm_Template = [
    \ "%TITLE% %TAG%",
    \ "%DATE%",
    \ ""
  \]
endif

" howmテンプレート(カーソル移動)
if !exists('g:QFixHowm_Cmd_NewEntry')
  let g:QFixHowm_Cmd_NewEntry = "$a"
endif
if !exists('g:QFixHowm_DefaultTag')
  let g:QFixHowm_DefaultTag = ''
endif

"キーマップリーダー
if !exists('g:QFixHowm_Key')
  if exists('g:howm_mapleader')
    let g:QFixHowm_Key = howm_mapleader
  else
    let g:QFixHowm_Key = 'g'
  endif
endif

"2ストローク目キーマップ
if !exists('g:QFixHowm_KeyB')
  let g:QFixHowm_KeyB = ','
endif
if !exists('g:qfixmemo_mapleader')
  let g:qfixmemo_mapleader     = g:QFixHowm_Key . g:QFixHowm_KeyB
endif
if !exists('g:QFixHowm_Wiki')
  let g:QFixHowm_Wiki = 0
endif
if !exists('g:QFixHowm_WikiDir')
  let g:QFixHowm_WikiDir = ''
endif
if !exists('g:QFixHowm_keywordfile')
  let g:QFixHowm_keywordfile = '~/.howm-keys'
endif

if !exists('g:QFixMRU_RootDir') && exists('g:QFixHowm_RootDir')
  let g:QFixMRU_RootDir = g:QFixHowm_RootDir
endif
if !exists('g:QFixMemo_RootDir') && exists('g:QFixHowm_RootDir')
  let g:QFixMemo_RootDir = g:QFixHowm_RootDir
endif

function! QFixHowmSetup()
  let g:qfixmemo_dir           = g:howm_dir
  let g:qfixmemo_fileencoding  = g:howm_fileencoding
  let g:qfixmemo_fileformat    = g:howm_fileformat
  let g:qfixmemo_ext           = g:QFixHowm_FileExt

  " キーマップリーダー
  let g:qfixmemo_mapleader     = g:QFixHowm_Key . g:QFixHowm_KeyB

  " タイトルマーカー
  let g:qfixmemo_title         = g:QFixHowm_Title
  call QFixMemoTitleRegxp()
  " ファイルタイプ
  let g:qfixmemo_filetype      = g:QFixHowm_FileType
  " ファイルエンコーディング強制
  let g:qfixmemo_forceencoding = g:QFixHowm_ForceEncoding

  " 新規メモファイル名
  let g:qfixmemo_filename      = fnamemodify(g:howm_filename, ':r')
  " 日記ファイル名
  let g:qfixmemo_diary         = fnamemodify(g:QFixHowm_DiaryFile, ':r')
  " クイックメモファイル名
  let g:qfixmemo_quickmemo     = fnamemodify(g:QFixHowm_QuickMemoFile, ':r')
  " ペアファイルの作成先ディレクトリ
  let g:qfixmemo_pairfile_dir  = g:QFixHowm_PairLinkDir

  " タイムスタンプフォーマット
  let g:qfixmemo_timeformat = '['. g:QFixHowm_DatePattern . ' %H:%M]'
  call qfixmemo#SetTimeFormatRegxp(g:qfixmemo_timeformat)

  " " 新規エントリテンプレート
  let g:qfixmemo_template        = g:QFixHowm_Template
  let g:qfixmemo_template_keycmd = g:QFixHowm_Cmd_NewEntry
  let g:qfixmemo_template_tag    = g:QFixHowm_DefaultTag

  " 最近更新したエントリ一覧の日数
  let g:qfixmemo_recentdays = g:QFixHowm_RecentDays

  " フォールディングパターン
  let g:qfixmemo_folding_pattern = g:QFixHowm_FoldingPattern

  " 自動タイトル行の文字数
  let g:qfixmemo_title_length = g:QFixHowm_Replace_Title_Len

  " grep時にカーソル位置の単語を拾う
  let g:qfixmemo_grep_cword = g:QFixHowm_DefaultSearchWord

  " 連結表示のセパレータ
  " let g:qfixmemo_separator = '>>> %s'

  " ランダム表示保存ファイル
  let g:qfixmemo_random_file    = g:QFixHowm_RandomWalkFile
  " ランダム表示ファイル更新時間(秒)
  let g:qfixmemo_random_time    = g:QFixHowm_RandomWalkUpdate*24*60*60
  " ランダム表示数
  let g:qfixmemo_random_columns = g:QFixHowm_RandomWalkColumns
  " ランダムに表示しない正規表現
  let g:qfixmemo_random_exclude = g:QFixHowm_RandomWalkExclude

  " 新規ファイル作成時のオプション
  " let g:qfixmemo_editcmd = ''
  let g:qfixmemo_splitmode = g:QFixHowm_SplitMode

  if exists('g:QFixHowm_HowmMode') && g:QFixHowm_HowmMode == 0
    let g:qfixmemo_ext      = g:QFixHowm_UserFileExt
    let g:qfixmemo_filetype = g:QFixHowm_UserFileType
  endif
  let g:qfixmemo_keyword_mode = g:QFixHowm_Wiki
  let g:qfixmemo_keyword_file = g:QFixHowm_keywordfile
  let g:qfixmemo_keyword_dir  = g:QFixHowm_WikiDir
endfunction

