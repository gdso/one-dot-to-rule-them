# one-dot-to-rule-them

My personal dotfile backup, powered by `chezmoi`

## Using `chezmoi`

### Check the status

To see you the status of your dotfiles, including which files
are managed by `chezmoi`, which files have been modified, and which files are not tracked.

```bash
chezmoi status
````

### Add a file into chezmoi's management

````bash
chezmoi add [path_to_file]
````


### Edit a configuration file

```bash
chezmoi edit [path_to_file]
````

### Re-add an edited file

If you edit a configuration file without `chezmoi edit`, you can _re-add_ it:

```bash
chezmoi re-add [path_to_file]
````
This is very useful since you'll most likely edit files directly,
and realize after the fact that you made changes when you [check the status](#check-the-status).
````

