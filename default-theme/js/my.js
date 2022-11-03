// Nav Bar
function toggleShowNav() {
    var Nav = document.getElementById("Nav");
    if (Nav.className.indexOf("w3-show") == -1) {
    Nav.className += " w3-show";
    } else {
    Nav.className = Nav.className.replace(" w3-show", "");
    }
}

function openDiv(ID) {
    var Div = document.getElementById(ID);
    if (Div.className.indexOf("w3-show") == -1) {
    Div.className += " w3-show";
    } else {
    Div.className = Div.className.replace(" w3-show", "");
    }
}

