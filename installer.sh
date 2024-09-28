#!/bin/bash

main() {
    clear
    echo "=============================="
    echo " Sony Vegas Pro Installer"
    echo " Made with love by Sonka"
    echo "=============================="
    echo ""
    echo "Script version: V1"
    echo ""
    echo "1) Create a Wineprefix"
    echo "2) Install .NET & Vegas Pro"
    echo "3) Install additional software"
    echo "4) Auto install"
    echo "5) Exit"
    echo ""
    read -p "Choose an option: " CHOICE
}

wprefix() {
    echo ""
    echo "Wineprefix Options:"
    echo "1) Create a new Wineprefix"
    echo "2) Use the default Wineprefix"
    echo ""
    read -p "Choose an option: " WPC

    case $WPC in
        1)
            read -p "Enter the directory for your Wineprefix: " PREFIXDIR
            WINEPREFIX="$PREFIXDIR"
            echo "Creating a 64-bit Wineprefix at $WINEPREFIX..."
            WINEARCH=win64 WINEPREFIX=$WINEPREFIX winetricks win7
            killall wine wine64
            echo "Wineprefix created successfully!"
            ;;
        2)
            WINEPREFIX="$HOME/.wine64"
            export WINEARCH=win64
            export WINEPREFIX="$WINEPREFIX"
            echo "Setting up the default Wineprefix..."
            WINEPREFIX="$WINEPREFIX" winetricks win7
            echo "Default Wineprefix setup complete!"
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

    read -p "Enter the full path to the Vegas Pro setup: " VEGASPATH
    echo "Installing Vegas Pro from $VEGASPATH..."
    WINEPREFIX="$WINEPREFIX" wine "$VEGASPATH"
    echo "Vegas Pro installation complete (or failed)."
    read -p "Press Enter to continue..."
}

add() {
    read -p "Enter the full path to the software you want to install: " PATH
    echo "Installing software from $PATH..."
    WINEPREFIX="$WINEPREFIX" wine "$PATH"
    echo "Installation complete."
    read -p "Press Enter to continue..."
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
        4) auto ;;
        5) echo "Exiting..."; break ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done
