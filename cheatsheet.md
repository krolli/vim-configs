# Splits and windows
| input | category | description |
| ----- | -------- | ----------- |
| `:vsplit` | | create vertical split |
| `:close` | |close current window |
| `:q` | | close current split and vim as well if it was the last one |
| `<CTRL-W>` | | enter window command mode |
| `c` | window command | close current window |
| `v` | window command | create vertical split |
| `r` | window command | switch contents of splits |
| `w` | window command | focus next window |
| `h` | window command | focus window to the left |
| `j` | window command | focus window below |
| `k` | window command | focus window above |
| `l` | window command | focus window to the right |

# Buffers
| input | category | description |
| ----- | -------- | ----------- |
| `:e <filename>` | | open `<filename>` into buffer in current split |
| `:bd [N]` | | close buffer `N` or current buffer if none specified |

# Movement
| input | category | description |
| ----- | -------- | ----------- |
| `/`   | | enter search mode |
| `n`   | command | jump to next search result |

# Folding
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

# Editing
| input | category | description |
| ----- | -------- | ----------- |
| `x` | command | delete character under cursor |
| `d` | operator | delete |
| `dd` | command | delete line and store it in register |
| `u` | command | undo last edit |
| `U` | command | undo all edits of current line |
| `<CTRL-R>` | command | redo after undo |
| `p` | command | put previously deleted text from register below cursor |
| `P` | command | put previously deleted text from register above cursor |
| `r` | command? | replace, aka. delete character, enter insert mode and leave after typing one character |
| `c` | operator | change, aka. delete text and enter insert mode |
| `y` | operator | yank text into register |

