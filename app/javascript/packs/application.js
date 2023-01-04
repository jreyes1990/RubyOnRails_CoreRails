// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "startbootstrap-sb-admin-2/vendor/jquery/jquery";
import "@popperjs/core/dist/umd/popper";
import "startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.bundle";
import "startbootstrap-sb-admin-2/vendor/jquery-easing/jquery.easing";
//import "startbootstrap-sb-admin-2/js/sb-admin-2";
import "startbootstrap-sb-admin-2/vendor/fontawesome-free/js/all";

import "datatables.net/js/jquery.dataTables";

import "datatables.net-bs4/js/dataTables.bootstrap4";

import "datatables.net-buttons-bs4/js/buttons.bootstrap4";

import "datatables.net-buttons/js/dataTables.buttons";
import "datatables.net-buttons/js/buttons.flash";
import "datatables.net-buttons/js/buttons.colVis";
import "datatables.net-buttons/js/buttons.html5";
import "datatables.net-buttons/js/buttons.print";

import "moment/dist/moment";
import "moment/dist/locale/es";

let pdfMake = require("pdfmake/build/pdfmake");
let pdfFonts = require("pdfmake/build/vfs_fonts");
pdfMake.vfs = pdfFonts.pdfMake.vfs;

import "controllers"

document.addEventListener("turbolinks:load", () => {
  /* *******************************************************
   * Para controlar el sidebar en posición cerrado o abierto
   * ******************************************************** */
  $("#sidebarToggle, #sidebarToggleTop").on('click', function(e) {
    $("body").toggleClass("sidebar-toggled");
    $(".sidebar").toggleClass("toggled");
    if ($(".sidebar").hasClass("toggled")) {
      $('.sidebar .collapse').collapse('hide');
    };
  });

  $(window).resize(function() {
    // Cierre cualquier acordeón de menú abierto cuando la ventana cambie de tamaño a continuación 768px
    if ($(window).width() < 768) {
      $('.sidebar .collapse').collapse('hide');
    };

    // Cierre cualquier acordeón de menú abierto cuando la ventana cambie de tamaño a continuación 480px
    if ($(window).width() < 480 && !$(".sidebar").hasClass("toggled")) {
      $("body").addClass("sidebar-toggled");
      $(".sidebar").addClass("toggled");
      $('.sidebar .collapse').collapse('hide');
    };
  });
  /* *******************************************************
   * Fin para controlar el sidebar en posición cerrado o abierto
   * ******************************************************** */

  // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
  $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function(e) {
    if ($(window).width() > 768) {
      var e0 = e.originalEvent,
          delta = e0.wheelDelta || -e0.detail;
      this.scrollTop += (delta < 0 ? 1 : -1) * 30;
      e.preventDefault();
    }
  });

  // Scroll to top button appear
  $(document).on('scroll', function() {
    var scrollDistance = $(this).scrollTop();
    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  $("#topBtn").click(function () {
    $("html ,body").animate(
        {
          scrollTop: 0,
        },
        800
    );
  });

  // Smooth scrolling using jQuery easing
  $(document).on('click', 'a.scroll-to-top', function(e) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: ($($anchor.attr('href')).offset().top)
    }, 1000, 'easeInOutExpo');
    e.preventDefault();
  });

  //control de los tiempos de los flash
  $(".alert")
      .fadeTo(4000, 500)
      .slideUp(500, function () {
        $(".alert").slideUp(4000);
      });

  const originalWebSocketClose = WebSocket.prototype.close
  WebSocket.prototype.close = function () {
    if (this.readyState != WebSocket.CONNECTING) {
      originalWebSocketClose.apply(this, arguments)
    }
  }

});


