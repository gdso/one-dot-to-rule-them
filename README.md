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


    $ cd ~
