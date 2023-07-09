import Swal from 'sweetalert2'
import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for the Sweetalert Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  static values = {
    confirmAlert: String,
    cancelAlert: String,
    confirmTitle: String,
    cancelTitle: String,
    confirmBtn: String,
    cancelBtn: String
  }

  /*
   * Regular Stimulus lifecycle methods
   * Learn more at: https://stimulusjs.org/reference/lifecycle-callbacks
   *
   * If you intend to use this controller as a regular stimulus controller as well,
   * make sure any Stimulus lifecycle methods overridden in ApplicationController call super.
   *
   * Important:
   * By default, StimulusReflex overrides the -connect- method so make sure you
   * call super if you intend to do anything else when this controller connects.
  */

  connect() {
    super.connect()
    // add your code here, if applicable
    this.redirect = false;
  }

  procesoSatisfechoCenter(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    Swal.fire({
      title: 'Excelente',
      html: 'You clicked the button!',
      icon: 'success',
      position: 'center',
      timer: 1500,
      timerProgressBar: false,
      backdrop: true,
      confirmButtonColor: "#029b4f",
      showConfirmButton: false
    })
  }

  procesoAlertaCenter(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    Swal.fire({
      title: 'Alerta',
      html: 'Something went wrong!',
      icon: 'warning',
      position: 'center',
      timer: 1500,
      timerProgressBar: false,
      backdrop: true,
      confirmButtonColor: "#e89420",
      showConfirmButton: false
    })
  }

  procesoCanceladoCenter(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    Swal.fire({
      title: 'Cancelado',
      html: 'Something went wrong!',
      icon: 'error',
      position: 'center',
      timer: 1500,
      timerProgressBar: false,
      backdrop: true,
      confirmButtonColor: "#be2617",
      showConfirmButton: false
    })
  }

  procesoSatisfechoTopEnd(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    Swal.fire({
      title: 'Excelente',
      html: 'You clicked the button!',
      icon: 'success',
      position: 'top-end',
      timer: 1500,
      timerProgressBar: false,
      backdrop: true,
      confirmButtonColor: "#029b4f",
      showConfirmButton: false
    })
  }

  procesoAlertaTopEnd(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    Swal.fire({
      title: 'Alerta',
      html: 'Something went wrong!',
      icon: 'warning',
      position: 'top-end',
      timer: 1500,
      timerProgressBar: false,
      backdrop: true,
      confirmButtonColor: "#e89420",
      showConfirmButton: false
    })
  }

  procesoCanceladoTopEnd(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    Swal.fire({
      title: 'Cancelado',
      html: 'Something went wrong!',
      icon: 'error',
      position: 'top-end',
      timer: 1500,
      timerProgressBar: false,
      backdrop: true,
      confirmButtonColor: "#be2617",
      showConfirmButton: false
    })
  }

  procesoSatisfechoTopEndToast(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    const Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
      }
    })
    Toast.fire({
      icon: 'success',
      title: 'Signed in successfully'
    })
  }

  procesoAlertaTopEndToast(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    const Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
      }
    })
    Toast.fire({
      icon: 'warning',
      title: 'Signed in successfully'
    })
  }

  procesoCanceladoTopEndToast(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    const Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
      timer: 2000,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
      }
    })
    Toast.fire({
      icon: 'error',
      title: 'Signed in successfully'
    })
  }

  btnInactivar(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    const swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: 'btn btn-success btn-sm',
        cancelButton: 'btn btn-danger btn-sm'
      },
      buttonsStyling: true
    })

    swalWithBootstrapButtons.fire({
      title: this.confirmAlertValue,
      html: this.confirmTitleValue,
      icon: 'warning',
      toast: false,
      position: 'center',
      backdrop: false,
      background: "white",
      timer: 5000,
      timerProgressBar: true,
      showCancelButton: true,
      confirmButtonColor: "#029b4f",
      cancelButtonColor: "#be2617",
      confirmButtonText: this.confirmBtnValue,
      cancelButtonText: this.cancelBtnValue,
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        this.redirect = true;
        this.element.click();
      } else if (
        /* Read more about handling dismissals below */
        result.dismiss === Swal.DismissReason.cancel
      ) {
        swalWithBootstrapButtons.fire({
          title: this.cancelAlertValue,
          html: this.cancelTitleValue,
          icon: 'error',
          toast: false,
          backdrop: false,
          background: "white",
          timer: 5000,
          timerProgressBar: true
        })
      }
    })
  }

  btnConfirmar(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    const swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: 'btn btn-success btn-sm',
        cancelButton: 'btn btn-danger btn-sm'
      },
      buttonsStyling: true
    })

    swalWithBootstrapButtons.fire({
      title: this.confirmAlertValue,
      html: this.confirmTitleValue,
      icon: 'warning',
      toast: false,
      position: 'center',
      backdrop: false,
      background: "white",
      timer: 5000,
      timerProgressBar: true,
      showCancelButton: true,
      confirmButtonColor: "#029b4f",
      cancelButtonColor: "#be2617",
      confirmButtonText: this.confirmBtnValue,
      cancelButtonText: this.cancelBtnValue,
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        this.redirect = true;
        this.element.click();
      } else if (
        /* Read more about handling dismissals below */
        result.dismiss === Swal.DismissReason.cancel
      ) {
        swalWithBootstrapButtons.fire({
          title: this.cancelAlertValue,
          html: this.cancelTitleValue,
          icon: 'error',
          toast: false,
          backdrop: false,
          background: "white",
          timer: 5000,
          timerProgressBar: true
        })
      }
    })
  }

  btnProcesar(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    const swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: 'btn btn-success btn-sm',
        cancelButton: 'btn btn-danger btn-sm'
      },
      buttonsStyling: true
    })

    swalWithBootstrapButtons.fire({
      title: this.confirmAlertValue,
      html: this.confirmTitleValue,
      icon: 'warning',
      toast: false,
      position: 'center',
      backdrop: false,
      background: "white",
      timer: 5000,
      timerProgressBar: true,
      showCancelButton: true,
      confirmButtonColor: "#029b4f",
      cancelButtonColor: "#be2617",
      confirmButtonText: this.confirmBtnValue,
      cancelButtonText: this.cancelBtnValue,
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        this.redirect = true;
        this.element.click();

        if (result.value) {
          let timerInterval
          Swal.fire({
            title: this.procesoTitleValue,
            html: "<h4><strong style='color: #1d71b9;'>Espere por favor</strong></h4>",
            background: '#fff url(/images/loading_v1.gif)',
            //timer: 5000,
            //showLoaderOnConfirm: true,
            //imageUrl: 'assets/images/loading_v1.gif',
            //imageHeight: 40,
            timerProgressBar: true,
            /*
            didOpen: () => {
              Swal.showLoading()
              timerInterval = setInterval(() => {
                const content = Swal.getHtmlContainer()
                if (content) {
                  const b = content.querySelector('b')
                  if (b) {
                    b.textContent = Swal.getTimerLeft()
                  }
                }
              }, 50)
            },*/
            willClose: () => {
              clearInterval(timerInterval)
            }
          }).then((result) => {
            /* Read more about handling dismissals below */
            if (result.dismiss === Swal.DismissReason.timer) {
              //console.log('I was closed by the timer')
            }
          })
        }

      } else if (
        /* Read more about handling dismissals below */
        result.dismiss === Swal.DismissReason.cancel
      ) {
        swalWithBootstrapButtons.fire({
          title: this.cancelAlertValue,
          html: this.cancelTitleValue,
          icon: 'error',
          toast: false,
          backdrop: false,
          background: "white",
          timer: 5000,
          timerProgressBar: true
        })
      }
    })
  }

  btnInactivarToast(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    const swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: 'btn btn-success btn-sm',
        cancelButton: 'btn btn-outline-danger btn-sm'
      },
      buttonsStyling: true
    })

    swalWithBootstrapButtons.fire({
      title: this.confirmAlertValue,
      html: this.confirmTitleValue,
      icon: 'warning',
      toast: true,
      position: 'center',
      backdrop: false,
      background: "white",
      timer: 5000,
      timerProgressBar: true,
      showCancelButton: true,
      confirmButtonColor: "#029b4f",
      cancelButtonColor: "#be2617",
      confirmButtonText: this.confirmBtnValue,
      cancelButtonText: this.cancelBtnValue,
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        this.redirect = true;
        this.element.click();
      } else if (
        /* Read more about handling dismissals below */
        result.dismiss === Swal.DismissReason.cancel
      ) {
        swalWithBootstrapButtons.fire({
          title: this.cancelAlertValue,
          html: this.cancelTitleValue,
          icon: 'error',
          toast: true,
          backdrop: false,
          background: "white",
          timer: 5000,
          timerProgressBar: true
        })
      }
    })
  }

  btnConfirmarToast(event) {
    if (this.redirect) return;
    event.stopImmediatePropagation();
    event.preventDefault();

    const swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: 'btn btn-success btn-sm',
        cancelButton: 'btn btn-outline-danger btn-sm'
      },
      buttonsStyling: true
    })

    swalWithBootstrapButtons.fire({
      title: this.confirmAlertValue,
      html: this.confirmTitleValue,
      icon: 'warning',
      toast: true,
      position: 'center',
      backdrop: false,
      background: "white",
      timer: 5000,
      timerProgressBar: true,
      showCancelButton: true,
      confirmButtonColor: "#029b4f",
      cancelButtonColor: "#be2617",
      confirmButtonText: this.confirmBtnValue,
      cancelButtonText: this.cancelBtnValue,
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        this.redirect = true;
        this.element.click();
      } else if (
        /* Read more about handling dismissals below */
        result.dismiss === Swal.DismissReason.cancel
      ) {
        swalWithBootstrapButtons.fire({
          title: this.cancelAlertValue,
          html: this.cancelTitleValue,
          icon: 'error',
          toast: true,
          backdrop: false,
          background: "white",
          timer: 5000,
          timerProgressBar: true
        })
      }
    })
  }

  /* Reflex specific lifecycle methods.
   *
   * For every method defined in your Reflex class, a matching set of lifecycle methods become available
   * in this javascript controller. These are optional, so feel free to delete these stubs if you don't
   * need them.
   *
   * Important:
   * Make sure to add data-controller="sweetalert" to your markup alongside
   * data-reflex="Sweetalert#dance" for the lifecycle methods to fire properly.
   *
   * Example:
   *
   *   <a href="#" data-reflex="click->Sweetalert#dance" data-controller="sweetalert">Dance!</a>
   *
   * Arguments:
   *
   *   element - the element that triggered the reflex
   *             may be different than the Stimulus controller's this.element
   *
   *   reflex - the name of the reflex e.g. "Sweetalert#dance"
   *
   *   error/noop - the error message (for reflexError), otherwise null
   *
   *   reflexId - a UUID4 or developer-provided unique identifier for each Reflex
   */

  // Assuming you create a "Sweetalert#dance" action in your Reflex class
  // you'll be able to use the following lifecycle methods:

  // beforeDance(element, reflex, noop, reflexId) {
  //  element.innerText = 'Putting dance shoes on...'
  // }

  // danceSuccess(element, reflex, noop, reflexId) {
  //   element.innerText = '\nDanced like no one was watching! Was someone watching?'
  // }

  // danceError(element, reflex, error, reflexId) {
  //   console.error('danceError', error);
  //   element.innerText = "\nCouldn\'t dance!"
  // }

  // afterDance(element, reflex, noop, reflexId) {
  //   element.innerText = '\nWhatever that was, it\'s over now.'
  // }

  // finalizeDance(element, reflex, noop, reflexId) {
  //   element.innerText = '\nNow, the cleanup can begin!'
  // }
}
