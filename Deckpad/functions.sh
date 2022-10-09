function show_prompt {
    clear
    prompt="Tap To Quit !"
    if command -v figlet &> /dev/null
    then
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        figlet -c -w 180 -f big -k $prompt
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
    else
        echo "-----------------------------------"
        echo ""
        echo "         $prompt"
        echo ""
        echo "-----------------------------------"
    fi
}

function block_until_mouse_click {
    echo -e "\e[?1000h"
    read -n 12
}

function disable_sleep {
    sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
}

function reenable_sleep {
    sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
}

brightness_file=/sys/class/backlight/amdgpu_bl0/brightness
function set_brightness_to_minimum {
    cat $brightness_file > ./brightness_bak
    echo 0 > $brightness_file
}

function restore_brightness {
    cat ./brightness_bak > $brightness_file
    rm ./brightness_bak
}
