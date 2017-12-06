Basic introduction to Julia

### Instructions to set up a workspace

(If you are on Windows, you need to have `Cmder` or `ConEmu` installed and be able to open the Julia REPL from there; otherwise, please use atom and the Juno distribution).

1. Download and install Sublime Text 3 here: https://www.sublimetext.com/3.
2. Open Sublime Text and install the Package Manager following these instructions: https://packagecontrol.io/installation.
3. Restart Sublime Text.
4. Open the Package Manager by typing `Cmd + Shift + p` (`Ctrl + Shift + p` in Windows).
5. Type `Install Package`, press enter on `Package Control: Install Package`.
6. Type `SendCode` and press enter when on the package name (If you don't see the Package's name is because you already installed it).
7. Repeat step 5, and but now type `Julia` and press enter.
8. Restart Sublime Text.
9. Open the Julia REPL in a terminal window.
10. Open the file `julia_workshop.jl` in Sublime Text.
11. Type `Cmd + Shift + p` (`Ctrl + Shift + p` in Windows) and type `SendCode: Choose Program` and press `enter` on the program you want to send the code to
(`terminal`, `Cmder` and `tmux` by default in Mac, Windows and Linux, respectively).

You should be able to send code from Sublime into Julia by pressing `Cmd + Enter` (`Ctrl + Enter` in Windows).
