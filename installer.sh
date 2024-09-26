main(){
clear
CHOICE=""
echo "Sony Vegas Pro installer"
echo "Made with hate by Sonka"
echo ""
echo "Script version: \"Pre-release\""
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
    esac
done
}

install(){
    DNPATH=""
    echo "Enter .NET installer's path."
    read DNPATH
    wine "$DNPATH"
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
        5)
        break
        ;;
    esac
done

