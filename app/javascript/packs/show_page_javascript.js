$(document).ready(function(){
   $(window).on('scroll' , function(){
     const windowTop = $(window).scrollTop();
     if(windowTop > 100){
        // $('#basket').classList.remove('basket-container')
        // $('#basket').classList.add('basket-container-scrolled');
        document.getElementById("basket").className = "basket-container-scrolled";
     }else{
        document.getElementById("basket").className = "basket-container";
     }
   });
});
