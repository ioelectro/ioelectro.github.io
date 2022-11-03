// Nav Bar
function toggleShowNav() {
    var Nav = document.getElementById("Nav");
    if (Nav.className.indexOf("w3-show") == -1) {
    Nav.className += " w3-show";
    } else {
    Nav.className = Nav.className.replace(" w3-show", "");
    }
}
