import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {
    static targets = ['form'];

    submitForm(event) {
        let isValid = this.validateForm(this.element);
        let error = $('.form-error');

        if (!isValid) {
            event.preventDefault();

            error.addClass('form-error-show');
        } else {
            $('#newRoomModal').modal('hide');
        }

    }

    onBeforeDelete(e) {

    }

    validateForm() {
        let isValid = true;

        let requiredFieldSelectors = 'input:required';
        let requiredFields = this.element.querySelectorAll(requiredFieldSelectors);


        requiredFields.forEach((field) => {
            if (!field.disabled) {
                field.focus();
                isValid = field.value.trim().length > 5;
            }
        });


        return isValid;
    }
}