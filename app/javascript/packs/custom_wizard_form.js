document.addEventListener("turbolinks:load", () => {
  // ------------step-wizard-------------
  $(document).ready(function () {
    $('.nav-tabs > li a[title]').tooltip();
    
    //Wizard
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
      var target = $(e.target);
  
      if (target.parent().hasClass('disabled')) {
        return false;
      }
    });
  
    $(".next-step").click(function (e) {
      var active = $('.wizard .nav-tabs li.active');
      active.next().removeClass('disabled');
      nextTab(active);
    });

    $(".prev-step").click(function (e) {
      var active = $('.wizard .nav-tabs li.active');
      prevTab(active);
    });
  });
 
  function nextTab(elem) {
    $(elem).next().find('a[data-toggle="tab"]').click();

    var currStep = $(elem).next().data("step");
    $(".nav-tabs li").removeClass("active");
    $(".nav-tabs li[data-step='" + currStep + "']").addClass("active");

    // Actualizar progreso del progreso
    var progress = $(".progress-bar");
    var currentStep = $(elem).next().index() + 1;
    var totalSteps = $(".nav-tabs li").length;
    var progressValue = (currentStep - 1) / (totalSteps - 1) * 100;
    progress.css("width", progressValue + "%");
  }



  function prevTab(elem) {
    $(elem).prev().find('a[data-toggle="tab"]').click();

    // Actualizar progreso del progreso
    var progress = $(".progress-bar");
    var currentStep = $(elem).prev().index() + 1;
    var totalSteps = $(".nav-tabs li").length;
    var progressValue = (currentStep - 1) / (totalSteps - 1) * 100;
    progress.css("width", progressValue + "%");
}


  
  
  $('.nav-tabs').on('click', 'li', function() {
    $('.nav-tabs li.active').removeClass('active');
    $(this).addClass('active');
  });

});