$(document).ready(function(){

  //add campus starts
  $("#campus-send").click(function(){
    var campus_email = $("#email-campus-input").val();
    if (campus_email !== ""){
      if (isValidEmailAddress(campus_email)){
        $.post("/campus", {"email": campus_email}, function(data, status){
          $("#campus-send").html("¡Gracias!");
          $("#email-campus-input").val("Pronto nos comunicaremos contigo");
          $("#email-campus-input").prop('disabled', true);
          $("#campus-send").prop('disabled', true);
        });
        alert("email_correcto");
      }else{
        alert("email incorrecto");
      }
    }else{
      alert("email vacio");
    }
  });
  //ad campus ends


  // ad form starts
  $("#more-info-basic").click(function(){
    $("input#ad-package-input").val("0");
  });

  $("#more-info-estandard").click(function(){
        $("input#ad-package-input").val("1");
  });
  $("#more-info-personalizado").click(function(){
        $("input#ad-package-input").val("2");
  });

  $("#ad-send").click(function(){
    var name = $("#ad-name-input").val();
    var company = $("#ad-company-input").val();
    var email = $("#ad-email-input").val();
    var ad_package = $("input#ad-package-input").val();

    var data = {"name": name, "company": company, "email": email, "package": ad_package}
    
    if (name !== "" && company !== "" && email !== "" && ad_package !== "") {
      if (isValidEmailAddress(email)) {
        $.post("/anuncio", data, function(data, status){
          $("#success-banner").css("visibility", "visible");
          $("#ad-modal").removeClass("in");
          $("#ad-modal-title").text("Pronto nos comunicaremos contigo");
          $("#ad-send").prop('disabled', true);
        });
      }else{
          alert("Ingresa un email válido");
      }
    }else{
        alert("Llena todos los campos por favor");
      }
  });
  //ad form ends

  function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^(("[\w-+\s]+")|([\w-+]+(?:\.[\w-+]+)*)|("[\w-+\s]+")([\w-+]+(?:\.[\w-+]+)*))(@((?:[\w-+]+\.)*\w[\w-+]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][\d]\.|1[\d]{2}\.|[\d]{1,2}\.))((25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\.){2}(25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\]?$)/i);
    return pattern.test(emailAddress);
  };
});