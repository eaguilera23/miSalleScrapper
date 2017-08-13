$(document).ready(function(){

  //add campus starts
  $("#campus-send").click(function(){
    var campus_email = $("#email-campus-input").val();
    alert(campus_email);
  });
  //ad campus ends


  // ad form starts
  $("#more-info-basic").click(function(){
    $("input#ad-package-input").val("1");
  });

  $("#more-info-estandard").click(function(){
        $("input#ad-package-input").val("2");
  });
  $("#more-info-personalizado").click(function(){
        $("input#ad-package-input").val("3");
  });

  $("#ad-send").click(function(){
    var name = $("#ad-name-input").val();
    var company = $("#ad-company-input").val();
    var email = $("#ad-email-input").val();
    var ad_package = $("input#ad-package-input").val();
    alert(ad_package);
  });
  //ad form ends
});