$('.type-it').typeIt({
  });
//detected terminal words
var span = $("#span");
span.html(span.html().replace(/blackpard/, '<span style="color: #3498db ; font-weight: bold; ">$&</span>'));

var span = $("#span");
span.html(span.html().replace(/~/, '<span style="color: #2ecc71 ; font-weight: bold; ">$&</span>'));

var span = $("#span2");
span.html(span.html().replace(/run/, '<span style="color: #e74c3c ; font-weight: bold; ">$&</span>'));

var span = $("#span2");
span.html(span.html().replace(/Error/, '<span style="color: #e74c3c ; font-weight: bold; ">$&</span>'));

//result proccess
setInterval(Timer, 3500);
  function Timer() {
    $(".result").show();
}


//controllers :D
$("button.close").click(function(){
    $(".window").hide();
    $(".afterclose").fadeIn("fast");
});

$("button.open").click(function(){
    $(".window").show();
    $(".afterclose").hide();
});

$("button.maximize").click(function(){  $(".window").addClass("windowmax");  
    $(".bash").addClass("bashmax");
    $(".windowmax").removeClass("window");          
    $(".bashmax").removeClass("bash");
});

$("button.minimize").click(function(){
    $(".bash").remove();
    $(".window").addClass("windowmin");
    $(".windowmin").removeClass("window");
});

