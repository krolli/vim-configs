# Useful links
<https://learnbyexample.github.io/vim_reference/Introduction.html>
<https://github.com/iggredible/Learn-Vim/blob/master/ch20_views_sessions_viminfo.md>

# Sessions
`:mksession <file-path.vim>` - saves current session (state, open files, ...)
`:source <file-path.vim>` - restores session
`nvim -S <file-path.vim>` - starts vim, restoring specific session

# Normal mode

## Folding
| input | category | description |
| ----- | -------- | ----------- |
| `za`  | command  | toggle fold |
| `zA`  | command  | toggle folds recursively |
| `zo`  | command  | open fold |
| `zO`  | command  | open folds recursively |
| `zc`  | command  | close fold |
| `zC`  | command  | close folds recursively |
| `zM`  | command  | collapse all |
| `zR`  | command  | expand all |

## Editing commands
| input | category | description |
| ----- | -------- | ----------- |
| `i` | command | enter insert mode to the left of cursor |
| `a` | command | enter insert mode to the right of cursor |
| `I` | command | enter insert mode at the beginning of current line |
| `A` | command | enter insert mode at the end of current line |
| `x` | command | delete character under cursor |
| `dd` | command | delete line and store it in register |
| `u` | command | undo last edit |
| `U` | command | undo all edits of current line |
| `<C-R>` | command | redo after undo |
| `p` | command | put previously deleted text from register below current line |
| `P` | command | put previously deleted text from register above current line |
| `r` | command? | replace, aka. delete character, enter insert mode and leave after typing one character |
| `R` | command | enter replace mode |
| `o` | command | open new line below current line and enter insert mode |
| `O` | command | open new line above current line and enter insert mode |

## Editing operators
| input | category | description |
| ----- | -------- | ----------- |
| `d` | operator | delete |
| `c` | operator | change, aka. delete text and enter insert mode |
| `y` | operator | yank text into register |

## Motions
| input | category | description |
| ----- | -------- | ----------- |
| `w` | exclusive motion | move to the start of the next word |
| `e` | inclusive motion | move to the end of the current word |
| `$` | inclusive motion | move to the end of the current line |
| `0` | inclusive motion | move to the beginning of the current line |
| `G` | inclusive motion | move to the end of the file |
| `gg` | inclusive motion | move to the start of the file |
| num + `G` or `gg` | inclusive motion | move from current position to line "num" |
| `%` | inclusive motion | move to matching wrapping character (pairs (), [], {}) |

# Splits and windows
| input | category | description |
| ----- | -------- | ----------- |
| `:vsplit` | | create vertical split |
| `:close` | |close current window |
| `:q` | | close current split and vim as well if it was the last one |
| `<C-W>` | | enter window command mode |
| `c` | window command | close current window |
| `v` | window command | create vertical split |
| `r` | window command | switch contents of splits |
| `w` | window command | focus next window |
| `h` | window command | focus window to the left |
| `j` | window command | focus window below |
| `k` | window command | focus window above |
| `l` | window command | focus window to the right |

# Mappings
`:h map-overview`
`:h keycodes`

# Buffers
| input | category | description |
| ----- | -------- | ----------- |
| `:e <filename>` | | open `<filename>` into buffer in current split |
| `:bd [N]` | | close buffer `N` or current buffer if none specified |

# Movement
| input | category | description |
| ----- | -------- | ----------- |
| `/`   | | enter search mode in forward direction |
| `?` | | enter search mode in backward direction |
| `n`   | command | jump to next search result in search direction |
| `N` | command | jump to previous search result in search direction |
| `<C-o>` | | return to older position (as navigated using search) |
| `<C-i>` | | return to newer position (as navigated using search) |

# Substitutions
| input | category | description |
|-------|----------|-------------|
| `:s`  | command | substitution command, requires arguments separated by `/` (see below) |
| `:s/old/new` | command | substitute first occurence of "old" with "new" on the current line |
| `:s/old/new/g` | command | substitute all occurences of "old" with "new" on the current line |
| `:1,3s/old/new/g` | command | substitute all occurences of "old" with "new" on lines 1 to 3 inclusive |
| `:%s/old/new/g` | command | substitute all occurences of "old" with "new" in the whole file |
| `:%s/old/new/gc | command | find every occurrence in the whole file and prompt whether to substitute or not |

