# one-dot-to-rule-them
My personal dotfile backup, powered by `chezmoi`

## Install

### Pre-requisites

 * Install `asdf` 

 * Install asdf `chezmoi` plugin :

       asdf plugin add chezmoi

    
 * Install `chezmoi` via `asdf`:

       asdf install chezmoi 2.40.0


 * Add `chezmoi` configuration to ~/.config/chezmoi/chezmoi.yaml:

       touch ~/.config/chezmoi/chezmoi.yaml


 * Paste the following into `chezmoi.yaml`:


       sourceDir: ~/.config/chezmoi/chezmoi.yaml
       edit: 
         command: nvim



## Using `chezmoi`


### Add a file into chezmoi's management

    $ chezmoi add [path_to_file]


### Edit a configuration file

    $ chezmoi edit [path_to_file]

### Re-add an edited file

If you edit a configuration file without `chezmoi edit`, you can _re-add_ it:

    $ chezmoi re-add [path_to_file]
