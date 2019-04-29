Basic introduction to Julia

### Instructions to set up a workspace

(If you are on Windows, you need to have `Cmder` or `ConEmu` installed and be able to open the Julia REPL from there; otherwise, please use Atom and the Juno distribution following these instructions: https://github.com/JunoLab/uber-juno/blob/master/setup.md).

1. Download and install Julia v1.1 here: https://julialang.org/downloads/
2. Download and install Sublime Text 3 here: https://www.sublimetext.com/3.
3. Open Sublime Text and install the Package Manager following these instructions: https://packagecontrol.io/installation.
4. Restart Sublime Text.
5. Open the Package Manager by typing `Cmd + Shift + p` (`Ctrl + Shift + p` in Windows).
6. Type `Install Package`, press enter on `Package Control: Install Package`.
7. Type `SendCode` and press enter when on the package name (if you don't see the Package's name is because you already installed it).
8. Repeat steps 5 & 6, and but now type `Julia` and press enter.
11. Open the Julia REPL in a terminal window (or tmux in Linux, or the respective in Windows).
12. Download this file `https://github.com/ignacioq/julia_intro/julia_workshop.jl`, and open it in Sublime Text.
13. Type `Cmd + Shift + p` (`Ctrl + Shift + p` in Windows) and type `SendCode: Choose Program` and press `enter` on the program you want to send the code to
(`terminal`, `Cmder` and `tmux` by default in Mac, Windows and Linux, respectively).

You should be able to send code from Sublime into Julia by pressing `Cmd + Enter` (`Ctrl + Enter` in Windows).

### Useful packages

Please install the following packages by typing `]` (to access the Package Manager) in the Julia prompt and type the following:
```
add BenchmarkTools
add Distributions
add DataFrames
add RCall # Requires R
add Plots
add GR
```
