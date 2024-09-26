main(){
clear
CHOICE=""
echo "Sony Vegas Pro installer"
echo "Made with love by Sonka"
echo ""
echo "Script version: V1"
echo ""
echo "1) Create a wineprefix"
echo "2) Install dotnet & vegas pro"
echo "3) Install additional stuff"
echo "4) Auto install"
echo "5) Exit"
read CHOICE
}

wprefix(){
    WPC=""
    echo "1) Make a wineprefix"
    echo "2) Use the default one"
    read WPC
while true; do
    case $WPC in
    1)
    read -p "Enter your prefix's directory: " PREFIXDIR
    WINEPREFIX="$PREFIXDIR"
    echo "Creating 64-bit Wineprefix at $WINEPREFIX"
    WINEARCH=win64 WINEPREFIX=$WINEPREFIX
    WINEPREFIX="$WINEPREFIX" winetricks win7
    killall wine wine64
    echo ""
    echo "Done making winprefix! Press enter to continue!"
     read
     break
     ;;
    2)
    WINEPREFIX="$HOME/.wine64"
    export WINEARCH=win64
    export WINEPREFIX="$WINEPREFIX"
    WINEPREFIX="$WINEPREFIX" winetricks win7
    echo ""
    echo "Done setting up default wineprefix! Press Enter to continue!"
    read
    break
    ;;
    esac
    export WINEPREFIX="$WINEPREFIX"
done
}

install(){
    DNVER=""
    echo "Enter the .NET version you want to install without dots."
    read DNVER
    WINEPREFIX="$WINEPREFIX" winetricks --force dotnet"$DNVER" 
    echo ".NET Successfully installed!(or not)"
    echo "Enter the Vegas Pro's setup path."
    VEGASPATH=""
    read VEGASPATH
    WINEPREFIX="$WINEPREFIX" wine "$VEGASPATH"
    echo "Vegas Pro successfully installed! (or not)"
    read
}

add(){
    echo "Install/open anything else you want."
    PATH=""
    read PATH
    WINEPREFIX="$WINEPREFIX" wine "$PATH"
    echo "Done."
    read
}

auto(){
    echo "soon, im lazy"
    read
}

while true; do 
    main
    case $CHOICE in
        1)
        wprefix
        ;;
        2)
        install
        ;;
        3)
        add
        ;;
        4)
        auto
        ;;
        5)
        break
        ;;
    esac
done

#100th line yippee