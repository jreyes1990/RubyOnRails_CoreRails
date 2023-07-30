document.addEventListener("turbolinks:load", () => {
  // control de los tiempos de los flash
  $(".alert")
    .fadeTo(4000, 500)
    .slideUp(500, function() {
      $(".alert").slideUp(4000);
  });
  // Fin del control de los tiempos de los flash
});
