$(document).ready(function(){
   $(window).on('scroll' , function(){
     const windowTop = $(window).scrollTop();
     const basket = document.getElementById("basket")
     if (basket) {
       if(windowTop > 100){
          basket.className = "basket-container-scrolled";
       }else{
          basket.className = "basket-container";
       };
     };
   });
});
