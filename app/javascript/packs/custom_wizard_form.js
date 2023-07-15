document.addEventListener("turbolinks:load", () => {
  var nextSteps = document.querySelectorAll('.next-step');
  var prevSteps = document.querySelectorAll('.prev-step');
  var navTabs = document.querySelectorAll('.nav-tabs li');

  function validateFields(activeTab) {
    var requiredFields = activeTab.querySelectorAll('input[required], textarea[required], select[required]');
    var allValid = true;

    if (requiredFields.length > 0) {
      requiredFields.forEach(function (field) {
        if (!field.checkValidity()) {
          allValid = false;
          field.reportValidity();
        }
      });
    }

    return allValid;
  }

  function nextTab(elem) {
    //elem.nextElementSibling.querySelector('a[data-toggle="tab"]').click();
    $(elem).next().find('a[data-toggle="tab"]').click();
   
    // Actualizar progreso del progreso
    var progress = $(".progress-bar");
    var currentStep = $(elem).next().index() + 1;
    var totalSteps = $(".nav-tabs li").length;
    var progressValue = (currentStep - 1) / (totalSteps - 1) * 100;
    progress.css("width", progressValue + "%");
  }

  function prevTab(elem) {
    //elem.previousElementSibling.querySelector('a[data-toggle="tab"]').click();
    $(elem).prev().find('a[data-toggle="tab"]').click();

    // Actualizar progreso del progreso
    var progress = $(".progress-bar");
    var currentStep = $(elem).prev().index() + 1;
    var totalSteps = $(".nav-tabs li").length;
    var progressValue = (currentStep - 1) / (totalSteps - 1) * 100;
    progress.css("width", progressValue + "%");
  }

  // ------------step-wizard-------------
  $(document).ready(function () {
    // Deshabilita inicialmente todos los botones de navegación superior
    navTabs.forEach(function (tab, i) {
        if (i > 0) { // Si no es el primer botón
            tab.classList.add('disabled');
        }
    });

    navTabs.forEach(function (tab) {
      tab.addEventListener('click', function (e) {
        if (this.classList.contains('disabled')) {
          e.stopPropagation();
          return;
        }

        var activeTab = document.querySelector('.tab-pane.active');
        var activeNav = document.querySelector('.nav-tabs li.active');

        if (validateFields(activeTab)) {
          activeNav.classList.remove('active');
          this.classList.add('active');
          nextTab(activeNav);
        }
        e.preventDefault(); // Prevenir el comportamiento predeterminado
      });
    });

    $('.nav-tabs > li a[title]').tooltip();
    
    //Wizard
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
      var target = $(e.target);
  
      if (target.parent().hasClass('disabled')) {
        return false;
      }
    });
  
    $(".next-step").click(function (e) {
      var activeTab = document.querySelector('.tab-pane.active');
      var activeNav = document.querySelector('.nav-tabs li.active');
      //var active = $('.wizard .nav-tabs li.active');

      if (validateFields(activeTab)) {
        activeNav.nextElementSibling.classList.remove('disabled');
        nextTab(activeNav);
      }
      e.preventDefault(); // Prevenir el comportamiento predeterminado
    });

    $(".prev-step").click(function (e) {
      var active = $('.wizard .nav-tabs li.active');
      prevTab(active);
      e.preventDefault(); // Prevenir el comportamiento predeterminado
    });
  });
 
  

  $('.nav-tabs').on('click', 'li', function() {
    $('.nav-tabs li.active').removeClass('active');
    $(this).addClass('active');
  });

});