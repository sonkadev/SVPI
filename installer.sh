#!/bin/bash

main() {
    clear
    echo "=============================="
    echo " Sony Vegas Pro Installer"
    echo " Made with love by Sonka"
    echo "=============================="
    echo ""
    echo "Script version: V2.1"
    echo ""
    echo "1) Create a Wineprefix"
    echo "2) Install .NET & Vegas Pro"
    echo "3) Install additional software"
    echo "4) Post-install fix (for MAGIX Vegas pro-s)"
    echo "5) Auto install"
    echo "6) Exit"
    echo ""
    read -p "Choose an option: " CHOICE
}

wprefix() {
    echo ""
    echo "Wineprefix Options:"
    echo "1) Create a new Wineprefix"
    echo "2) Use the default Wineprefix"
    echo "3) Use an already configured Wineprefix"
    echo "4) Set a wineprefix's architecture to 32/64 bit"
    echo ""
    read -p "Choose an option: " WPC

    case $WPC in
        1)
            read -p "Enter the directory for your Wineprefix: " PREFIXDIR
            WINEPREFIX="$PREFIXDIR"
            echo "Creating a 64-bit Wineprefix at $WINEPREFIX..."
            WINEARCH=win64 WINEPREFIX=$WINEPREFIX winetricks win10
#           WINEPREFIX= winetricks --force alldlls="builtin"
#           killall wine wine64
            echo "Wineprefix created successfully!"
            ;;
        2)
            WINEPREFIX="$HOME/.wine64"
            export WINEARCH=win64
            export WINEPREFIX="$WINEPREFIX"
            echo "Setting up the default Wineprefix..."
            WINEPREFIX="$WINEPREFIX" winetricks win10
            WINEPREFIX= winetricks --force alldlls="builtin"
            echo "Default Wineprefix setup complete!"
            ;;
        3)
            read -p "Enter the directory for your already confgured Wineprefix: " PREFIXDIR
            WINEPREFIX="$PREFIXDIR"
            export WINEPREFIX="$WINEPREFIX"
            echo "Selected $PREFIXDIR as a Wineprefix!"
            ;;
        4)
            read -p "Enter the directory for your already confgured Wineprefix: " PREFIXDIR
            WINEPREFIX="$PREFIXDIR"
            export WINEPREFIX="$WINEPREFIX"
            read -p "Wich architecture do you want to use? (32/64) " CHC
            case $CHC in
                32)
                    export WINEARCH=win32;;
                64)
                    export WINEARCH=win64;;
            esac
            ;;
        *)
            echo "Invalid option. Please try again."
            wprefix
            ;;
    esac
    read -p "Press Enter to continue..."
}

install() {

    read -p "Enter the .NET version to install (without dots, e.g., 472): " DNVER
    echo "Installing .NET version $DNVER..."
    WINEPREFIX="$WINEPREFIX" winetricks --force dotnet"$DNVER"
    echo ".NET installation complete (or failed)."

    read -p "Install MSVC Runtime 2013 & 2015? (y/n) "  CHC
    case $CHC in
        Y|y|YES|yes|Yes)
        WINEPREFIX="$WINEPREFIX" winetricks vcrun2013 vcrun2015
        ;;
        *)
        echo "k"
        ;;
    esac

    read -p "Install fonts? (y/n) "  CHC
    case $CHC in
        Y|y|YES|yes|Yes)
        WINEPREFIX="$WINEPREFIX" winetricks corefonts
        ;;
        *)
        echo "k"
        ;;
    esac

    read -p "Enter the full path to the Vegas Pro setup: " VEGASPATH
    echo "Installing Vegas Pro from $VEGASPATH..."
    WINEPREFIX="$WINEPREFIX" wine "$VEGASPATH"
    echo "Vegas Pro installation complete (or failed)."
    read -p "Press Enter to continue..."
}

add() {
    echo "!!!For some unknown reason, this part is not functional!!!"
    read -p "Enter the full path to the software you want to install: " PATH
    echo "Installing software from $PATH..."
    WINEPREFIX="$WINEPREFIX" wine "$PATH"
    echo "Installation complete."
    read -p "Press Enter to continue..."
}

post() {
    
    rm -rf $WINEPREFIX/drive_c/windows/system32/gecko
    rm -rf $WINEPREFIX/drive_c/windows/syswow64/gecko

    echo "Post install changes applied."
    read -p "Press enter to continue..."
}


auto() {
    echo "Auto-install feature coming soon!"
    read -p "Press Enter to continue..."
}

while true; do
    main
    case $CHOICE in
        1) wprefix ;;
        2) install ;;
        3) add ;;
        4) post ;;
        5) auto ;;
        6) echo "Exiting..."; break ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done
