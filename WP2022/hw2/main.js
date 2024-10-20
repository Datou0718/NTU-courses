let num = 6; 
let pinned = 1;
let pin_id = 6;
var quit = document.getElementsByClassName("quit");
var hover_bar = document.getElementsByClassName("hover_bar");
var user = document.getElementsByClassName("user");
var left_sub_win = document.getElementsByClassName("left_sub_win")[0];
var right_sub_win = document.getElementsByClassName("right_sub_win")[0];

for(let i = 0; i < 7; i++){
    quit[i].addEventListener("click", () => {Quit(i);});
    hover_bar[i].addEventListener("click", () => {pin(i);});
}

function Quit(i){
    user[i].style.display = "none";
    num--;
    if(i === 0 || num === 1){
        left_sub_win.style.display = "none";
        right_sub_win.style.width = "100vw";
        pinned = 0;
        pin_id = i;
        if(num === 1){
            user[6].style.display = "initial";
            pinned = -1;
        }
    }
    modify_size();
}

function modify_size(){
    if(pinned === 1){
        if(num >= 5){
            for(let i = 1; i < 7; i++){
                user[i].style.width = "12vw";
                user[i].style.height = "11vw";
            }
        }
        else if(num === 4){
            for(let i = 1; i < 7; i++){
                user[i].style.width = "24vw";
                user[i].style.height = "13vw";
            }
        }
        else if(num === 3){
            for(let i = 1; i < 7; i++){
                user[i].style.width = "24vw";
                user[i].style.height = "18vw";
            }
        }
        else if(num === 2){
            for(let i = 1; i < 7; i++){
                user[i].style.width = "24vw";
                user[i].style.height = "20vw";
                document.getElementsByClassName("photo")[i].style.width = "8vw";
                document.getElementsByClassName("photo")[i].style.height = "8vw";
                document.getElementsByClassName("mute")[i].style.width = "2vw";
                document.getElementsByClassName("mute")[i].style.height = "2vw";
                document.getElementsByClassName("hover_bar")[i].style.width = "10vw";
            }
        }
    }
    else{
        if(num > 4){
            for(let i = 1; i < 7; i++){
                user[i].style.width = "32vw";
                user[i].style.height = "20vw";
            }
        }
        else if(num >= 3){
            for(let i = 1; i < 7; i++){
                user[i].style.width = "48vw";
                user[i].style.height = "20vw";
            }
        }
        else if(num === 2){
            for(let i = 1; i < 7; i++){
                user[i].style.width = "48vw";
                user[i].style.height = "40vw";
                document.getElementsByClassName("photo")[i].style.width = "10vw";
                document.getElementsByClassName("photo")[i].style.height = "10vw";
                document.getElementsByClassName("mute")[i].style.width = "3vw";
                document.getElementsByClassName("mute")[i].style.height = "3vw";
                document.getElementsByClassName("hover_bar")[i].style.width = "12vw";
            }
        }
        else if(num === 1){
            for(let i = 1; i < 7; i++){
                user[i].style.width = "96vw";
                user[i].style.height = "40vw";
                user[i].style.backgroundColor = "rgb(32, 33, 37)";
                document.getElementsByClassName("photo")[i].style.width = "15vw";
                document.getElementsByClassName("photo")[i].style.height = "15vw";
                document.getElementsByClassName("mute")[i].style.width = "3vw";
                document.getElementsByClassName("mute")[i].style.height = "3vw";
                document.getElementsByClassName("hover_bar")[i].style.width = "13vw";
            }
        }
    }
}

user[6].style.display = "none";

function pin(i){
    if(pinned === 1){
        if(i === 0){
            user[pin_id].style.display = "initial";
            left_sub_win.style.display = "none";
            right_sub_win.style.width = "100vw";
            pinned = 0;
            pin_id = 0;
        }
        else{
            user[0].innerHTML = user[i].innerHTML;
            user[pin_id].style.display = "initial";
            pin_id = i;
            user[i].style.display = "none";
            quit[0].addEventListener("click", () => {Quit(0);});
            hover_bar[0].addEventListener("click", () => {pin(0);});
            document.getElementsByClassName("photo")[0].style.width = "15vw";
            document.getElementsByClassName("photo")[0].style.height = "15vw";
            document.getElementsByClassName("mute")[0].style.width = "3vw";
            document.getElementsByClassName("mute")[0].style.height = "3vw";
            document.getElementsByClassName("hover_bar")[0].style.width = "13vw";
        }
    }
    else if(pinned === 0){
        left_sub_win.style.display = "flex";
        right_sub_win.style.width = "25vw";
        user[0].innerHTML = user[i].innerHTML;
        user[pin_id].style.display = "initial";
        pin_id = i;
        user[i].style.display = "none";
        quit[0].addEventListener("click", () => {Quit(0);});
        hover_bar[0].addEventListener("click", () => {pin(0);});
        pinned = 1;
        document.getElementsByClassName("photo")[0].style.width = "15vw";
        document.getElementsByClassName("photo")[0].style.height = "15vw";
        document.getElementsByClassName("mute")[0].style.width = "3vw";
        document.getElementsByClassName("mute")[0].style.height = "3vw";
        document.getElementsByClassName("hover_bar")[0].style.width = "13vw";
    }
    modify_size();
}
