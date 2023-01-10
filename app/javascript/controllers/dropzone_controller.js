import Dropzone from "dropzone";
import ApplicationController from './application_controller';
import {DirectUpload} from "@rails/activestorage";
import {
    getMetaValue,
    toArray,
    findElement,
    removeElement,
    insertAfter
} from "helpers";


/* This is the custom StimulusReflex controller for the Dropzone Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
    static targets = ["input"];

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
        this.dropZone = createDropZone(this);
        this.hideFileInput();
        this.bindEvents();
        Dropzone.autoDiscover = false; // necessary quirk for Dropzone error in console

        super.connect()
        // add your code here, if applicable
    }

    // Private
    hideFileInput() {
        this.inputTarget.disabled = true;
        this.inputTarget.style.display = "none";
    }

    bindEvents() {
        this.dropZone.on("addedfile", file => {
            setTimeout(() => {
                file.accepted && createDirectUploadController(this, file).start();
            }, 500);
        });

        this.dropZone.on("removedfile", file => {
            file.controller && removeElement(file.controller.hiddenInput);
        });

        this.dropZone.on("canceled", file => {
            file.controller && file.controller.xhr.abort();
        });
    }

    get headers() {
        return {"X-CSRF-Token": getMetaValue("csrf-token")};
    }

    get url() {
        return this.inputTarget.getAttribute("data-direct-upload-url");
    }

    get maxFiles() {
        return this.data.get("maxFiles") || 1;
    }

    get maxFileSize() {
        return this.data.get("maxFileSize") || 256;
    }

    get acceptedFiles() {
        return this.data.get("acceptedFiles");
    }

    get addRemoveLinks() {
        return this.data.get("addRemoveLinks") || true;
    }
}

class DirectUploadController {
    constructor(source, file) {
        this.directUpload = createDirectUpload(file, source.url, this);
        this.source = source;
        this.file = file;
    }

    start() {
        this.file.controller = this;
        this.hiddenInput = this.createHiddenInput();
        this.directUpload.create((error, attributes) => {
            if (error) {
                removeElement(this.hiddenInput);
                this.emitDropzoneError(error);
            } else {
                this.hiddenInput.value = attributes.signed_id;
                this.emitDropzoneSuccess();
            }
        });
    }

    createHiddenInput() {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = this.source.inputTarget.name;
        insertAfter(input, this.source.inputTarget);
        return input;
    }

    directUploadWillStoreFileWithXHR(xhr) {
        this.bindProgressEvent(xhr);
        this.emitDropzoneUploading();
    }

    bindProgressEvent(xhr) {
        this.xhr = xhr;
        this.xhr.upload.addEventListener("progress", event =>
            this.uploadRequestDidProgress(event)
        );
    }

    uploadRequestDidProgress(event) {
        const element = this.source.element;
        const progress = (event.loaded / event.total) * 100;
        findElement(
            this.file.previewTemplate,
            ".dz-upload"
        ).style.width = `${progress}%`;
    }

    emitDropzoneUploading() {
        this.file.status = Dropzone.UPLOADING;
        this.source.dropZone.emit("processing", this.file);
    }

    emitDropzoneError(error) {
        this.file.status = Dropzone.ERROR;
        this.source.dropZone.emit("error", this.file, error);
        this.source.dropZone.emit("complete", this.file);
    }

    emitDropzoneSuccess() {
        this.file.status = Dropzone.SUCCESS;
        this.source.dropZone.emit("success", this.file);
        this.source.dropZone.emit("complete", this.file);
    }
}

function createDirectUploadController(source, file) {
    return new DirectUploadController(source, file);
}

function createDirectUpload(file, url, controller) {
    return new DirectUpload(file, url, controller);
}

function createDropZone(controller) {
    return new Dropzone(controller.element, {
        url: controller.url,
        headers: controller.headers,
        maxFiles: controller.maxFiles,
        maxFilesize: controller.maxFileSize,
        acceptedFiles: controller.acceptedFiles,
        addRemoveLinks: controller.addRemoveLinks,
        autoQueue: false
    });

    /*TRADUCCION A ESPAÑOL*/
    Dropzone.prototype.defaultOptions.dictDefaultMessage = "Arrastra los archivos aquí para subirlos";
    Dropzone.prototype.defaultOptions.dictFallbackMessage = "Su navegador no admite cargas de archivos de arrastrar y soltar.";
    Dropzone.prototype.defaultOptions.dictFallbackText = "Utilice el formulario alternativo a continuación para cargar sus archivos como en los viejos tiempos.";
    Dropzone.prototype.defaultOptions.dictFileTooBig = "El archivo es demasiado grande ({{filesize}}MiB). Max filesize: {{maxFilesize}}MiB.";
    Dropzone.prototype.defaultOptions.dictInvalidFileType = "No puedes subir archivos de este tipo.";
    Dropzone.prototype.defaultOptions.dictResponseError = "El servidor respondió con el codigo {{statusCode}}.";
    Dropzone.prototype.defaultOptions.dictCancelUpload = "Cancelar carga.";
    Dropzone.prototype.defaultOptions.dictUploadCanceled = "Carga cancelada.";
    Dropzone.prototype.defaultOptions.dictCancelUploadConfirmation = "¿Estás seguro de que deseas cancelar esta carga?.";
    Dropzone.prototype.defaultOptions.dictRemoveFile = "Remover archivo.";
    Dropzone.prototype.defaultOptions.dictMaxFilesExceeded = "No puedes subir más archivos.";


    /* Reflex specific lifecycle methods.
     *
     * For every method defined in your Reflex class, a matching set of lifecycle methods become available
     * in this javascript controller. These are optional, so feel free to delete these stubs if you don't
     * need them.
     *
     * Important:
     * Make sure to add data-controller="dropzone" to your markup alongside
     * data-reflex="Dropzone#dance" for the lifecycle methods to fire properly.
     *
     * Example:
     *
     *   <a href="#" data-reflex="click->Dropzone#dance" data-controller="dropzone">Dance!</a>
     *
     * Arguments:
     *
     *   element - the element that triggered the reflex
     *             may be different than the Stimulus controller's this.element
     *
     *   reflex - the name of the reflex e.g. "Dropzone#dance"
     *
     *   error/noop - the error message (for reflexError), otherwise null
     *
     *   reflexId - a UUID4 or developer-provided unique identifier for each Reflex
     */

    // Assuming you create a "Dropzone#dance" action in your Reflex class
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
