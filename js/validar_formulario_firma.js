var institucion=document.getElementById("institucion");
var nit=document.getElementById("nit");
var email=document.getElementById("email");
var password = document.getElementById("password")
, confirm_password = document.getElementById("password2");
function validateForm(){
    $('#alert_form').hide();
    $('#alert_email').hide();
    $('#alert_pass').hide();
    validar_nombre();
    validar_nit();
    validar_email();
    validar_password();
    validar_password2();
    if (institucion.value!="" & nit.value!="" & email.value!="" & validar_tipo_email($("#email").val())  & password.value!="" & password.value==confirm_password.value){
        crear_billetera();
    }
}
function validar_nombre(){
    if (institucion.value==""){
        console.log("nombre vacio");
        $('#alert_form').show();
        $('#institucion').removeClass('form-group').addClass('is-invalid form-group');
    }
    else {
        console.log("nombre: " + institucion.value);
        $('#institucion').removeClass('is-invalid form-group').addClass('is-valid form-control-sucess form-control');
    }
}
function validar_nit(){
    if (nit.value==""){
        console.log("nit vacio");
        $('#alert_form').show();
        $('#nit').removeClass('form-group').addClass('is-invalid form-group');
    }
    else {
        console.log("nit: " + nit.value);
        $('#nit').removeClass('is-invalid form-group').addClass('is-valid form-control-sucess form-control');
    }
}
function validar_email(){
    if (email.value==""){
        console.log("email vacio");
        $('#alert_form').show();
        $('#email').removeClass('form-group').addClass('is-invalid form-group');
    }
    else if (validar_tipo_email($("#email").val())){
        console.log("email: " + email.value);
        $('#email').removeClass('is-invalid form-group').addClass('is-valid form-control-sucess form-control');
        $('#alert_email').hide();
    }
    else {
        $('#alert_email').show();
    }
}
function validar_tipo_email(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}
function validar_password(){
    if(password.value=="") {
        console.log("password vacio");
        $('#alert_form').show();
        $('#password').removeClass('form-group').addClass('is-invalid form-group');
    }
    else {
        console.log("pass: " + password.value);
        $('#password').removeClass('is-invalid form-group').addClass('is-valid form-control-sucess form-control');
    }
}
function validar_password2(){
    if(password.value != confirm_password.value) {
        console.log("password no coincide");
        $('#alert_pass').show();
        $('#password2').removeClass('form-group').addClass('is-invalid form-group');
    }
    else {
        console.log("confirm_pass: " + confirm_password.value);
        $('#password2').removeClass('is-invalid form-group').addClass('is-valid form-control-sucess form-control');
        $('#alert_pass').hide();
    }
}