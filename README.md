# Basic introduction to Julia

## Instructions to set up a workspace (similar to the R GUI)

### i. Using VSCode or Atom and Juno:

For VSCode (actively developed) follow the instructions on their web page https://www.julia-vscode.org

For Atom and Juno (maintenance-only) follow the instructions on their web page http://docs.junolab.org/latest/man/installation/


### ii. Using Sublime Text (my preferred):

(If you are on Windows [which I do not use], you need to have `Cmder`, `ConEmu` or similar installed and be able to open the Julia REPL from there; otherwise, please use VSCode).

1. Download and install the latest version of Julia (> v1.5) here: https://julialang.org/downloads/
2. Download and install Sublime Text here: https://www.sublimetext.com/download.
3. Open Sublime Text and install the Package Manager following these instructions: https://packagecontrol.io/installation.
4. Restart Sublime Text.
5. Open the Package Manager by typing `Cmd + Shift + p` (`Ctrl + Shift + p` in Windows).
6. Type `Install Package`, press enter on `Package Control: Install Package`.
7. Type `SendCode` and press enter when on the package name (if you don't see the Package's name is because you already installed it).
8. Repeat steps 5 & 6, and but now type `Julia` and press enter.
11. Open the Julia REPL in a terminal window (or tmux in Linux, or the respective in Windows). _Note_: You can create an alias to open julia from the command line by simply typing `julia`: in Mac, just paste this in your shell profile (e.g., edit the `.zshrc` file if using the zsh shell, usually located in your home folder): `alias julia="/Applications/Julia-1.x.app/Contents/Resources/julia/bin/julia"` (_Note_: change de `x` to the current version of Julia used), or point to the executable directory (you will have to edit this line accordingly if you have another version of Julia).
12. Download this file [https://github.com/ignacioq/julia_intro/julia_workshop.jl](https://github.com/ignacioq/julia_intro/blob/master/julia_workshop.jl), and open it in Sublime Text. _Note_: Julia files end in `.jl`.
13. Type `Cmd + Shift + p` (`Ctrl + Shift + p` in Windows) and type `SendCode: Choose Program` and press `Enter` on the program you want to send the code to (`terminal`, `Cmder` and `tmux` by default in Mac, Windows and Linux, respectively). _Note_: I use iTerm (https://www.iterm2.com) instead of the native OSX Terminal, and I use `SendCode: Choose Program`, `Enter` and choose `iTerm`.

You should be able to send code from Sublime into Julia by pressing `Cmd + Enter` (`Ctrl + Enter` in Windows). To evaluate Julia code, go to line `43` in the `julia_workshop.jl` file, which is the first julia command that appears.

You can also install the julia LSP package for sublime by following this instructions: https://github.com/sublimelsp/LSP-julia.


### Install some useful packages

Please install the following packages by typing `]` in the Julia prompt (i.e., `julia>`) to access the Package Manager (the prompt should change to be something like `(@v1.7) pkg>` if you are using Julia v1.7) and type the following:
```
add BenchmarkTools
add Distributions
add DataFrames
add RCall  # For interaction with R
add PyCall # For interaction with Python
add CSV
add JLD
```
Then precompile them by simply pressing `Del` (to exit the Package Manager) and then calling the packages into the global environment (using `using`): 
```
using BenchmarkTools, Distributions, DataFrames, RCall, PyCall, CSV, JLD
```
