var numTel = document.getElementById("inputPhone");

numTel.addEventListener("keyup", function () {
    if (numTel.value == "") {
        numTel.value = "+51 ";
    }
})
function onlyNumbers(e) {
    key = e.keyCode || e.wich;
    teclado = String.fromCharCode(key);
    numero = "0123456789";
    especiales = "8-37-38-46";
    tecladoEspecial = false;
    for (var i in especiales) {
        if (key == especiales[i])
            tecladoEspecial = true;
    }
    if (numero.indexOf(teclado) == -1 && !tecladoEspecial) {
        return false;
    }
} 
//Handler para el evento cuando cambia el input
//Elimina cualquier caracter espacio o signos habituales y comprueba validez
function validarInputRUC(input) {
    var ruc = input.value.replace(/[-.,[\]()\s]+/g, ""),
        resultado = document.getElementById("resultado"),
        valido;

    //Es entero?    
    if ((ruc = Number(ruc)) && ruc % 1 === 0
        && rucValido(ruc)) { // ⬅️ ⬅️ ⬅️ ⬅️ Acá se comprueba
        valido = "Válido";
        resultado.classList.add("ok");
    } else {
        valido = "No válido";
        resultado.classList.remove("ok");
    }

    resultado.innerText = "RUC: " + ruc + "\nFormato: " + valido;
}

// Devuelve un booleano si es un RUC válido
// (deben ser 11 dígitos sin otro caracter en el medio)
function rucValido(ruc) {
    //11 dígitos y empieza en 10,15,16,17 o 20
    if (!(ruc >= 1e10 && ruc < 11e9
        || ruc >= 15e9 && ruc < 18e9
        || ruc >= 2e10 && ruc < 21e9))
        return false;

    for (var suma = -(ruc % 10 < 2), i = 0; i < 11; i++ , ruc = ruc / 10 | 0)
        suma += (ruc % 10) * (i % 7 + (i / 7 | 0) + 1);
    return suma % 11 === 0;

}